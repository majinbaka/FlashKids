---
description: Run the FlashKids Definition of Done and review the diff before reporting a change complete
allowed-tools: Bash(flutter analyze), Bash(flutter test:*), Bash(dart format:*), Bash(dart run build_runner:*), Bash(git diff:*), Bash(git status:*)
---

Run the Definition of Done for the change currently in the working tree, following
the `flutter-verify` skill.

1. If annotated sources changed, regenerate first:
   `dart run build_runner build --delete-conflicting-outputs`
2. Then, in order:
   - `dart format --output=none --set-exit-if-changed .`
   - `flutter analyze`
   - `flutter test` — the full suite when the change touches routing, shared
     state, dependencies, or generated code; otherwise the smallest relevant set.
3. Review `git status --short` and `git diff` for unrelated edits, stale or
   accidental generated output, secrets, and dependency or contract changes.
4. Self-review per `flutter-verify`: unnecessary abstraction, business logic in a
   widget or adapter, dead code, weakened tests, unsafe casts or new analyzer
   suppressions, backward-compatibility breaks.

Report exactly what you ran, what passed, what failed with its output, and what
you did not run and why. If the Flutter SDK is not installed here, say so
plainly — never imply the checks passed. Confirm the docs `sync-docs` requires
were updated and that anything you noticed but did not fix was filed with
`log-issue`.
