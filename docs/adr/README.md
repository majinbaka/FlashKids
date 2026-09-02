# Architecture decision records

An ADR records an **accepted, repository-wide** decision: module boundaries,
state management, persistence, authentication, eventing, or API conventions. It
is not the place for a local implementation choice — see `AGENTS.md`,
"Architecture decisions".

- One decision per file, named `NNNN-short-slug.md`, numbered sequentially from
  `0001`. Copy `TEMPLATE.md`.
- `status:` is `proposed`, `accepted`, `superseded`, or `rejected`. A superseded
  record keeps its text and gains a `superseded_by:` line; it is never deleted
  or rewritten.
- Do not silently contradict an accepted ADR. Supersede it, document the
  compatibility and migration story, then implement incrementally.
- A proposal document — such as `docs/widgetbook_executable_spec.md` — is not an
  ADR. Only what an accepted record states is binding.

## Records

| # | Title | Status |
|---|---|---|
| [0001](0001-feature-first-slices-riverpod-go-router.md) | Feature-first slices, ports and adapters, Riverpod for state and DI, go_router for navigation | accepted |
