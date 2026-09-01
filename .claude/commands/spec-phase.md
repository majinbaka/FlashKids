---
description: Prepare one phase of the Widgetbook spec for implementation, and wait for approval before coding
argument-hint: <phase number, 0-7>
---

Prepare phase `$ARGUMENTS` of `docs/widgetbook_executable_spec.md` — the phases
are in section 11, "Implementation plan".

That document is a **proposal**. A phase is implemented only when a task
approves it, so this command stops at a plan.

1. Read the phase's section in the spec, plus `AGENTS.md`, `CLAUDE.md`, and any
   accepted ADR in `docs/adr/` that scopes it.
2. Report what the phase says should exist versus what actually exists in the
   repository today. Cite `path:line` for both sides.
3. Name the acceptance behavior in one sentence, then the minimum set of files
   the phase touches — per `flutter-feature-slice`. Anything outside that list
   is out of scope.
4. Name the public contracts at risk (routes, provider types, DTOs, serialized
   shapes) and the tests that should change.
5. Report any conflict between the phase and `AGENTS.md`, an accepted ADR, or
   the code, with both sides and your recommendation. Do not resolve it.
6. **Stop and wait for the user to approve the plan.** Do not create files,
   directories, or a Widgetbook entry point before that approval.

Once approved, implement only that phase, then mark it implemented in the spec
(`sync-docs`) and run `/dod`.
