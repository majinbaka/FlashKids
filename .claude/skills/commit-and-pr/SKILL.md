---
name: commit-and-pr
description: Use when committing FlashKids work, naming a branch, or opening a pull request — the repository's message convention, how to split a change into commits, and what a PR description must contain.
---

# Commits and pull requests

The commit history is the record of *why* the code is the way it is. Write for
the person who runs `git log` in a year, not for the diff viewer.

Commit only when the task asks for it. Never commit directly to `main` — the
history is branch-and-PR (`git log`: PRs #1–#3).

## Branches

`<type>/<short-kebab-slug>`, where `<type>` matches the change:

```text
feat/deck-review-screen
fix/router-redirect-loop
docs/conflict-confirmation-rule
chore/agent-tooling
```

Branch from the current `main` unless the task says otherwise.

## Messages

Conventional-commit subject, then a body that explains the reasoning:

```text
<type>: <imperative summary, lowercase, no trailing period>

Why this change exists and what it decides. Wrap at 72 columns.

- one bullet per notable part, when the change has several
```

- Types in use: `feat`, `fix`, `docs`, `chore`, `test`, `refactor`.
- The subject says what the change *does*, not what you did:
  `docs: rename issues/ to deferred-work/`, not `updated some docs`.
- The body carries the **why** — the constraint, the decision, the alternative
  not taken. The diff already shows the what.
- Reference the deferred-work file, ADR, or spec phase the change relates to.
- Keep the `Co-Authored-By:` trailer that the history already uses.

## Splitting a change

One commit per coherent decision. A reviewer should be able to read any single
commit and say yes or no to it on its own.

- Do not mix a refactor with a behavior change; do not mix a dependency bump
  with a feature.
- Regenerated `*.g.dart` / `*.freezed.dart` output belongs in the same commit as
  the annotated source that produced it — never in a separate "regenerate"
  commit, and never stale.
- A doc update that a code change made necessary belongs **with** that change
  (`sync-docs`), not in a follow-up commit.
- If the working tree contains an unrelated fix you made by accident, revert it
  rather than committing it (`flutter-verify`, diff review).

## Before you commit

Run the Definition of Done (`/dod`, `flutter-verify`) and review
`git status --short` for files the task did not ask about, accidental generated
output, and secrets. Never commit a secret, a token, or a `.env`.

## Pull requests

Title uses the same convention as the subject line. The description states:

- **What changes and why** — the problem, not a restatement of the file list.
- **Contracts touched** — routes, provider types, DTOs, serialized shapes,
  generated-model output — and the migration for any breaking one.
- **How it was verified** — the commands that ran and their result, and
  explicitly what could not run and why.
- **Open questions and conflicts** — anything the user decided during the work,
  and anything still undecided. A conflict must not reach the PR unmentioned
  (`CLAUDE.md`, rule 5).
- **Follow-ups filed** — the `deferred-work/` entries this work produced.

Open the PR against `main` with `gh pr create`. Do not merge it yourself unless
the user asks.
