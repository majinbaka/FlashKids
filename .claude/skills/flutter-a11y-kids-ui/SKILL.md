---
name: flutter-a11y-kids-ui
description: Use when building or changing any FlashKids screen, widget, or interaction — touch targets, semantics labels, text scaling, contrast, motion, and audio for an app used by children.
---

# Accessibility and child-facing UI

FlashKids is used by children, often on a shared device, sometimes by a child
who cannot read yet. Accessibility here is not a compliance checkbox added at
the end — it is what makes the app usable at all. Apply this alongside
`flutter-widget-ui`, which owns composition; this skill owns whether a child
and a screen reader can actually operate the result.

## Touch and hit targets

- Minimum interactive size is **48x48 dp**, and larger for a primary action a
  child taps repeatedly. `IconButton` gives you this by default; a bare
  `GestureDetector` on an `Icon` or `Text` does not — wrap it or set
  `constraints`.
- Leave real space between adjacent targets. Two 48 dp buttons flush against
  each other are one 96 dp mistake.
- Never put a destructive or account-level action (delete, purchase, external
  link, settings that change money or data) next to a play control, and never
  where a mistap reaches it.

## Semantics

- Every non-decorative image, icon, and custom-painted control needs a
  `Semantics` label describing what it *does*, not what it looks like: "play the
  word", not "speaker icon".
- Mark decorative visuals `ExcludeSemantics` so a screen reader does not read
  wallpaper.
- Merge the label and its control into one node (`MergeSemantics`) so a card
  with a picture and a word is announced once, not three times.
- State that is visible must also be semantic: selected, disabled, in-progress,
  and correct/incorrect are `Semantics` flags, not only a color change.
- Labels are translatable content — they come from the localization layer, not
  from a literal (`flutter-l10n`).

## Color, contrast, and text

- **Color is never the only channel.** Correct/incorrect, selected, and locked
  states each need a second signal: icon, shape, text, or position. A large
  share of users cannot separate the colors, and a pre-reader relies on the
  icon.
- Text and essential icons meet WCAG AA contrast (4.5:1 body, 3:1 for large
  text and meaningful graphics) against their actual background — check the
  seeded Material 3 scheme (`ColorScheme.fromSeed` in `FlashKidsApp.build`,
  `lib/main.dart`), do not assume it passes.
- Respect the platform text scale. Do not clamp `textScaler` to 1.0, and do not
  fix a height that only fits at the default scale. Test at ~200%: text may
  wrap, containers may grow, nothing may be cut off or unreachable.
- Do not hardcode colors or text styles the theme already provides
  (`flutter-widget-ui`).

## Motion, sound, and time

- Honour `MediaQuery.disableAnimations` / reduced-motion: an animation is
  decoration, and a child who is motion-sensitive still needs the screen.
- No content that flashes more than three times per second.
- Audio is a supplement, never the only way to receive information — a child
  with the sound off, or who is deaf, must still be able to play. Anything
  spoken has a visible equivalent.
- Do not impose a hidden time limit on an answer. If a timer is a real
  requirement, it is stated in the UI and the behavior is testable.

## Verify

- Widget tests assert semantics, not just pixels: use `find.bySemanticsLabel`
  and the `matchesSemantics` / `SemanticsTester` matchers for a control's flags
  (`flutter-testing`).
- Add a test that pumps the screen at a large `textScaler` when the layout has
  any fixed height.
- Cover the accessibility-relevant variants in the Widgetbook use-case when
  stories exist (`widgetbook-catalogue`).

## Procedure

1. Name who operates this screen and what they must be able to do without
   reading, without sound, and without color discrimination.
2. Build it with the target sizes, semantics, and second channels in place —
   not as a follow-up pass.
3. Add the semantics and text-scale assertions to the widget test.
4. Run `flutter-verify`. If you found an accessibility problem outside this
   task's scope, file it with `log-issue`.
