---
id: 2026-09-04-widgetbook-catalogue-skill-stale
title: Widgetbook catalogue skill says the executable does not exist
severity: low
status: open
found_during: shared flashcard component update
date: 2026-09-04
---

## Summary

The Widgetbook catalogue skill still describes the executable as absent even
though the repository includes its entry point and catalogue directory.

## Where

- `.agents/skills/widgetbook-catalogue/SKILL.md:15` — says no catalogue entry
  point or `widgetbook/` directory exists.
- `widgetbook/main.dart:5` — runs the existing Widgetbook executable.

## Expected vs. actual

**Expected:** The skill describes the repository's implemented Widgetbook
catalogue state.

**Actual:** It gives obsolete stop instructions for a catalogue that exists.

## Reproduction / evidence

Observed while reading the skill before changing the shared flashcard component.
`widgetbook/main.dart` and the `widgetbook/` directory are present in the
repository.

## Suggested fix

Update the skill's opening state and procedure to recognize the implemented
catalogue, preserving its existing placement and story-contract rules. This
touches only the project skill instructions.

## Not done because

Updating unrelated project-skill documentation is outside the flashcard UI task.
