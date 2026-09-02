# FlashKids agent guardrails

This file applies to the whole repository. FlashKids is currently a **single-package
Flutter bootstrap**, not yet the feature architecture proposed in
`docs/widgetbook_executable_spec.md`. Treat that document as a proposal, not as an
implemented contract. Add a nested `AGENTS.md` only when a real subtree develops
different commands or boundaries; do not copy this file into feature folders.

## Repository map

- `lib/main.dart`: current production entry point, `ProviderScope`, app shell,
  `GoRouter`, and placeholder Home UI. Until modules exist, it owns app behavior.
- `test/`: Flutter unit/widget tests. Mirror a new source subtree when features
  are introduced; keep behavior tests near the corresponding test subtree.
- `docs/widgetbook_executable_spec.md`: proposed feature-first, ports-and-adapters
  direction and phased Widgetbook plan. It is not an ADR or evidence that the
  proposed files, routes, domain, infrastructure, or Widgetbook executable exist.
- `design.md`: the normative UI/UX and concept-style contract — audience, Kid
  Zone / Parent Zone split, visual language, sizing, motion, copy, and the UI
  Definition of Done. It decides how UI must look and behave; it is not evidence
  that any screen, token, or component it names exists.
- `pubspec.yaml`: the sole Dart/Flutter package manifest. Use Flutter's bundled
  Dart and `flutter pub`; this is not a monorepo.
- `analysis_options.yaml`: `flutter_lints` plus the repository's analyzer rules.
- `CLAUDE.md`: Claude Code's entry point. Restates this file's scope, adds the
  always-on working rules, and indexes the skills.
- `.claude/skills/`: task-scoped skills (feature slice, widget/Widgetbook, Riverpod
  state, routing, data models, testing, verification, issue logging, doc sync,
  localization, accessibility, error handling, persistence, Widgetbook catalogue,
  commits and PRs).
- `.claude/commands/`: slash commands — `/dod`, `/defer`, `/spec-phase`.
- `.claude/settings.json`, `.claude/hooks/`: the Claude Code harness for this
  repository — a permission allowlist, a deny rule on hand-editing generated
  files, and a PostToolUse hook that formats the Dart file just written.
- `docs/adr/`: accepted repository-wide decisions. `0001` binds the architecture.
- `deferred-work/`: problems found while doing something else, logged rather
  than fixed. One file per item from `deferred-work/TEMPLATE.md`.
- `test/architecture/`: tests that enforce architecture rules rather than
  behavior. Currently the ADR-0001 import-boundary check.
- `.github/workflows/ci.yml`: runs the Definition of Done on push and pull
  request.

Current stack: Dart 3.9+, Flutter/Material 3, Riverpod for state/dependency
injection, `go_router` for navigation, `flutter_test`/Mocktail for tests, and
Freezed/JSON/build_runner for generation when models actually require them.
Patrol and Widgetbook are installed but no integration suite or catalogue entry
point exists. There is no database, API client, authentication/authorization, or
logging framework yet; do not invent their conventions — `flutter-persistence`
and `flutter-error-handling` govern the first one introduced. The architecture
is settled by `docs/adr/0001-feature-first-slices-riverpod-go-router.md`, which
does not authorise migrating to it as a side effect.

## Workflow (MUST)

Before coding:

1. Read every `AGENTS.md` that scopes the target file, then the relevant README,
   spec, and any accepted ADR in `docs/adr/` that scopes it.
2. Identify the primary owning module, affected modules, and dependency impact.
   In today's flat bootstrap, name the responsibility in `lib/main.dart`; do not
   pretend a proposed feature exists.
3. Search for the closest implementation and test. Follow a reasonable existing
   pattern rather than introducing a theoretically cleaner competing pattern.
4. State the acceptance behavior, minimum affected files, public contracts at
   risk, and tests that should change.
5. Implement the smallest change that correctly satisfies the requirement.

Before reporting completion:

