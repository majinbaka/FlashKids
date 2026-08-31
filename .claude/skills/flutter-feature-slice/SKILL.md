---
name: flutter-feature-slice
description: Use when adding a new FlashKids feature or moving behavior out of `lib/main.dart` — deciding which files a slice needs, where presentation / application / domain / infrastructure code belongs, and how to keep each file to one purpose under 400 lines.
---

# Flutter feature slice

Use this skill before writing the first file of a new feature, and whenever a
change makes `lib/main.dart` own more than bootstrap. It decides *placement*;
the widget, state, routing, model, and test skills decide *content*.

## Read first

`AGENTS.md` is the binding contract. `docs/widgetbook_executable_spec.md` is a
**proposal**, not implemented — cite it for direction, never as proof a file or
route already exists.

## One file, one purpose

- Every file has a single stated responsibility. If you cannot name it in one
  sentence without "and", split it.
- **Hard cap: 400 lines per file.** At ~300 lines, look for the split; at 400,
  split before adding anything. Split along a testable responsibility boundary
  (a screen vs. its controller, a state type vs. its mapper) — never by
  arbitrary line count into `part1`/`part2` or a `_helpers.dart` dumping ground.
- Rough review prompts from `AGENTS.md` still apply inside the cap: ~40 lines
  per function, ~200 per class, ~3 nested condition levels.

## Layout of a slice

Introduce only the directories the current task actually needs.

```text
lib/
  app/                       # shared shell, composition, route manifest
  features/<feature>/
    presentation/            # screens, widgets, immutable view state
    application/             # controllers, use cases
    domain/                  # models, repository interfaces (ports)
    infrastructure/          # adapters implementing the ports
  infrastructure/            # cross-feature external implementations
test/
  features/<feature>/        # mirrors the source subtree
```

## Dependency direction

presentation → application/domain ports ← infrastructure adapters.

- `domain/` and `application/` must not import `package:flutter/*`, `go_router`,
  `widgetbook`, HTTP clients, or storage implementations.
- `lib/` must never import `widgetbook/` or `test/` code.
- Widgets do not call storage or API code; adapters do not decide business
  policy.

## Procedure

1. Name the acceptance behavior in one sentence.
2. Name the owning module. If it does not exist yet, that is the file you
   create; do not spread the behavior across `lib/main.dart` and a new folder.
3. Search for the closest existing implementation and test, and follow that
   pattern rather than introducing a cleaner competing one.
4. List the minimum files to touch. Anything outside that list is out of scope —
   see `log-issue` if you find a real problem there.
5. Implement the smallest correct change. Do not migrate the rest of the repo to
   the proposed architecture as a side effect.
6. Add or update tests in the mirrored `test/` subtree (`flutter-testing`).
7. Update the docs the change invalidates (`sync-docs`).
8. Run the Definition of Done (`flutter-verify`).

## Do not

- Do not create `BaseRepository`, `BaseService`, `Manager`, `Helper`, `Wrapper`,
  or a utility layer to future-proof code. Prefer duplication twice over the
  wrong abstraction once.
- Do not promote code to `core/`, `shared/`, or `common/` until multiple real
  modules depend on the stable concept.
- Do not add a feature README unless the module is genuinely complex.
