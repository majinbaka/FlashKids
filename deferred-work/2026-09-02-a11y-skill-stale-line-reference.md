---
id: 2026-09-02-a11y-skill-stale-line-reference
title: flutter-a11y-kids-ui points at lib/main.dart:28 for the seeded color scheme, which is line 23
severity: low
status: fixed
found_during: writing design.md, the UI/UX and concept-style contract
date: 2026-09-02
---

## Summary

The `flutter-a11y-kids-ui` skill tells the reader to check the seeded Material 3
scheme at `lib/main.dart:28`, but `ColorScheme.fromSeed` is on line 23. Line 28
is inside `HomePage`'s class declaration region, not the theme.

## Where

- `.claude/skills/flutter-a11y-kids-ui/SKILL.md:57` — `(lib/main.dart:28)`
- `lib/main.dart:23` — `colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),`

## Expected vs. actual

**Expected:** the citation resolves to the `ColorScheme.fromSeed` call.

**Actual:** it resolves four lines past the end of `FlashKidsApp.build`'s theme
block, so an agent following the pointer reads the wrong code.

## Reproduction / evidence

Found by reading, not running: `grep -n deepPurple lib/main.dart` reports line
23; the skill text says 28.

## Suggested fix

Change the reference in `.claude/skills/flutter-a11y-kids-ui/SKILL.md` to
`lib/main.dart:23`, or drop the line number and cite the file. Touches one
documentation file; risks nothing in code or tests. A line number in a file that
is still moving will go stale again — citing the file alone is more durable.

## Not done because

Filed as deferred work because it was out of scope for the task that found it
(authoring `design.md`). The user then asked for it to be fixed immediately.

## Resolution

Fixed at the user's request, in the same change as `design.md`. The stale
numbers were corrected first, then — on the user's decision — every
`lib/main.dart` citation in the skills was converted to a file-plus-symbol
reference so it cannot go stale again when the file shifts:

- `.claude/skills/flutter-a11y-kids-ui/SKILL.md` — the seeded scheme is now
  cited as `ColorScheme.fromSeed` in `FlashKidsApp.build`, `lib/main.dart`.
- `.claude/skills/flutter-l10n/SKILL.md` — the same defect was found here, every
  citation stale by five lines. Now cited as `title: 'FlashKids'` in
  `FlashKidsApp.build`, `Text('FlashKids')` in `HomePage.build`, and
  `routerConfig` in `FlashKidsApp.build`.
- `design.md` was written with the same convention.

`docs/adr/0001-feature-first-slices-riverpod-go-router.md` cites
`lib/main.dart:1`, which is a file-level pointer and does not go stale; the
accepted ADR was left untouched. The `path/to/file.dart:42` examples in
`AGENTS.md`, `deferred-work/TEMPLATE.md`, `docs/adr/TEMPLATE.md`,
`.claude/commands/defer.md`, and `.claude/skills/log-issue/SKILL.md` are format
placeholders for one-off reports, not durable citations, and were left as they
are.
