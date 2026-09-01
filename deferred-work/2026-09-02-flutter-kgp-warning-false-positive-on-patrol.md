---
id: 2026-09-02-flutter-kgp-warning-false-positive-on-patrol
title: Flutter's KGP detector flags `patrol` by regex even though patrol already migrated to built-in Kotlin, and threatens a future hard build failure
severity: low
status: open
found_during: installing Flutter 3.47.2 and scaffolding the android/ and web/ platform folders
date: 2026-09-02
---

## Summary

Every Android build prints a warning that `patrol` applies the Kotlin Gradle
Plugin and that "future versions of Flutter will fail to build" because of it.
The warning is a false positive: `patrol` migrated to built-in Kotlin in 4.7.0
and does not apply KGP on AGP 9. Flutter detects KGP by running a regex over
plugin build scripts rather than by inspecting Gradle's runtime plugin state, so
it matches a line that is guarded by an `if` and never executes. Nothing is
broken today; the risk is that Flutter promotes this same regex check to a hard
error, which would break the build of a plugin that is in fact already migrated.

## Where

- `android/gradle.properties:6` — `android.builtInKotlin=false`, written by the Flutter template
- `android/settings.gradle.kts:22` — `com.android.application` version `9.1.0`, so the AGP-9 branch is the one that applies
- `pubspec.yaml:27` — `patrol: any`, currently resolving to 4.9.0
- `~/.pub-cache/hosted/pub.dev/patrol-4.9.0/android/build.gradle:26-28` — the guard: `usesBuiltInKotlin` is read from `android.builtInKotlin`, and `apply plugin: "kotlin-android"` runs only `if (agpMajor < 9 || !usesBuiltInKotlin)`
- `~/.pub-cache/hosted/pub.dev/patrol-4.9.0/CHANGELOG.md:53` — 4.7.0: "Migrate to built-in Kotlin (#3084)"
- `$FLUTTER_ROOT/packages/flutter_tools/gradle/src/main/kotlin/FlutterPluginUtils.kt:135` — `kgpRegexGroovy`, which matches `^[ \t]*apply[ \t]+plugin[ \t]*:[ \t]*['"]kotlin-android['"]` regardless of any enclosing conditional
- `$FLUTTER_ROOT/packages/flutter_tools/gradle/src/main/kotlin/FlutterPluginUtils.kt:656` — the comment stating the check "inspects build script files directly via regex rather than querying Gradle plugin state at runtime", because runtime evaluation "leads to lifecycle and ordering issues" (gradle/gradle#36953)
- `$FLUTTER_ROOT/packages/flutter_tools/gradle/src/main/kotlin/FlutterPluginUtils.kt:621` — where the warning is emitted

## Expected vs. actual

**Expected:** a plugin that has migrated to built-in Kotlin and skips KGP on
AGP 9 produces no KGP warning, and carries no threat of a future build failure.

**Actual:** `patrol` is named in the warning on every Android build. The text
instructs the reader to "upgrade to a version that supports Built-in Kotlin",
which is already the case — 4.9.0 is the newest release and it is migrated — so
following the advice as written leads nowhere.

## Reproduction / evidence

Run and observed, not inferred:

```sh
flutter build apk --debug
# WARNING: Your app uses the following plugins that apply Kotlin Gradle Plugin (KGP): patrol
# Future versions of Flutter will fail to build if your app uses plugins that apply KGP.
# ...
# ✓ Built build/app/outputs/flutter-apk/app-debug.apk
```

The build succeeds. Setting `android.builtInKotlin=true` in
`android/gradle.properties` was tried and does **not** silence the warning — the
build still succeeded and the text was unchanged — which is what confirms the
detection is static rather than a reflection of what Gradle actually applied.
That experiment was reverted; `android/gradle.properties:6` is back to the
template's `false`.

Inferred, not verified: that a future Flutter release turns this warning into an
error while keeping the regex-based detection. The warning text asserts the
failure is coming, but no Flutter release notes were checked to confirm the
mechanism it will use.

## Suggested fix

Nothing to fix in this repository, and nothing to fix in `patrol`. Options, in
increasing cost:

1. Do nothing. Accept the noise in Android build logs. This is the right call
   while the warning stays a warning.
2. Set `android.builtInKotlin=true` in `android/gradle.properties`. It does not
   remove the warning, but it is the forward-compatible setting and it makes
   `patrol` take its non-KGP branch at build time. Blast radius: changes how
   Kotlin is compiled for every Android module; nothing in `lib/` or `test/`
   depends on it, and the debug APK built cleanly with it set.
3. If Flutter makes this an error and the regex is unchanged, the decision moves
   upstream: report it to Flutter as a false positive, or drop `patrol` for the
   SDK's `integration_test`, which cannot drive OS-level UI (permission dialogs,
   notifications, system settings). That trade-off should be revisited only when
   forced.

Watch: whether `patrol` restructures `android/build.gradle` so the guarded line
stops matching the regex, or whether Flutter switches to runtime detection.

## Not done because

Out of scope for the task that found it: the task was installing Flutter and
generating the platform folders, and the warning does not block that. There is
also nothing in this repository that is wrong — the fix, if one is ever needed,
belongs to Flutter or to `patrol`. Filed so the warning is not rediscovered and
misread as "patrol is outdated" the next time someone builds for Android.
