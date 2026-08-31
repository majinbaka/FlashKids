---
name: flutter-widget-ui
description: Use when creating or editing any Flutter screen, widget, or Widgetbook story in FlashKids — composing Material 3 UI, keeping logic out of widgets, and writing a story that configures state without duplicating the production widget.
---

# Flutter widget and Widgetbook UI

Use this skill for every file under a `presentation/` directory and for every
Widgetbook use-case. One widget per file; the file is named after the widget in
`snake_case`. Keep it under 400 lines (`flutter-feature-slice`).

## Widget rules

- A widget renders state, collects input, dispatches actions, and handles
  presentation concerns only. Validation, calculations, and workflows belong in
  the feature's application/domain code.
- Prefer `StatelessWidget` / `ConsumerWidget`. Reach for `ConsumerStatefulWidget`
  only for real widget-local lifecycle (controllers, focus nodes, animations),
  and dispose what you create.
- Constructors are `const` with `super.key` wherever the fields allow it.
- Take an immutable view-state object as input rather than a spread of nullable
  booleans. An ambiguous boolean combination is a state type waiting to exist.
- Theme through `Theme.of(context)` / `ColorScheme` (Material 3, seeded from
  `Colors.deepPurple` in `lib/main.dart`). Do not hardcode colors or text styles
  that the theme already provides.
- Extract a sub-widget rather than a `Widget _buildX()` method once a build
  method grows past roughly 40 lines; a real widget rebuilds and tests better.
- Single quotes (`prefer_single_quotes` is enforced).

## Widgetbook stories

Widgetbook and `widgetbook_annotation` are installed, but **no catalogue entry
point exists yet**. Before adding the first story, confirm the task actually
approves creating `widgetbook/` — do not introduce the executable as a side
effect of a widget change.

When stories do exist:

- A story imports the production widget and supplies dependencies and initial
  state. It never copies the widget's markup or reimplements its behavior.
- Cover the state matrix that matters: empty, loading, populated, error,
  and any accessibility-relevant variant.
- Stories live under `widgetbook/`, never inside `lib/`. Production code must
  never import them.
- Stories are specification, not a regression suite — the equivalent assertions
  belong in tests (`flutter-testing`).

## Procedure

1. Read the nearest existing widget and follow its composition pattern.
2. Identify the state the widget needs and where it comes from
   (`flutter-riverpod-state`).
3. Build the widget; keep every branch driven by the view state.
4. Add or update the widget test in the mirrored `test/` subtree.
5. Update the story or spec doc the change invalidates (`sync-docs`).
6. Run `flutter-verify`.

Do not restyle, rename, or reformat neighbouring widgets that the task did not
ask about. Record what you noticed with `log-issue` instead.
