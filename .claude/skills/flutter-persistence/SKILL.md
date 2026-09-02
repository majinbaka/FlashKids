---
name: flutter-persistence
description: Use when a FlashKids change stores or reads data that outlives the session — local database, key-value preferences, files, or a future API cache — including choosing the storage, defining migrations, and keeping storage behind a port.
---

# Persistence, migrations, and stored data

**No persistence exists.** There is no database, no key-value store, no file
storage, no API client, and no dependency for any of them in `pubspec.yaml`.
`AGENTS.md` is explicit: the first implementation defines the migration,
transaction, and rollback rules, and no convention may be invented before then.

Adding a storage dependency is a decision with a long tail — it binds the data
model, the test strategy, and every future migration. Do it when a task
approves it, and record it in an ADR (`docs/adr/`).

## Choosing storage

Match the storage to the data, and pick the smallest thing that works:

| Data | Storage |
|---|---|
| a user preference, a flag, a last-opened id | key-value preferences |
| a downloaded asset, an audio or image file | the file system, path from the platform |
| decks, cards, progress — queried, related, growing | a local database |
| a secret or token | the platform secure store, never preferences |

Do not reach for a database because a list "might grow later". Solve today's
confirmed requirement (`AGENTS.md`, "Change discipline").

## Architecture

- Storage sits **behind a port**. The interface lives in the feature's
  `domain/`, the implementation in `infrastructure/`, and the feature depends
  only on the interface (`flutter-feature-slice`, ADR-0001).
- `domain/` and `application/` must never import the storage package. If the
  database type appears in a controller signature, the boundary has leaked.
- Widgets never read or write storage. They dispatch an action; the controller
  calls the port (`flutter-riverpod-state`).
- The adapter translates storage errors into domain failures and decides no
  business policy (`flutter-error-handling`).
- A stored row is not a domain model. Keep the DTO/entity that the storage layer
  writes separate from the domain type, and map between them in the adapter —
  otherwise a schema change becomes a domain change (`flutter-data-model`).

## Stored shape is a protected contract

A persisted shape is data on a real device that you cannot edit. Before changing
a field's name, type, or nullability:

1. Identify every producer and consumer, including data already written by a
   released build.
2. State the impact and provide an incremental migration — read the old shape,
   write the new one, and keep the old readable until the migration is
   guaranteed to have run.
3. Update the contract tests in the same change.

Rules that hold from the first implementation:

- **Never rewrite an applied migration.** Add a new one.
- **Never make a destructive schema change silently** — a dropped column or
  table is a data-loss decision that goes to the user first (`CLAUDE.md`,
  rule 5).
- Migrations are ordered, versioned, and idempotent where the platform allows.
- A multi-step write that must not half-apply runs in a transaction, and the
  rollback path is tested, not assumed.
- No secrets in plain storage, and no credentials or tokens in logs
  (`AGENTS.md`, "Security and operations").

## Testing

- Test the feature against an in-memory fake of the port — fast, deterministic,
  and it does not need the device (`flutter-testing`).
- Test the adapter itself against the real storage, including: write then read
  back, the failure the adapter must translate, and **every migration, from the
  previous released shape to the new one, with realistic data**.
- A migration without a test is a data-loss bug that has not happened yet.

## Procedure

1. Confirm the task approves introducing (or extending) persistence. If not,
   stop and say so — do not add a dependency as a side effect.
2. Name the data, its lifetime, and who owns it.
3. Define the port in `domain/`, then the adapter in `infrastructure/`, then the
   provider override that wires the real adapter at composition.
4. Write the migration and its test together with the schema change.
5. Update the docs, and write or supersede the ADR (`sync-docs`).
6. Run `flutter-verify` — persistence is shared state, so run the full suite.
