---
name: flutter-verify
description: Use before reporting any FlashKids code change complete — runs the Definition of Done (build_runner, format, analyze, test) and reviews the diff for unrelated edits, stale generated output, and contract changes.
---

# Verify before reporting done

Run this before you tell the user a change is finished. Do not report completion
on a change you have not verified, and do not silently skip a command — report
any that could not run and why.

## Commands

Regenerate first, but only when annotated sources changed:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Then, in order:

```sh
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Run the smallest relevant set for a local change. Expand to the **full suite**
whenever the change touches routing, shared state, dependencies, or generated
code.

If the Flutter SDK is not installed in this environment, say so explicitly
rather than implying the checks passed.

## Diff review

```sh
git status --short
git diff
```

Check for:

- Files you did not intend to touch — reformatting, renames, import reordering,
  or "while I was in there" fixes. Revert them.
- Generated `*.g.dart` / `*.freezed.dart` output that is stale or accidentally
  committed from an unrelated model.
- Secrets, tokens, or credentials.
- Dependency changes in `pubspec.yaml` / `pubspec.lock` the task did not ask for.
- Contract changes: routes, DTOs, repository interfaces, serialized shapes.

## Self-review

- Unnecessary abstraction or duplication introduced.
- Business logic sitting in a widget or an adapter.
- Dead code or leftover `TODO`.
- Weakened or skipped tests.
- Unsafe casts, `dynamic`, `// ignore`, or new analyzer exclusions.
- Backward-compatibility breaks without a stated migration.

## Report

State what you ran, what passed, what failed with its output, and what you did
not run. Then confirm the related docs were updated (`sync-docs`) and that any
unrelated problems you noticed were filed (`log-issue`) rather than fixed.
