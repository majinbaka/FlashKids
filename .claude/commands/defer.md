---
description: File a deferred-work item from the template instead of fixing it now
argument-hint: <short-slug describing the problem>
allowed-tools: Bash(date:*)
---

Today is !`date +%F`.

File the problem described as `$ARGUMENTS` in `deferred-work/`, following the
`log-issue` skill. Do not fix the code it describes.

1. Confirm the problem is real by reading the code — never file a suspicion as a
   fact. If it turns out not to be real, say so and file nothing.
2. Check `deferred-work/` for an existing file covering it. Update that one
   rather than creating a duplicate.
3. Create `deferred-work/<today>-<slug>.md` from `deferred-work/TEMPLATE.md`,
   filling every section: summary, `path/to/file.dart:42` references, expected
   vs. actual, reproduction or where you saw it, suggested fix with its blast
   radius, and why it was filed instead of fixed.
4. State what you observed and what you inferred separately, and say plainly
   when you did not verify something.
5. Name the file you created in your summary.

If this is a **conflict** on the current task's path — two sources that cannot
both be right — do not file it. Stop and put both sides to the user with
file:line references, per rule 5 in `CLAUDE.md`.
