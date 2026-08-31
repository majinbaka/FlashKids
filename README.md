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

## Working with AI agents

- `AGENTS.md` is the binding contract for any change: architecture, ownership,
  change discipline, tests, and the Definition of Done.
- `CLAUDE.md` is Claude Code's entry point. It restates the scope, adds the
  always-on rules (one purpose per file under 400 lines; minimal precise edits;
  log issues instead of fixing them; update docs in the same change), and
  indexes the skills.
- `.claude/skills/` holds the task-scoped skills: `flutter-feature-slice`,
  `flutter-widget-ui`, `flutter-riverpod-state`, `flutter-routing`,
  `flutter-data-model`, `flutter-testing`, `flutter-verify`, `log-issue`, and
  `sync-docs`.
- `issues/` collects problems found while doing something else. One file per
  issue, from `issues/TEMPLATE.md`; see `issues/README.md`.

## UI/UX specification

The proposed Widgetbook architecture, executable-spec conventions, test strategy,
and phased implementation plan are documented in
[`docs/widgetbook_executable_spec.md`](docs/widgetbook_executable_spec.md). The
document is intentionally a design proposal; the production and Widgetbook
entry points will be introduced in later implementation phases.
