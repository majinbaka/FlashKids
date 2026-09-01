---
name: sync-docs
description: Use after every FlashKids code change, before reporting done — find the documentation the change invalidated (README, AGENTS.md, docs/, ADRs, feature READMEs, doc comments) and update it in the same change.
---

# Keep documentation in sync

A code change is not finished while a document still describes the old
behavior. Update the docs in the **same** change, not as a follow-up.

## What to check

Work through this list against your diff:

| You changed | Check |
|---|---|
| a route, path, or parameter | `README.md`, `docs/widgetbook_executable_spec.md`, navigation docs |
| `pubspec.yaml` dependencies | `README.md` "Included tooling", bootstrap commands |
| the repository layout or a new top-level folder | `AGENTS.md` "Repository map" |
| commands, scripts, or the verification flow | `README.md`, `AGENTS.md` "Definition of done" |
| a repository-wide decision (state, persistence, auth, boundaries) | write or supersede an ADR in `docs/adr/` |
| a public API, port, DTO, or serialized shape | the doc comment on the type, plus any spec that names it |
| a feature's rules or workflow | that feature's README, if it has one |
| something the spec described as proposed | mark it implemented — do not leave a proposal reading as if it were still pending |

## Rules

- Update the doc that is **wrong**, not every doc that mentions the area. A
  sweeping documentation rewrite is the same scope creep as an unrelated code
  fix.
- `docs/widgetbook_executable_spec.md` is a **proposal**. When you implement one
  of its phases, say so in the document; when you do not, leave its status line
  alone.
- Do not duplicate source code in documentation. Describe purpose, rules,
  contracts, and allowed/forbidden dependencies.
- Add a feature README only for a genuinely complex module.
- Write ADRs only for accepted repository-wide decisions — never for a local
  implementation choice. Do not silently contradict an accepted ADR; supersede
  it, document the migration, then implement.
- If you find a doc that already contradicted the code before your change, that
  is a separate problem — file it with `log-issue` rather than rewriting it.
- If a doc contradicts the change you are making, or two docs contradict each
  other about it, that is a conflict, not a doc chore. Ask the user which one is
  authoritative before editing either — do not decide it by rewriting the doc
  that disagrees with your code.

## Procedure

1. `git diff --name-only` — list what actually changed.
2. `grep -rn '<changed symbol, path, or command>' README.md AGENTS.md docs/`
   to find every document that names it.
3. Update only the statements the change made false.
4. Re-read the edited section as a new reader would; a half-updated paragraph is
   worse than a stale one.
5. Mention the updated documents in your summary.
