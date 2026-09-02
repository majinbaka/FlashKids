# FlashKids — the system

Sources of truth: `AGENTS.md` (binding contract),
`docs/adr/0001-feature-first-slices-riverpod-go-router.md` (accepted
architecture), and the code. Digest written from commit `3616f3c`.

## Shape of the repository

A **single Dart package** — not a monorepo, not a workspace. `pubspec.yaml` is
the sole manifest; use Flutter's bundled Dart and `flutter pub`.

```text
lib/main.dart                              the entire application (~37 lines)
test/widget_test.dart                      smoke: the app renders "FlashKids"
test/unit/smoke_test.dart                  smoke: Mocktail is wired
test/architecture/import_boundaries_test.dart   enforces ADR-0001 clause 4
android/ web/                              generated platform folders
docs/widgetbook_executable_spec.md         proposal, 516 lines
docs/adr/                                  accepted repository-wide decisions
design.md                                  normative UI/UX contract
AGENTS.md CLAUDE.md README.md              the agent contract, entry point, readme
deferred-work/                             problems logged instead of fixed
concepts/                                  unapproved image-prompt proposal (untracked)
.claude/skills/ .claude/commands/          16 skills, 3 slash commands
.claude/settings.json .claude/hooks/       the Claude Code harness
.github/workflows/ci.yml                   the Definition of Done in CI
```

There is **no** `ios/`, `macos/`, `linux/`, or `windows/` — `flutter create .`
adds a platform when the targets are decided. There is **no** `lib/features/`,
`lib/app/`, `lib/infrastructure/`, `widgetbook/`, `integration_test/`, `l10n/`,
or `assets/`.

## All of the production code

`lib/main.dart` holds four things, and until a task moves one out, it owns app
behavior (`AGENTS.md` → Repository map):

- `main()` — `runApp(const ProviderScope(child: FlashKidsApp()))`
- `appRouterProvider` — `Provider<GoRouter>` with exactly one route, `'/'`
- `FlashKidsApp` — `ConsumerWidget`, builds `MaterialApp.router` with
  `ColorScheme.fromSeed(seedColor: Colors.deepPurple)`, `useMaterial3: true`,
  and `routerConfig: ref.watch(appRouterProvider)`
- `HomePage` — `StatelessWidget`, a `Scaffold` centring the text `FlashKids`

No database, no API client, no auth, no logging framework. **Do not invent their
conventions** — `flutter-persistence` and `flutter-error-handling` govern the
first one a task actually introduces.

## The stack

Dart 3.9+, Flutter, Material 3.

| Concern | Package | State |
|---|---|---|
| State + DI | `flutter_riverpod` | in use (`ProviderScope`, one provider) |
| Navigation | `go_router` | in use (one route) |
| Models / generation | `freezed`, `json_serializable`, `build_runner` | installed, no annotated source yet |
| Unit/widget tests | `flutter_test`, `mocktail` | in use |
| UI catalogue | `widgetbook`, `widgetbook_annotation` | **installed, no entry point** |
| E2E | `patrol` (+ `patrol_cli` global) | **installed, no `integration_test/`** |
| Lints | `flutter_lints` + `prefer_single_quotes` | in use |

**Every dependency is `any` and `pubspec.lock` is not committed** — deliberate
per `README.md`, and logged as medium-severity debt in
`deferred-work/2026-09-02-dependency-versions-unpinned.md`. CI prints the
versions it resolved.

## Architecture — decided, not yet built

ADR-0001, accepted 2026-09-02. It binds; the code does not implement it yet, and
**the migration is not authorised as a side effect of unrelated work**.

1. **Riverpod is state and DI.** No service locator, no global mutable state. A
   provider is the injection point; tests and Widgetbook substitute
   dependencies through `overrides:` on a scoped `ProviderScope`.
2. **`go_router` is navigation.** Routes are a public contract: one router
   definition serves production and any future prototype, and the start
   destination is a parameter, not a forked router.
3. **Feature-first layout**, created only when a task needs a directory:

```text
lib/
  app/                        shared shell, composition, route manifest
  features/<feature>/
    presentation/             screens, widgets, immutable view state
    application/              controllers, use cases
    domain/                   models, repository interfaces (ports)
    infrastructure/           adapters implementing the ports
  infrastructure/             cross-feature external implementations
test/features/<feature>/      mirrors the source subtree
```

4. **Dependency direction:** presentation → application/domain ports ←
   infrastructure adapters. `domain/` and `application/` must not import
   `package:flutter/{material,widgets,cupertino,services}`, `go_router`,
   `widgetbook`, HTTP clients, or storage implementations —
   `package:flutter/foundation.dart` **is** allowed (`@immutable`, value
   equality). `lib/` must never import `widgetbook/` or `test/`.
5. **One file, one purpose, 400-line hard cap**, split along a testable
   responsibility boundary.
6. **`test/` mirrors the source subtree.**

