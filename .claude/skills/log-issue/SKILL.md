---
name: log-issue
description: Use the moment you notice a bug, risk, dead code, or technical debt in FlashKids that the current task did not ask you to fix — write it to a file in `issues/` and keep going instead of fixing it.
---

# Log the issue, do not fix it

FlashKids' rule: **a discovered problem is reported, not repaired.** Fixing it
inside an unrelated change enlarges the diff, hides the real change under noise,
and ships an unreviewed decision. Write the file, mention it in your summary,
and continue the task you were given.

## When this applies

File an issue when, during any task, you notice:

- a bug or wrong behavior outside the current change's scope
- a broken, missing, or contradicted test
- dead code, a stale `TODO`, or an unused dependency
- an abstraction, layering, or dependency-direction violation
- documentation that contradicts the code
- a security, secret-handling, or validation gap
- a contract change that will break a consumer

## When this does not apply

- The problem **is** the task, or fixing it is required to make the requested
  change correct. Then fix it.
- It blocks you completely. Then file it *and* stop to report the blocker.
- The user explicitly says to fix what you find.

Never leave a broken build behind and call it an issue.

## Procedure

1. Confirm it is real — read the code, do not report a suspicion as a fact.
2. Pick a slug and write `issues/<YYYY-MM-DD>-<short-slug>.md` (use
   `date +%F` for the date). One issue per file.
3. Fill in `issues/TEMPLATE.md`. Include the exact `path/to/file.dart:42`
   references and, where you have one, the failing input or reproduction.
4. Do not touch the code the issue describes.
5. Name the file you created in your summary to the user.

## Template

Copy `issues/TEMPLATE.md`. Every issue needs: a one-line summary, severity,
where it lives (file:line), what actually happens vs. what should, how to
reproduce or where you saw it, and the suggested fix with its blast radius.

Keep it factual. State what you observed and what you inferred, separately, and
say plainly when you did not verify something.