1. Run the relevant commands below and report commands that could not run.
2. Review `git diff` and `git status --short` for unrelated files, accidental
   generated output, secrets, and dependency/contract changes.
3. Check for unnecessary abstractions or duplication, wrong-layer business
   logic, dead code/TODOs, weakened tests, unsafe casts/suppressions, and backward
   compatibility issues.

## Conflicts (MUST)

A conflict is two sources that cannot both be right: code contradicting a
document, one document contradicting another, the requested change contradicting
`AGENTS.md` or an accepted ADR, or a test contradicting the stated requirement.

- Stop and ask the user. Give both sides with a `path/to/file.dart:42` reference
  for each, what you were about to do, the options, and your recommendation.
  Wait for the decision before touching either side.
- Never resolve one on your own judgment and never hide one. Do not silently
  pick the code over the doc or the doc over the code, do not rewrite or delete
  the losing statement, do not weaken a test to agree with the code, and do not
  omit the contradiction from your summary because the task still "worked".
- Do everything the conflict does not block first, then ask about the part it
  blocks. One ambiguous line does not stall the whole task.
- A conflict outside the current task that blocks nothing is deferred work: log
  it in `deferred-work/` and keep going. A conflict on the current task's path is
  a question for the user, not a deferred-work file.
- Once the user decides, record the decision where it belongs — the doc update
  in the same change, an ADR for a repository-wide call — so the next change
  does not re-litigate it.

## Architecture and ownership (MUST)

- Preserve the architecture that exists; consistency is more important than
  theoretical purity. Do not perform the proposed architecture migration as a
  side effect. Implement its phases incrementally only when a task approves one.
- When feature modules are introduced, keep UI, state/controller, domain rules,
  adapters, and tests owned by that feature. App-wide composition and routing
  belong under `lib/app/`; external implementations belong under
  `lib/infrastructure/`. Production code must never import `widgetbook/` or
  `test/` code.
- Dependency direction for new feature slices is presentation ->
  application/domain ports <- infrastructure adapters. Domain/application code
  must not import Flutter widgets, GoRouter, Widgetbook, storage/database
  implementations, HTTP clients, or external SDK implementations.
- UI renders state, collects input, dispatches actions, and handles presentation
  concerns. Put validation, calculations, and business workflows in the owning
  feature's application/domain code; do not query storage/API code from widgets.
  Adapters translate and persist data; they do not decide business policy.
- Keep code local to its owning feature by default. Move it to `core`, `shared`,
  `common`, `utils`, or `helpers` only after multiple real modules depend on a
  stable concept. These directories are not dumping grounds.
- For a cross-module change, record the primary owner, affected consumers, why
  the change cannot remain local, and the dependency impact. Treat it as higher
  risk and test each affected contract.
- Keep functions and files cohesive. Rough sizes of 40 lines per function, 200
  per class, 300 per file, or more than three nested condition levels are review
  prompts, not limits. Split only along a testable responsibility boundary.

## Change discipline (MUST)

- Do not refactor unrelated code. Do not rename, move, reformat, or reorganize
  unrelated files. Report unrelated technical debt instead of fixing it: log it
  in `deferred-work/` as `YYYY-MM-DD-slug.md` and continue the current task.
- Keep each file to a single stated purpose. The ~300-line size above is a review
  prompt; 400 lines is a hard cap. Split at the cap along a testable
  responsibility boundary, never into a `_helpers.dart` dumping ground.
- Do not introduce `BaseRepository`, `GenericRepository`, `BaseService`,
  `AbstractService`, Manager, a handler framework, Factory, Provider, Wrapper,
  Helper, utility layer, or another generic abstraction to future-proof code.
  An abstraction is justified only when multiple concrete usages need it, it
  removes real duplication or enforces an important boundary, and existing
  architecture cannot solve the problem cleanly. Prefer duplication twice over
  the wrong abstraction once.
- Prefer simple, explicit, local, testable, and consistent code over generic,
  clever, framework-like code. Solve today's confirmed requirement; do not
  implement hypothetical requirements.
