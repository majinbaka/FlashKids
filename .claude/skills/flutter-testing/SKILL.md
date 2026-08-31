---
name: flutter-testing
description: Use when writing or changing FlashKids tests — unit, widget, golden, or Patrol integration — including choosing the test level, using Mocktail and fakes, and reproducing a bug with a failing regression test.
---

# Testing

Tests are derived from acceptance behavior, not from coverage targets. Every
business rule and every behavior change needs a test.

## Layout

`test/` mirrors the source subtree:

```text
lib/features/deck/application/deck_controller.dart
test/features/deck/application/deck_controller_test.dart
```

Existing bootstrap tests are `test/widget_test.dart` and
`test/unit/smoke_test.dart`. Do not extend a smoke test into a behavior suite —
create the mirrored file.

## Choose the level

- **Unit** — domain rules, controllers, mappers. No widget pumping. Fastest and
  where most assertions belong.
- **Widget** — a screen renders the right thing for a given state, and input
  dispatches the right action. Wrap in `ProviderScope(overrides: [...])` with
  fakes, then `pumpWidget` / `pumpAndSettle`.
- **Golden** — `matchesGoldenFile` for a layout worth pinning. Add one only when
  the visual is a real requirement; goldens are maintenance.
- **Patrol** — end-to-end only. `integration_test/` does not exist yet and
  `patrol_cli` must be activated globally; do not create the suite unless the
  task approves it.

## Doubles

- Prefer a hand-written in-memory fake implementing the port when the test needs
  behavior across several calls; it stays deterministic and readable.
- Use Mocktail (`extends Mock implements X`) for single-interaction stubs and
  `verify` assertions. Register fallback values for custom argument types.
- Assert outcomes, not private implementation details. Do not add meaningless
  coverage tests.

## Bug workflow

1. Reproduce the bug with a failing test in the mirrored file.
2. Make that test pass with the smallest correct change.
3. Keep the test — it is the regression guard.

## Never

Never make a failing test pass by weakening or deleting its assertion, marking
it `skip`, or changing the expected behavior — unless the requirement itself
changed and the task says so. If a requirement and a test genuinely conflict,
stop and report it (`log-issue`).

## Run

```sh
flutter test                                   # full suite
flutter test test/features/deck/               # a subtree
flutter test --name 'renders the empty state'  # by name
```
