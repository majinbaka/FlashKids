---
name: flutter-error-handling
description: Use when a FlashKids change can fail — a port that talks to storage, a network or platform boundary, input validation, or surfacing a failure in the UI. Defines the error model to establish at the first real boundary.
---

# Errors and failures

`AGENTS.md` says to follow "the existing error model" and not to create a
separate convention per feature. **There is no error model yet** — no
persistence, no API client, no logging framework, and `lib/main.dart` cannot
fail. Whoever writes the first fallible boundary sets the convention for
everyone. This skill is that convention; apply it, do not invent a competing
one.

## The model

- **A domain port returns a failure, it does not throw.** A method on a
  repository interface in `domain/` returns a typed result — a sealed failure
  union or `Either`-shaped return — for the failures that are part of its
  contract: not found, offline, invalid input, permission refused.
- **Exceptions are for the truly exceptional**: a bug, a broken invariant, a
  platform fault nobody can act on. They are not the control flow for a card
  that does not exist.
- **Adapters translate, they do not decide.** An `infrastructure/` adapter
  catches the SDK/platform exception it knows about (`SocketException`,
  a database error, a `FormatException` on a payload) and returns the domain
  failure that describes it. A `PlatformException` must never escape into
  `application/` or a widget — that leaks the adapter's identity through the
  port.
- **Failure types live in `domain/`** beside the port that returns them, named
  for the cause (`DeckNotFound`, `DeckStorageUnavailable`), not for the widget
  that will show them. A feature owns its failures; do not promote them to a
  shared `core/errors.dart` until several real modules need the same type
  (`flutter-feature-slice`).
- **Preserve actionable context at the boundary.** Carry what the caller or a
  future log needs — the id, the operation, the underlying error — and keep the
  original error and stack trace when you wrap. Never swallow a failure into a
  bare `null`, an empty list, or a silent `catch {}`.
- **Never catch to hide.** A `try`/`catch` that does not translate, retry, or
  surface the failure should not exist.

## In application and UI

- The controller maps a failure to view state (`flutter-riverpod-state`). Model
  it as `AsyncValue` or a sealed state — never parallel `isLoading` / `error`
  booleans that can contradict each other.
- The widget renders that state and offers the action the failure allows
  (retry, go back). It does not inspect exception types or build error strings
  from an exception's `toString()`.
- Error text shown to a child is short, non-blaming, and localized
  (`flutter-l10n`) — and never contains a stack trace, an id, or a technical
  term.
- Never log or display credentials, tokens, or sensitive payloads (`AGENTS.md`,
  "Security and operations"). There is no logging framework yet; do not add
  `print` calls or a per-feature logging convention as a side effect.

## Type safety

No `dynamic`, no broad `Object`, no unchecked cast, and no `// ignore` to make a
failure path compile. If an external boundary forces one, keep it narrow and
comment why.

## Procedure

1. List what can actually fail in this change, and which of those are part of
   the port's contract versus genuine bugs.
2. Define or reuse the failure type in `domain/`, next to the port.
3. Translate in the adapter; map to view state in the controller; render in the
   widget.
4. Test the failure path with a fake that returns the failure — a failure with
   no test is a failure nobody has seen (`flutter-testing`).
5. Run `flutter-verify`.

When the first real boundary lands, record the model in an ADR (`docs/adr/`) so
the next feature inherits it instead of re-deciding it.
