---
name: project-knowledge
description: Use when the question is about FlashKids itself rather than a code change — what the product is, how the system is built, what already exists versus what is only proposed or undecided, where a rule lives, what is safe to work on next, or how a past decision was made. Answers from a pre-built digest instead of re-reading the repository.
---

# FlashKids system knowledge

This skill is the repository's **answer path**. Every other skill in
`.claude/skills/` tells you how to *change* something; this one tells you what
FlashKids *is* — product and technical — so a question can be answered without
scanning `AGENTS.md`, `design.md`, the ADR, the spec, and `lib/` from scratch
each time.

The digest lives in `references/`. Load only the file the question needs.

| The question is about | Read |
|---|---|
| the product, the audience, the Kid/Parent split, design principles, what a screen owes | `references/product.md` |
| the stack, the architecture, what code exists today, tests, CI, the agent harness | `references/system.md` |
| what is built vs. proposed vs. deliberately undecided, open debt, what to do next | `references/status.md` |
| which document is authoritative for a topic, and how to check this digest is still true | `references/sources.md` |

## The one rule that makes this safe

**This digest is a summary, never an authority.** `AGENTS.md`, the accepted
ADRs, `design.md`, and the code itself are the sources of truth, in that order
of precedence (`design.md` §0.1). The digest exists to save a scan, not to
replace a source.

So:

- **Answering a question** — answer from the digest. Cite the source document
  the answer comes from so the user can check it.
- **Acting on the answer** — writing code, approving a phase, deciding a
  contract — open the cited source first and confirm the digest still matches
  it. A summary that has drifted is exactly the kind of contradiction
  `CLAUDE.md` rule 5 exists for.
- **The digest and a source disagree** — that is a conflict. Report both sides
  with `path:line`, recommend which one to correct, and let the user decide
  (`AGENTS.md` → Conflicts). Do not quietly rewrite either one.

## Answering a question

1. **Classify it.** Product/business, technical, or status? Load that one
   reference file. Most questions need one, not four.
2. **Separate what exists from what is written down.** This is the single
   most common way to be wrong about FlashKids: the repository is a
   ~35-line bootstrap that is documented like a finished product. Three
   different statuses are in play, and `references/status.md` keeps them apart:
   - **built** — real code you can point at in `lib/`, `test/`, `.github/`
   - **binding but unbuilt** — `AGENTS.md`, ADR-0001, `design.md`: decided, and
     the code does not implement it yet
   - **proposed / undecided** — `docs/widgetbook_executable_spec.md`,
     `concepts/`, `design.md` §12: not decided, and not yours to settle
3. **Answer with the status attached.** "The parent gate is specified in
   `design.md` §9; no code implements it, and the challenge mechanism is
   explicitly undecided" is a correct answer. "The parent gate works like X"
   is not.
4. **Cite `file:section` or `file:line`.** Every claim in the digest is
   traceable to a source; carry the citation through to the user.
5. **Do not start coding off the back of a question.** A question is not a
   task. If the answer implies work, say what the work would be and stop —
   `AGENTS.md` and `CLAUDE.md` rule 2 both make scope the user's call.

## "What should I do next?"

That question has a defined answer in this repository, not an opinion:

1. Read `references/status.md` § *What to do next* — it lists the approved
   entry points in order, and what each one is blocked on.
2. The Widgetbook spec's phases (§11) are the roadmap, **and a phase is
   implemented only when a task approves it**. `/spec-phase <n>` prepares one
   and stops for approval; it does not authorise the work.
3. Anything in `design.md` §12 or `concepts/` needs a **product decision from
   the user** before any code. Present the decision, do not make it.
4. Open items in `deferred-work/` are candidates only when the user picks one;
   they were logged precisely so they would not be fixed opportunistically.

## Keeping the digest true

The digest was written from commit `3616f3c` (2026-09-02). Before relying on it
for anything you are about to *build*, run the check in
`references/sources.md` § *Freshness*.

When a change lands that makes a line here false, update this skill in the same
change — that is `CLAUDE.md` rule 4, and `sync-docs` lists this skill among the
documents a change can invalidate.
