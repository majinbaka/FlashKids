---
name: flutter-data-model
description: Use when adding or changing a FlashKids data model, DTO, or JSON serialization — Freezed and json_serializable conventions, running build_runner, and handling generated-file and schema contract changes.
---

# Data models, Freezed, and JSON

`freezed`, `freezed_annotation`, `json_serializable`, `json_annotation`, and
`build_runner` are installed. No generated model exists yet — you will be
creating the first one, so set the convention carefully.

## When to generate

- Use Freezed when the type genuinely needs a union, deep equality, or
  `copyWith` across many fields.
- Use a plain immutable class with a `const` constructor for a small value type.
  Do not add codegen to a three-field state object.
- Use `json_serializable` only for types that actually cross a serialization
  boundary. Domain models are not automatically DTOs.

## Rules

- One model per file, named after the type in `snake_case`. `part` files sit
  beside it: `deck.dart`, `deck.freezed.dart`, `deck.g.dart`.
- Domain models live in `lib/features/<feature>/domain/` and must not import
  Flutter, GoRouter, HTTP clients, or storage code.
- Never hand-edit `*.freezed.dart` or `*.g.dart`. They are excluded from the
  analyzer in `analysis_options.yaml`; keep them out of `git diff` review noise
  by regenerating rather than patching.
- Fields are non-nullable by default. A nullable field must mean "genuinely
  absent", not "not loaded yet" — that is a state concern.
- No `dynamic`, broad `Object`, or unchecked casts to satisfy the generator. If
  an external payload forces one, keep it narrow and comment why.
- Prefer explicit `@JsonKey(name: ...)` over a global naming strategy so the
  wire format stays readable in the source.

## Generate

```sh
dart run build_runner build --delete-conflicting-outputs
```

Run it after any annotation change and **before** `flutter analyze` / tests.
Commit the regenerated output together with the source change; never leave the
tree with stale generated files.

## Contract changes

A serialized or persisted shape is a protected contract. Before changing a field
name, type, or nullability:

1. Identify every producer and consumer of the payload.
2. Explain the impact and provide an incremental migration.
3. Update the contract/behavior tests in the same change.

No persistence layer exists yet. If this change introduces one, define its
migration, transaction, and rollback rules with the first implementation —
never rewrite an applied migration.
