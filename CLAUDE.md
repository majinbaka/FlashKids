# CLAUDE.md

Guidance for Claude Code in the FlashKids repository.

`AGENTS.md` is the binding contract for this repo — read it before any code
change. This file adds the always-on working rules and indexes the skills.

## What this is

A single-package Flutter bootstrap (`pubspec.yaml`, Dart 3.9+, Material 3), not
yet a feature architecture. `lib/main.dart` currently owns the composition root,
a one-route `GoRouter`, and the only screen. Riverpod for state and dependency
injection, `go_router` for navigation, `flutter_test` + Mocktail for tests,
Freezed/`json_serializable`/`build_runner` for generation, Widgetbook and Patrol
installed but with **no** catalogue entry point and no `integration_test/` suite.

`docs/widgetbook_executable_spec.md` is a **proposal**. It is not evidence that
any file, route, layer, or story it describes exists.

There is no database, API client, auth, logging framework, CI workflow, or
accepted ADR. Do not invent their conventions.

## Always-on rules

**1. One file, one purpose, under 400 lines.**
Every file has a single responsibility you can name in one sentence without
"and". 400 lines is a hard cap — split before crossing it, along a testable
responsibility boundary, never into `_helpers.dart` or `part2`.

**2. Change the minimum, precisely.**
Touch only what the task requires. No renaming, reformatting, reordering
imports, restyling, or refactoring code the task did not ask about — even when
it is obviously improvable. Name the minimum set of files before editing and
treat anything outside it as out of scope. Prefer duplication twice over the
wrong abstraction once.

**3. Log issues, do not fix them.**
A problem you notice while doing something else goes in `issues/` as
`YYYY-MM-DD-slug.md` from `issues/TEMPLATE.md`, and you keep going. Fix it only
when it *is* the task, when the requested change is wrong without it, or when
the user asks. See the `log-issue` skill.

**4. Code change ⇒ doc update, same change.**
Update the documentation the change made false — `README.md`, `AGENTS.md`,
`docs/`, ADRs, doc comments — before reporting done. Update what is wrong, not
everything nearby. See the `sync-docs` skill.

**5. Conflict ⇒ confirm with the user.**
Two sources that cannot both be right — code vs. doc, doc vs. doc, the task vs.
`AGENTS.md` or an ADR, a test vs. the requirement — stop the affected part and
put both sides to the user with file:line references and your recommendation.
Never pick a side yourself, never delete or rewrite the losing statement to make
the contradiction disappear, never leave it out of your summary. Rule 3 is for a
problem you can walk past; a conflict is a decision that is the user's to make.

## Skills

In `.claude/skills/`. Invoke by name; they assume `AGENTS.md` and the rules
above.

| Skill | Use when |
|---|---|
| `flutter-feature-slice` | adding a feature or moving behavior out of `main.dart`; file placement and layering |
| `flutter-widget-ui` | any screen, widget, or Widgetbook story |
| `flutter-riverpod-state` | providers, notifiers, controllers, view state, overrides |
| `flutter-routing` | adding, renaming, removing, or redirecting a `go_router` route |
| `flutter-data-model` | models, DTOs, Freezed, JSON, `build_runner` |
| `flutter-testing` | unit, widget, golden, or Patrol tests; bug regressions |
| `flutter-verify` | before reporting any change complete |
| `log-issue` | you found a problem outside the current task |
| `sync-docs` | after a code change, to find the docs it invalidated |

## Commands

```sh
flutter pub get
dart pub global activate patrol_cli
dart run build_runner build --delete-conflicting-outputs   # when annotated sources changed
```

Definition of Done — run the smallest relevant set, the full suite for routing,
shared state, dependency, or generated-code changes:

```sh
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

```sh
flutter test test/features/deck/               # a subtree
flutter test --name 'renders the empty state'  # by name
```

Platform folders are not generated yet; `flutter create .` adds them once target
platforms are decided.
