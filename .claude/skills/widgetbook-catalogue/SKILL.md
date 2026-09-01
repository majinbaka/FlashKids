---
name: widgetbook-catalogue
description: Use when bootstrapping the FlashKids Widgetbook executable or adding a use-case to it — catalogue entry point, the Components/Screens/App Prototype hierarchy, scenario IDs, the shared story harness, and addons.
---

# The Widgetbook catalogue

Widgetbook is FlashKids' **executable UI/UX specification**: a story is the
contract a screen must be able to render, and the test is what asserts it. This
skill owns the catalogue itself — its entry point, hierarchy, and conventions.
`flutter-widget-ui` owns the widget a story renders.

## Read first, and stop

`widgetbook` and `widgetbook_annotation` are installed, but **no catalogue entry
point exists** — there is no `widgetbook/` directory. The structure below is
proposed in `docs/widgetbook_executable_spec.md` sections 5–6 (phases 2–4 of its
plan), which is a proposal, not an implemented contract.

Creating the executable is its own approved task. Do not bootstrap it as a side
effect of a widget change; use `/spec-phase 2` to prepare it and wait for
approval.

## Placement

- Stories live under `widgetbook/`, never inside `lib/`. Production code must
  never import them (ADR-0001, clause 4).
- The catalogue has its own entry point (`widgetbook/main.dart`); it is a second
  executable of the same package, not a second app.
- A story imports the production widget. It never copies markup, forks a
  variant, or reimplements behavior — a story that diverges from production is
  documentation of something that does not exist.

## Hierarchy

Three stable top-level areas, per the spec:

```text
Components     reusable visual primitives (buttons, form fields, cards)
Screens        one screen at a time, controlled state and environment
App Prototype  a single "Full Application Flow" entry, booting the app with fakes
```

Do not split the main journey into competing mini-flows. A narrow flow may exist
temporarily during development, but it is not part of the published hierarchy.

## Naming and the spec block

Scenario IDs are `<feature>.<screen>.<state>`, in stable domain language:

```text
deck.list.empty
deck.detail.permission_denied
auth.login.authentication_error
```

Each story file opens with a compact spec block — requirement ID, Given / When /
Then, and the path of the test that asserts it. Prose-only requirements are not
acceptable: an interactive story wires its actions through the real controller
and fakes, and the same outcome is asserted in a test.

## State and dependencies

- Cover the states that are **meaningful for that screen**. Do not mechanically
  add Default, Loading, Empty, Error, Validation, Success, Disabled, and
  Permission Denied to everything — an unreachable state is a lie about the
  contract.
- A story supplies dependencies through `overrides:` on a scoped `ProviderScope`
  with fakes, exactly as a widget test does (`flutter-riverpod-state`). Prefer a
  shared harness over per-story wiring copied around.
- Pure rendering stories inject a fixed view state; interactive stories drive
  the real controller against a fake port.
- Knobs control genuine input a user could produce — long title, item count,
  role. They do not expose internal state no user can reach.
- Addons cover viewport/device, text scaling, locale, and theme. Text scaling
  and locale are not decoration here: they are how the catalogue proves the
  accessibility and localization contracts (`flutter-a11y-kids-ui`,
  `flutter-l10n`).

## Stories are not tests

A story shows a state; it asserts nothing. Every behavior a story demonstrates
has its assertion in `test/` (`flutter-testing`), and the story's spec block
names that test file. Do not treat a rendering catalogue as a regression suite.

## Procedure

1. Confirm the catalogue exists and that this task approves the story. If the
   entry point does not exist yet, stop — that is phase 2, not this change.
2. Place the use-case in Components, Screens, or App Prototype.
3. Write the spec block, then the scenario, then the overrides.
4. Add or update the test the spec block names.
5. Update the spec document if you implemented one of its phases — mark it
   implemented rather than leaving it reading as pending (`sync-docs`).
6. Run `flutter-verify`.
