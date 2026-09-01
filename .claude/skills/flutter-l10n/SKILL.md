---
name: flutter-l10n
description: Use when adding or changing any user-facing string in FlashKids, or when introducing localization — ARB files, key naming, plurals, locale-sensitive formatting, and keeping strings out of widgets.
---

# Localization and user-facing strings

FlashKids is a language-learning app for children. Every user-facing string is
translatable content, not a literal — decide where it lives **before** writing
the widget, because retrofitting localization across finished screens is far
more expensive than starting with it.

## Current state

There is **no localization**. `flutter_localizations`, `intl`, `l10n.yaml`, and
`lib/l10n/` do not exist, and the only strings in the app are hardcoded:
`lib/main.dart:26` (`title: 'FlashKids'`) and `lib/main.dart:42`
(`Text('FlashKids')`).

Introducing localization changes `pubspec.yaml` and adds a generation step to
the build. That is a dependency and tooling decision — do it when a task
approves it, never as a side effect of adding a screen. Until then, follow
"Before localization exists" below.

## Before localization exists

- Keep every user-facing string in the widget that displays it. Do not invent a
  private `strings.dart` constants file, an `AppStrings` class, or any other
  home-grown string layer: it is the wrong abstraction, and it will have to be
  unwound when ARB files arrive (`AGENTS.md`, "Change discipline").
- A brand name (`FlashKids`) is not translatable content and stays a literal.
- If you notice hardcoded strings outside your task's scope, file them with
  `log-issue` rather than converting them.

## When a task introduces localization

1. Add `flutter_localizations` (SDK) and `intl`, plus `l10n.yaml` at the root
   and `lib/l10n/app_<locale>.arb` per locale. Declare the source-of-truth
   locale explicitly.
2. Wire `localizationsDelegates` and `supportedLocales` on the `MaterialApp` in
   the composition root, next to `routerConfig` (`lib/main.dart:31`).
3. Generated localization output is generated code: never hand-edit it, and
   regenerate rather than patch (`flutter-data-model`).
4. Record the decision — supported locales, fallback behavior, and where the
   ARB files live — in an ADR (`docs/adr/`), because it binds every later
   feature. See `sync-docs`.

## Rules once ARB files exist

- **No user-facing literal in a widget.** Strings come from the generated
  accessor; the widget names the key, not the English text.
- Keys are `lowerCamelCase` and name the **meaning**, not the wording:
  `deckEmptyMessage`, not `noCardsYetExclamation`. A key that has to change when
  the copy changes is the wrong key.
- Every key carries a `@key` description in the source ARB saying where it
  appears and what the placeholders mean. Translators do not have the screen.
- Never build a sentence by concatenating translated fragments or interpolating
  into a translated string by hand. Use ICU placeholders, `plural`, and
  `select` — word order and plural categories differ per language.
- Numbers, dates, and durations are formatted through `intl`, never through
  `toString()` or manual padding.
- A translated string is a contract with the translations: renaming or removing
  a key means updating every ARB file in the same change, not just the source
  locale.
- Locale-dependent layout is a UI concern, not a string concern — see
  `flutter-a11y-kids-ui` for text scaling and overflow.

## Procedure

1. Confirm whether the string is user-facing content or a brand/debug literal.
2. If localization does not exist yet and this task does not approve
   introducing it, keep the string in the widget and say so in your summary.
3. Otherwise add or reuse a key, fill every locale's ARB, and reference it from
   the widget.
4. Assert on the key's rendered value in the widget test, not on a raw English
   literal you hardcoded twice (`flutter-testing`).
5. Run `flutter-verify`.
