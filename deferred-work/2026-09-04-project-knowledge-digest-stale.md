---
id: 2026-09-04-project-knowledge-digest-stale
title: Project knowledge digest does not match the implemented prototype
severity: medium
status: open
found_during: shared flashcard component update
date: 2026-09-04
---

## Summary

The project-knowledge status digest describes the repository at an old commit
and says the Widgetbook prototype and component vocabulary do not exist.

## Where

- `.claude/skills/project-knowledge/references/status.md:1` — identifies commit
  `3616f3c` from 2026-09-02 as its source.
- `.claude/skills/project-knowledge/references/status.md:31` — says none of the
  component vocabulary widgets exists.
- `widgetbook/main.dart:5` — runs the implemented Widgetbook prototype.

## Expected vs. actual

**Expected:** The project-knowledge digest is current enough to answer questions
about what the repository implements.

**Actual:** It describes an earlier bootstrap-only state and conflicts with the
existing prototype and shared presentation widgets.

## Reproduction / evidence

Observed while checking documentation affected by adding the shared `Flashcard`
component. The digest explicitly records an old source commit; the Widgetbook
entry point and `lib/app/presentation/` widgets are present in the working tree.

## Suggested fix

Regenerate or revise the project-knowledge references from the current
repository state, including the implemented Widgetbook prototype and component
inventory. This changes documentation only, but has broad impact on future
agent guidance.

## Not done because

Refreshing the whole project-knowledge digest is outside the flashcard UI task.
