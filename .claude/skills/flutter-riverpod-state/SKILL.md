---
name: flutter-riverpod-state
description: Use when adding or changing Riverpod providers, notifiers, controllers, or immutable view state in FlashKids, and when wiring dependency overrides for tests or Widgetbook.
---

# Riverpod state and dependency injection

Riverpod (`flutter_riverpod`) is the project's state management **and** its
dependency injection. There is no service locator and no global mutable state.

## Provider rules

- One provider file per cohesive concern; name the file after what it provides.
  Keep providers next to the feature that owns them, not in a global registry.
- Provider naming is `<subject>Provider` (see `appRouterProvider` in
  `lib/main.dart`).
- Pick the narrowest kind that works: `Provider` for a pure dependency,
  `FutureProvider` for a one-shot async read, `NotifierProvider` /
  `AsyncNotifierProvider` for state a controller mutates.
- Never read a provider inside a `build` method with `ref.read`; use
  `ref.watch`. Use `ref.read` in callbacks and controller methods.
- Controllers expose intent-named methods (`submit()`, `retry()`), not setters
  that leak widget concerns into state.

## State types

- Model view state as an immutable class with `copyWith` — Freezed when the
  feature already generates code (`flutter-data-model`), a hand-written
  immutable class when it does not. Do not add Freezed to a feature just to hold
  three fields.
- Prefer a sealed/`AsyncValue` shape over parallel `isLoading` / `error` /
  `data` booleans. If two booleans can contradict each other, the type is wrong.
- Equality matters: without it, widgets rebuild on every notification.

## Dependencies and overrides

- A feature depends on its port (the repository interface in `domain/`), never
  on a concrete adapter. The adapter is chosen by an override at composition.
- Real adapters are wired in the app's `ProviderScope`; fakes are wired by tests
  and Widgetbook through `overrides:` on a scoped `ProviderScope`.
- `domain/` and `application/` code must not import Flutter widgets, GoRouter,
  Widgetbook, HTTP, or storage implementations — only `flutter_riverpod` for the
  provider declaration itself.

## Procedure

1. Decide who owns the state: widget-local, feature controller, or app-wide.
   Default to the narrowest scope that satisfies the behavior.
2. Define or reuse the port the controller needs.
3. Write the state type first, then the notifier, then the provider.
4. Test the controller directly with a fake or Mocktail double — no widget
   pumping required for pure state logic (`flutter-testing`).
5. Run `flutter-verify`.

Changing a provider's type or removing one is a contract change: find every
consumer, and update the affected tests in the same change.