- Protect routes/API shapes, DTOs, shared types, serialized or persisted data,
  repository interfaces, generated-model contracts, and any future database
  schema/events. Before a breaking change, identify consumers, explain impact,
  provide an incremental migration, and update contract/behavior tests.
- No database convention currently exists. If persistence is introduced, define
  its migration/transaction/rollback rules with the first implementation. Never
  rewrite an applied migration or make a destructive schema change silently.
- Follow the existing error model in the owning code. Do not create a separate
  error convention per feature. Preserve actionable context at boundaries and
  do not swallow failures.

## Tests and type safety (MUST)

- Derive tests from acceptance behavior. Business rules and behavior changes
  require tests. For a bug, first reproduce it with a failing regression test
  when practical, then make that test pass. Assert outcomes, not private
  implementation details; do not add meaningless coverage tests.
- Never pass a failing test by weakening/removing its assertion, skipping it, or
  changing expected behavior unless the requirement explicitly changed. Report
  conflicts between requirements and tests.
- Do not use `dynamic`, broad `Object`, unchecked/forced casts, `// ignore`,
  analyzer exclusions, or lint suppression merely to silence tooling. If an
  external boundary requires one, keep it narrow and document the reason. Do not
  hand-edit `*.g.dart` or `*.freezed.dart`.

## Security and operations (MUST)

- Never hardcode or commit secrets. Never disable authentication/authorization
  to make code or tests pass, bypass validation without explicit justification,
  or trust external input without validation at its boundary.
- Do not log credentials, tokens, secrets, or sensitive payloads. Use the
  repository's logging/error convention if one is introduced; do not add
  unstructured prints or hot-path logging as an isolated convention.
- If tenant isolation, roles, or permissions are introduced, enforce them at the
  application/data boundary as well as in UI visibility and add denial tests.

## Definition of done

Run the smallest relevant set, expanding to the full suite for shared routing,
state, dependency, or generated-code changes:

```sh
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

When annotated/generated sources change, regenerate before the checks:

```sh
dart run build_runner build --delete-conflicting-outputs
```

`.github/workflows/ci.yml` runs exactly these commands on push to `main` and on
every pull request, and fails on stale or uncommitted generated output. Patrol
is only required once an `integration_test/` suite exists.

Machine-enforced: formatter, analyzer/type rules, tests, and — through
`test/architecture/import_boundaries_test.dart` — the dependency direction of
ADR-0001 clause 4, which passes vacuously until `lib/features/` exists.
Ownership, minimal-change, contract, and abstraction rules remain documented
review rules.

## Architecture decisions (SHOULD)

- Use `docs/adr/` only for an accepted, repository-wide decision such as module
  boundaries, state management, persistence, authentication, eventing, or API
  conventions. Do not write ADRs for local implementation choices. Copy
  `docs/adr/TEMPLATE.md` and list the record in `docs/adr/README.md`.
- `0001-feature-first-slices-riverpod-go-router.md` is accepted and binds the
  architecture, dependency direction, and file-size rules stated below.
- Do not silently contradict an accepted ADR. Supersede it, document compatibility
  and migration, then implement incrementally.
- Add a concise feature README only for a genuinely complex module; include its
  purpose, rules, contracts, allowed/forbidden dependencies, key workflows, and
  test location. Do not duplicate source code in documentation.

## Future machine enforcement (MAY, only when justified)

Done: the dependency test (`test/architecture/import_boundaries_test.dart`) and
CI running the exact Definition of Done commands (`.github/workflows/ci.yml`).

Still open, and still only when justified:

- Extend the boundary test, or add an analyzer import rule, as real slices
  appear — presentation must not be imported by domain/application, and the
  forbidden-package list needs the storage or HTTP package a task actually adds.
- Add catalogue, navigation, golden, and Patrol checks to CI only after those
  artifacts and suites exist; do not install tooling preemptively.
