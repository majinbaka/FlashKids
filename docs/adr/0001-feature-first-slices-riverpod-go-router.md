---
id: 0001-feature-first-slices-riverpod-go-router
title: Feature-first slices, ports and adapters, Riverpod for state and DI, go_router for navigation
status: accepted
date: 2026-09-02
---

## Context

FlashKids is a single-package Flutter bootstrap. `lib/main.dart:1` holds the
composition root, a one-route `GoRouter`, and the only screen; there are no
feature directories. The dependencies for this architecture are already
installed (`pubspec.yaml:12`): `flutter_riverpod`, `go_router`,
`freezed`/`json_serializable`, `mocktail`, `widgetbook`, `patrol`.

`docs/widgetbook_executable_spec.md:1` proposes a feature-first,
ports-and-adapters direction and a phased Widgetbook plan, and states that it is
a proposal rather than an implemented contract.

The nine skills in `.claude/skills/` already write rules that assume exactly
that architecture — `flutter-feature-slice/SKILL.md:29` prescribes the slice
layout, `flutter-riverpod-state/SKILL.md:39` prescribes ports and provider
overrides — while `AGENTS.md` recorded, until this file, that no ADR had been
accepted. The architecture was therefore being enforced day to day without ever
having been decided. This record closes that gap.

## Decision

1. **State management and dependency injection are Riverpod.** There is no
   service locator and no global mutable state. A provider is the injection
   point; tests and Widgetbook substitute dependencies through `overrides:` on a
   scoped `ProviderScope`.
2. **Navigation is `go_router`.** Routes are a public contract: one router
   definition serves production and any future prototype runtime, and a
   runtime-specific start destination is a parameter, not a forked router.
3. **Code is organised feature-first**, in the layout
   `lib/features/<feature>/{presentation,application,domain,infrastructure}`,
   with app-wide composition and routing under `lib/app/` and cross-feature
   external implementations under `lib/infrastructure/`. Directories are created
   only when a task actually needs them.
4. **The dependency direction is presentation → application/domain ports ←
   infrastructure adapters.** `domain/` and `application/` must not import
   `package:flutter/*`, `go_router`, Widgetbook, HTTP clients, or storage
   implementations. `lib/` must never import `widgetbook/` or `test/`.
5. **One file, one purpose, 400 lines hard cap**, split along a testable
   responsibility boundary.
6. **`test/` mirrors the source subtree** it covers.

## Consequences

- The skills and `CLAUDE.md` now rest on an accepted decision rather than on a
  proposal, so a change that follows them is compliant by definition.
- Clause 4 is machine-checkable and is enforced by
  `test/architecture/import_boundaries_test.dart`, which is vacuous until
  `lib/features/` exists and starts failing the moment a slice violates it.
  Clauses 3, 5, and 6 remain review rules.
- The migration is **not** authorised as a side effect of unrelated work.
  `lib/main.dart` keeps owning app behavior until a task approves moving a
  responsibility out of it — `AGENTS.md:85` still governs that.
- Introducing a competing state-management, DI, or navigation library now
  requires superseding this record.

## Scope

This record decides the architecture named above. It does **not** decide:

- the Widgetbook catalogue, its information architecture, or the phased plan in
  `docs/widgetbook_executable_spec.md` — that document stays a proposal, and its
  phases are implemented one at a time when a task approves one;
- persistence, an API client, authentication, logging, or an eventing
  convention. None exists; each needs its own record when it is introduced;
- the error model. `.claude/skills/flutter-error-handling/SKILL.md` records the
  convention to apply at the first real boundary, and that first implementation
  is what a later ADR would ratify.

## Alternatives considered

- **Leave the architecture as a proposal.** Rejected: the skills already enforce
  it, so the repository would keep applying an undecided architecture, and
  `AGENTS.md`'s "no accepted ADR" would keep contradicting them.
- **Layer-first (`lib/screens/`, `lib/models/`, `lib/services/`).** Rejected: a
  feature change fans out across every top-level directory, and nothing pins
  ownership of a behavior to one place.
- **A service locator (`get_it`) for DI alongside Riverpod.** Rejected: two
  injection mechanisms, and the locator's global mutable registry is what
  clause 1 exists to prevent. Riverpod already does both jobs.
- **`Navigator` 1.0 directly.** Rejected: deep links and typed route parameters
  are requirements of the proposed flows, and redirect policy needs one place to
  live.
