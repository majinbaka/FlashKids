---
name: flutter-routing
description: Use when adding, renaming, removing, or redirecting a `go_router` route in FlashKids, or when changing navigation, deep links, or route parameters.
---

# go_router navigation

Routes are a public contract. A path, its parameters, and its redirect policy
are consumed by deep links, tests, and (later) the Widgetbook prototype.

## Current state

`lib/main.dart` holds `appRouterProvider` with a single route, `/`. There is no
route manifest file and no router factory yet;
`docs/widgetbook_executable_spec.md` proposes both. Create them only when a task
approves that phase — otherwise add the route where the router already lives.

## Rules

- Paths are lowercase `kebab-case`; parameters are `:camelCase`
  (`/deck/:deckId/card/:cardId`).
- Give every route a `name` once more than one route exists, and navigate by
  name so a path change stays in one place.
- Parse and validate path/query parameters at the route boundary; hand the
  screen typed values, never raw `state.pathParameters` strings.
- Redirect logic is policy — keep it in one place with the router, not scattered
  across screens. A screen does not decide whether the user is allowed to be
  there.
- Screens are built by the route; a screen does not construct its own router or
  push routes it does not own.
- Production and any future prototype runtime share one route definition.
  Runtime-specific start destinations are parameters, not a forked router file.

## Breaking-change procedure

Renaming or removing a path, or changing a parameter:

1. List every consumer: navigation calls, tests, docs, deep links.
2. State the impact and provide an incremental migration where one is possible.
3. Update the navigation tests in the same change.
4. Update `README.md` / the spec doc if they name the route (`sync-docs`).

## Procedure

1. Confirm the route does not already exist.
2. Add the route beside the existing ones, with its typed parameter parsing.
3. Add a navigation test that asserts the route renders its screen and that
   parameters arrive parsed.
4. Run `flutter-verify` — routing is shared, so run the full suite, not a
   single file.