Clause 4 is machine-enforced by `test/architecture/import_boundaries_test.dart`,
which **passes vacuously until `lib/features/` exists** and fails the moment a
slice crosses a boundary. Clauses 3, 5, 6 are review rules.

Rejected alternatives, so they are not re-litigated: leaving the architecture a
proposal; layer-first (`lib/screens/`, `lib/models/`, `lib/services/`); `get_it`
alongside Riverpod; `Navigator` 1.0 directly.

## The rules that govern every change

`CLAUDE.md` always-on rules, expanded in `AGENTS.md`:

1. **One file, one purpose, under 400 lines.** Nameable in one sentence without
   "and". Review prompts inside the cap: ~40 lines/function, ~200/class,
   ~300/file, ~3 nesting levels.
2. **Change the minimum, precisely.** No renaming, reformatting, import
   reordering, or refactoring the task did not ask for. Name the minimum file
   set first. **Prefer duplication twice over the wrong abstraction once.**
3. **Defer what you find, do not fix it** — `deferred-work/YYYY-MM-DD-slug.md`
   from `TEMPLATE.md` (`log-issue`, `/defer`). Fix only when it *is* the task,
   when the change is wrong without it, or when the user asks.
4. **Code change ⇒ doc update, in the same change** (`sync-docs`).
5. **Conflict ⇒ confirm with the user.** Two sources that cannot both be right:
   stop the affected part, give both sides with `path:line`, recommend, and
   wait. Never pick a side, never delete the losing statement, never omit it
   from the summary. Do the unblocked parts first.

Forbidden by name: `BaseRepository`, `GenericRepository`, `BaseService`,
`AbstractService`, Manager, handler frameworks, Factory, Provider, Wrapper,
Helper, utility layers introduced to future-proof code. `core/`, `shared/`,
`common/`, `utils/`, `helpers/` are earned by multiple real dependents, not
created upfront. No `dynamic`, broad `Object`, forced casts, `// ignore`, or
analyzer exclusions to silence tooling. Never hand-edit `*.g.dart` or
`*.freezed.dart`.

## Tests

- Derived from **acceptance behavior**; business rules and behavior changes
  require tests; a bug gets a failing regression test first when practical.
- Assert outcomes, not private implementation details. No coverage-padding.
- **Never** pass a test by weakening or removing its assertion, skipping it, or
  changing expected behavior unless the requirement actually changed.
- `test/` mirrors the source subtree; behavior tests sit near it.
- Architecture tests live in `test/architecture/` and enforce rules, not
  behavior.

## Definition of done

Run the smallest relevant set; the full suite for routing, shared state,
dependency, or generated-code changes.

```sh
dart run build_runner build --delete-conflicting-outputs   # first, if annotated sources changed
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

Narrowing: `flutter test test/features/deck/` · `flutter test --name '...'`.

Then review `git status --short` and `git diff` for unrelated edits, stray
generated output, secrets, and dependency or contract changes; then self-review
for needless abstraction, wrong-layer logic, dead code, weakened tests, unsafe
casts, and compatibility breaks. `/dod` runs the whole thing (`flutter-verify`).

`.github/workflows/ci.yml` runs **exactly** these commands on push to `main` and
every pull request, prints the resolved `pubspec.lock`, and **fails on stale or
uncommitted generated output**. Patrol enters CI only once `integration_test/`
exists.

## The agent harness

`.claude/settings.json`:

- **allow** — read-only Flutter/Dart/git commands run without prompting:
  `flutter analyze|test|pub get|pub outdated|--version`, `dart format|analyze|
  run build_runner|--version`, `git status|diff|log|show|branch|ls-files`,
  `date`.
- **deny** — `Edit(**/*.g.dart)`, `Edit(**/*.freezed.dart)`.
- **hook** — PostToolUse on `Edit|Write|MultiEdit` runs
  `.claude/hooks/format-dart.sh`, which formats the Dart file just written,
  skips generated output, and does nothing when the Dart SDK is absent.

`analysis_options.yaml`: `flutter_lints` plus `prefer_single_quotes`, excluding
`**/*.freezed.dart`, `**/*.g.dart`, `build/**`, `android/**`, `web/**`.

## The other skills

`flutter-feature-slice` (placement, layering) · `flutter-widget-ui` (screens,
widgets, stories) · `flutter-riverpod-state` (providers, notifiers, overrides) ·
`flutter-routing` (`go_router` changes) · `flutter-data-model` (Freezed, JSON,
`build_runner`) · `flutter-testing` · `flutter-verify` (before reporting done) ·
`flutter-l10n` (any user-facing string) · `flutter-a11y-kids-ui` (targets,
semantics, contrast, text scaling, motion, audio) · `flutter-error-handling` ·
`flutter-persistence` · `widgetbook-catalogue` · `commit-and-pr` · `log-issue` ·
`sync-docs` · `project-knowledge` (this one).

Slash commands: `/dod` (Definition of Done + diff review) · `/defer <slug>`
(file a deferred-work item) · `/spec-phase <n>` (prepare one Widgetbook spec
phase and **stop for approval**).
