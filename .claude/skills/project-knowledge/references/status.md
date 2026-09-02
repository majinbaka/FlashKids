# FlashKids — where the project actually stands

Written from commit `3616f3c` (2026-09-02). Check `references/sources.md` §
*Freshness* before acting on this file.

FlashKids is a **documentation-heavy bootstrap**: ~37 lines of production code
under ~900 lines of binding contract and ~500 lines of proposal. Almost every
"how does X work" question resolves to *"X is specified, and nothing implements
it yet."* Say so explicitly — it is the most useful fact about this repository.

## Built — real code, verifiable today

- `lib/main.dart`: `ProviderScope` → `FlashKidsApp` (`MaterialApp.router`, M3
  seeded `deepPurple`) → one `GoRouter` route `'/'` → `HomePage` showing the
  text `FlashKids`.
- Three tests: an app smoke test, a Mocktail wiring test, and the ADR-0001
  import-boundary test (currently vacuous).
- `.github/workflows/ci.yml` running the exact Definition of Done, plus a
  stale-generated-output check.
- The Claude Code harness: 16 skills, 3 commands, permission allowlist, a deny
  rule on generated files, a `dart format` PostToolUse hook.
- `android/` and `web/` platform folders.

## Binding but unbuilt — decided, no code

| Decision | Where | Implemented? |
|---|---|---|
| Feature-first slices, ports and adapters, dependency direction | ADR-0001 | no — `lib/features/` does not exist |
| Riverpod for state and DI, `go_router` for navigation | ADR-0001 | partially — one provider, one route |
| Kid Zone / Parent Zone split, design principles, visual language | `design.md` §1–§8 | no |
| Component vocabulary (Flashcard, Deck tile, Parent gate, …) | `design.md` §6 | no — **none of these widgets exist** |
| Parent gate on every route leaving the Kid Zone | `design.md` §9 | no, and its challenge is undecided |
| UI Definition of Done (13 checks) | `design.md` §11 | applies to the first UI change |
| No user-facing literal in a widget; localization for all strings | `design.md` §8 | no `l10n/` exists yet |

## Proposed — not decided, not authorised

- **`docs/widgetbook_executable_spec.md`** (516 lines): Widgetbook as an
  executable spec, a `StoryHarness`, a `PrototypeStore` sandbox with fake
  adapters and a fake clock, a router factory reused by production and
  prototype, generated Mermaid navigation docs, a `Components / Screens / App
  Prototype` taxonomy, and an 8-phase plan. It is **a proposal**, restated as
  such in `AGENTS.md`, `CLAUDE.md`, `README.md`, and ADR-0001's Scope. Cite it
  for direction, never as proof a file or route exists.
- **`concepts/`** (untracked): ~150 image-generation prompts. Unapproved by its
  own README, because `design.md` §12 leaves the mascot and illustration guide
  undecided.

### The eight phases (spec §11), for orientation only

0 agree on contracts · 1 separate the production composition root out of
`main.dart` · 2 bootstrap Widgetbook · 3 executable Login screen spec · 4
stateful prototype sandbox and full flow · 5 grow by vertical slices · 6
generated navigation documentation · 7 CI and visual governance.

`/spec-phase <n>` prepares one and stops for approval. **A phase is implemented
only when a task approves it.**

## Open contradiction — needs the user, do not resolve it

**The spec and `design.md` describe two different applications.**

- `docs/widgetbook_executable_spec.md` §7 names the reachable screens as
  "Login, Home/Search, Projects/List/Detail/Edit, Users/Detail, Profile,
  Settings, Logout", and §11 Phase 3 makes **Login** the first vertical slice,
  Phase 5 "Projects, Users, Profile, Settings".
- `design.md` §1 describes a flashcard app for 3–10-year-olds with a Kid Zone
  and a Parent Zone, and §12 leaves onboarding and profiles explicitly
  undecided. There is no login, no project, and no user-management surface in
  the product contract.

Following the spec's phase order builds an authenticated CRUD app; following
`design.md` builds a children's flashcard app. Both cannot be the next slice.
This is exactly the case `AGENTS.md` → Conflicts and `CLAUDE.md` rule 5 reserve
for the user: present both sides with references, recommend, and wait. Do not
pick one, and do not rewrite either document to make it go away.

A plausible reading is that the spec's screen inventory is a generic worked
example predating `design.md` (added 2026-09-02, commit `4713755`, after the
spec's `5afee6b`) — but that is a guess, and the guess is the user's to confirm.

## Deliberately undecided — ask, never settle

`design.md` §12, restated with the ones most likely to block work first:

1. **Card content domains** (letters, numbers, vocabulary, language pairs),
   session length, and the repetition model — *the teaching content of the app*.
2. The parent-gate challenge mechanism.
3. Mascot, illustration style guide, asset pipeline (`concepts/` is the pending
   proposal).
4. Whether `deepPurple` stays; the final palette.
5. Dark mode; typeface.
6. Sound design, voice-over coverage, recorded vs. synthesized narration.
7. Onboarding, profiles/multiple children, monetization.
8. Offline behavior — no data layer exists.

Also undecided by absence: target platforms beyond `android/` and `web/`,
persistence, API client, auth, logging, and eventing conventions (each needs its
own ADR when introduced).

## Open deferred work

| File | Severity | Status |
|---|---|---|
| `2026-09-02-dependency-versions-unpinned.md` — every dependency is `any`, `pubspec.lock` uncommitted, so no two resolves are guaranteed to match | medium | **open** |
| `2026-09-02-flutter-kgp-warning-false-positive-on-patrol.md` — Flutter's KGP detector flags `patrol` by regex; threatens a future hard build failure | low | **open** |
| `2026-09-02-a11y-skill-stale-line-reference.md` | low | fixed |

These are candidates only when the user picks one — they were logged precisely
so they would not be fixed opportunistically (`CLAUDE.md` rule 3).

## What to do next

In order, with what each is blocked on:

1. **Resolve the spec-vs-`design.md` contradiction above.** Everything about
   "the next slice" depends on it, including which screen Phase 3 means.
2. **Decide the first card content domain** (`design.md` §12). Until then no
   real feature slice has a subject, and any deck or session code would be
   inventing product policy the contract forbids.
3. **Phase 1 — move the app shell and Home out of `lib/main.dart`** into
   `lib/app/`, leaving `main.dart` as bootstrap. This is the one phase that
   needs neither decision above: it is pure structure, it makes
   `test/architecture/import_boundaries_test.dart` non-vacuous, and it is what
   `flutter-feature-slice` exists for. Still needs the user's approval as a
   phase.
4. **Pin dependencies and commit `pubspec.lock`** — the open medium-severity
   item, and cheap.
5. **Approve or reject `concepts/`**, recording the decision in `design.md` §3
   and §12 in the same change. It is untracked; decide whether it enters git.

Not next, and worth saying out loud when asked: Widgetbook (Phase 2) and Patrol
have no entry point and none should be created as a side effect
(`widgetbook-catalogue`); dark mode, a second palette, and a font package are
each a repository-wide decision, not a task detail.
