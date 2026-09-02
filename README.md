# FlashKids

Minimal Flutter foundation with the project's agreed tooling. Dependency versions
are intentionally set to `any`, so `flutter pub get` resolves the newest versions
compatible with the installed Flutter/Dart SDK and records them in `pubspec.lock`.

## Included tooling

- **UI catalogue:** `widgetbook`, `widgetbook_annotation`
- **Unit/widget testing:** `flutter_test`, `mocktail`
- **Integration/E2E:** `patrol`; install its companion CLI globally with
  `dart pub global activate patrol_cli`
- **Visual regression:** Flutter golden tests can be added with
  `matchesGoldenFile`; Widgetbook Cloud can be connected when a workspace exists
- **Generation/models:** `build_runner`, `freezed`, `freezed_annotation`,
  `json_serializable`, `json_annotation`
- **Analysis:** `flutter_lints`
- **State and dependency injection:** Riverpod (`flutter_riverpod`)
- **Navigation:** `go_router`

## Bootstrap

```sh
flutter pub get
dart pub global activate patrol_cli
dart run build_runner build --delete-conflicting-outputs
flutter test
```

Generate platform folders when the target platforms are decided:

```sh
flutter create .
```

## Continuous integration

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) runs the Definition of
Done — `dart format --set-exit-if-changed`, `flutter analyze`, `flutter test` —
on push to `main` and on every pull request, and fails when `build_runner`
output is stale or uncommitted. Because dependencies are `any` and the lock is
not committed, the workflow prints the versions it resolved.

## Working with AI agents

- `AGENTS.md` is the binding contract for any change: architecture, ownership,
  change discipline, tests, and the Definition of Done.
- `CLAUDE.md` is Claude Code's entry point. It restates the scope, adds the
  always-on rules (one purpose per file under 400 lines; minimal precise edits;
  defer problems instead of fixing them; update docs in the same change), and
  indexes the skills.
- `.claude/skills/` holds `project-knowledge` — the digest that answers
  questions about the system without re-reading it — and the task-scoped skills
  `flutter-feature-slice`,
  `flutter-widget-ui`, `flutter-riverpod-state`, `flutter-routing`,
  `flutter-data-model`, `flutter-testing`, `flutter-verify`, `flutter-l10n`,
  `flutter-a11y-kids-ui`, `flutter-error-handling`, `flutter-persistence`,
  `widgetbook-catalogue`, `commit-and-pr`, `log-issue`, and `sync-docs`.
- `.claude/commands/` holds the slash commands `/dod`, `/defer`, and
  `/spec-phase`. `.claude/settings.json` allowlists the read-only Flutter, Dart,
  and git commands and formats Dart files after they are written.
- `docs/adr/` holds accepted repository-wide decisions;
  [`0001`](docs/adr/0001-feature-first-slices-riverpod-go-router.md) binds the
  architecture.
- `deferred-work/` collects problems found while doing something else. One file
  per item, from `deferred-work/TEMPLATE.md`; see `deferred-work/README.md`.

## UI/UX specification

[`design.md`](design.md) is the normative UI/UX and concept-style contract —
who the app is for, the Kid Zone / Parent Zone split, visual language, sizing
and spacing, motion and audio, copy, and the UI Definition of Done.

The proposed Widgetbook architecture, executable-spec conventions, test strategy,
and phased implementation plan are documented in
[`docs/widgetbook_executable_spec.md`](docs/widgetbook_executable_spec.md). The
document is intentionally a design proposal; the production and Widgetbook
entry points will be introduced in later implementation phases.
