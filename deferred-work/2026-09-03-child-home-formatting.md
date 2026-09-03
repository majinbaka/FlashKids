---
id: 2026-09-03-child-home-formatting
title: Child Home screen does not satisfy the repository formatter
severity: low
status: open
found_during: splash screen asset and automatic launch transition
date: 2026-09-03
---

## Summary

`child_home_screen.dart` has one misindented widget subtree. It makes the
repository-wide format check fail even when the splash-screen change is
formatted.

## Where

- `lib/features/home/presentation/child_home_screen.dart:386` — the
  `TextButton.icon` child of `Semantics` is indented one level too far left.

## Expected vs. actual

**Expected:** `dart format --output=none --set-exit-if-changed .` exits zero.

**Actual:** it reports `Changed lib/features/home/presentation/child_home_screen.dart`.

## Reproduction / evidence

Running `dart format --output=none --set-exit-if-changed .` on 2026-09-03
reported this file. A `dart format --output=show` comparison shows only the
indentation change at the referenced subtree.

## Suggested fix

Run the Dart formatter on `lib/features/home/presentation/child_home_screen.dart`
in a dedicated formatting-only change, then run the repository format check.
The blast radius is limited to whitespace in that file.

## Not done because

This formatting defect predates and is unrelated to the splash-screen task.
