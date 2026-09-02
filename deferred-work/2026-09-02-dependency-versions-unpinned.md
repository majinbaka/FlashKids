---
id: 2026-09-02-dependency-versions-unpinned
title: Every dependency is `any` and pubspec.lock is not committed, so no two resolves are guaranteed to match
severity: medium
status: open
found_during: adding agent tooling (settings, commands, ADRs, CI, boundary test)
date: 2026-09-02
---

## Summary

`pubspec.yaml` constrains no dependency beyond `any`, and `pubspec.lock` is not
committed. A developer machine, another developer's machine, and CI can each
resolve different versions of Riverpod, `go_router`, Freezed, and Widgetbook,
so "works here" does not imply "works there" and a green CI run does not pin
the versions it was green against.

## Where

- `pubspec.yaml:12` — the first `any` constraint; every direct dependency is `any` (`pubspec.yaml:9-27`)
- `.gitignore:13` — `pubspec.lock` ignored, per the decision recorded below
- `README.md:3-4` — states the `any` versions are intentional
- `.github/workflows/ci.yml` — the "Report resolved versions" step prints the
  lock CI resolved, which is the only record of what was tested

## Expected vs. actual

**Expected:** a build is reproducible — the same commit resolves the same
dependency versions on every machine and in CI.

**Actual:** each resolve independently picks the newest versions compatible with
the installed Flutter/Dart SDK. A breaking upstream release lands in the next
`flutter pub get`, on whichever machine runs it first, with no commit to point
at.

## Reproduction / evidence

Found by reading, not by running: the Flutter SDK is not installed in the
environment where this was filed, so no resolve was performed. `git ls-files`
confirms `pubspec.lock` has never been tracked, and `pubspec.yaml:9-27` shows
`any` on every direct dependency.

## Suggested fix

Two options, in increasing strength:

1. Commit `pubspec.lock` (remove it from `.gitignore`) while leaving
   `pubspec.yaml` at `any`. Resolution stays open when the lock is deliberately
   refreshed, but every checkout and CI run uses one recorded set.
2. Replace `any` with caret constraints in `pubspec.yaml` and commit the lock.

Blast radius is small today — no generated models, no platform folders, one
screen — and grows with every feature. Doing it before the first vertical slice
is much cheaper than after.

## Not done because

The user was asked and chose to keep `any` with the lock uncommitted for now.
This file records the risk and the fix so the decision can be revisited rather
than rediscovered.
