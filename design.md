# design.md — FlashKids UI/UX and concept style

> **Status:** normative design contract. This document decides *how* FlashKids
> UI must look and behave. It is **not** evidence that any screen, token,
> component, asset, or theme file described here exists. Today the repository is
> a single-package Flutter bootstrap whose only screen lives in `lib/main.dart`.
> Build what a task asks for; do not create the vocabulary below as a side
> effect.

Read this together with `AGENTS.md` (binding), `CLAUDE.md` (always-on rules),
`docs/adr/0001-feature-first-slices-riverpod-go-router.md` (architecture), and
the skills `flutter-widget-ui`, `flutter-a11y-kids-ui`, `flutter-l10n`,
`widgetbook-catalogue`.

## 0. How to use this file as a system prompt

You are designing and implementing UI for a children's learning app. When a task
touches any pixel, layout, copy, motion, sound, or interaction in FlashKids,
adopt the following operating rules for the whole task.

1. **Precedence.** `AGENTS.md` and accepted ADRs outrank this file. This file
   outranks personal taste, framework defaults, and any pattern you have seen in
   another app. When this file and the code disagree, that is a conflict: stop
   the affected part and put both sides to the user with `file.dart:line`
   references (`AGENTS.md` → Conflicts). Never silently pick one.
2. **Name the operator first.** Before writing a widget, state in one sentence
   who uses this screen — child or parent — and what they must be able to do
   *without reading, without sound, and without distinguishing colors*. That
   sentence decides the layout.
3. **Design the state matrix, not the happy path.** Every screen owes: empty,
   loading, populated, error, offline (once network exists), and any locked or
   disabled variant. A screen with only a populated state is unfinished.
4. **Do not invent tokens, palettes, fonts, mascots, or asset pipelines.**
   Section 12 lists what is deliberately undecided. If a task needs one of
   those, ask; do not settle it in passing.
5. **Accessibility is part of the build, never a follow-up pass**
   (`flutter-a11y-kids-ui`).
6. **Finish with `flutter-verify`.** Report the design checklist in §11 as part
   of "done".

## 1. Product concept

FlashKids teaches through flashcards: a card shows something, the child
responds, the app answers immediately and moves on. Sessions are short, repeated
often, and usually happen on a parent's device that the child borrows.

**Two audiences, two zones. This split is the single most important design
decision in the app.**

| | Kid Zone | Parent Zone |
|---|---|---|
| Ages | 3–10, including pre-readers | Adult |
| Purpose | Play, learn, repeat | Configure, review progress, manage account |
| Density | Very low — one decision per screen | Normal adult density |
| Reading required | None to minimal | Yes |
| Targets | Oversized (§5) | Standard Material 3 |
| Destructive / money / external links / account settings | **Never present** | Only here |
| Entry | Default after launch | Behind a parent gate (§9) |

The two zones must be visually distinguishable within one second: the Kid Zone
is large, rounded, illustrated, and playful; the Parent Zone is compact,
text-led, and plainly utilitarian. A screen that could belong to either zone is
a design defect.

## 2. Design principles

Ordered. When two conflict, the earlier one wins.

1. **Picture and sound first, text second.** A pre-reader must be able to
   complete a full session without reading a word. Text is a reinforcement
   channel, never the only carrier of meaning.
2. **One decision per screen.** A Kid Zone screen asks for exactly one thing.
   Secondary actions either move to another screen or do not exist.
3. **No dead ends and no traps.** Every Kid Zone screen has one obvious way
   back or forward, always in the same position. A child must never be stranded
   in a state they cannot leave without an adult.
4. **Failure is cheap and never scolding.** A wrong answer gets a calm,
   encouraging response and an immediate retry. No red-alarm styling, no
   scores that shame, no life/heart mechanics that end a session on mistakes.
5. **Reward effort, not just correctness.** Progress feedback responds to
   attempts and completion, not only to accuracy.
6. **Predictable over novel.** The same control means the same thing, sits in
   the same place, and animates the same way on every screen. Consistency is
   what makes an interface learnable by a five-year-old.
7. **Nothing important is behind a gesture.** Taps are primary. Swipe, drag,
   long-press, and multi-touch may only *supplement* an action that also has a
   plainly visible tap target.
8. **The adult stays in control of consequences.** Anything that spends money,
   deletes data, leaves the app, or changes settings lives in the Parent Zone.

## 3. Concept style — visual language

**Mood:** warm, calm, generous, hand-made-friendly. Bright but not neon;
playful but not chaotic. The screen should feel like a picture book, not a
game console or an arcade.

**Shape language.** Round is the whole vocabulary. Cards and sheets use a large
corner radius; buttons for children are pill-shaped or circular. No sharp
90° corners on any child-facing surface. Keep one radius scale across the app
and do not mix radii within a single component.

**Depth.** Prefer flat surfaces separated by fill color and generous space.
Elevation is used sparingly and only to say "this floats above the rest" —
a dialog, a bottom sheet, the active flashcard. Do not stack more than two
levels of visible elevation on one screen.

**Composition.** One dominant focal object (the card, the picture, the primary
button) occupying the visual center, surrounded by air. Empty space is a
feature, not waste. Chrome — app bars, labels, counters — stays quiet and small
relative to the focal object.

**Illustration.** Simple, high-contrast, clearly silhouetted subjects on plain
backgrounds. A picture must be recognizable at a glance and at small size. No
busy backgrounds behind text. Decorative art is `ExcludeSemantics`. The approved
art direction is flat, modern picture-book vector illustration: matte pastel
fills, soft rounded geometric forms, generous negative space, and no neon,
photorealism, or 3D gloss. The Kid Zone mascot is a friendly purple baby sloth.
Source artwork is authored as transparent PNG files under `assets/images/`;
composited legacy and favicon icons may use their approved flat background.

**Personality of motion.** Springy and short, never floaty. Motion confirms
what a tap did; it does not entertain by itself (§7).

**Typography.** Use the Material 3 type scale through `Theme.of(context)`.
Kid Zone: one short line, large size (display/headline roles), high weight,
generous line height, never more than two lines of running text on a card.
Parent Zone: body and label roles at their normal sizes. Never hardcode a
`TextStyle` the theme already provides (`flutter-widget-ui`).

## 4. Color

**The theme is Material 3, seeded from `Colors.deepPurple`
(`ColorScheme.fromSeed` in `FlashKidsApp.build`, `lib/main.dart`). Do not change
the seed, and do not introduce a second palette, as part of an unrelated
task.** Changing it is a repository-wide decision that needs the user's approval
and a doc update in the same change.

Rules:

- **Take colors from `ColorScheme` roles**, never from `Colors.*` literals in a
  widget: `primary`/`onPrimary` for the main action, `surface`/`onSurface` for
  content, `surfaceContainer*` for grouping, `error`/`onError` for failure,
  `secondary`/`tertiary` for accents. If a role you need does not exist, that is
  a theme decision, not a widget-local constant.
- **Color is never the only channel.** Correct, incorrect, selected, locked,
  and disabled each carry a second signal — icon, shape, position, motion, or
  text. Assume the child cannot tell your two colors apart.
- **Contrast is measured against the real background**, not assumed: WCAG AA,
  4.5:1 for body text, 3:1 for large text and meaningful graphics. Illustrated
  or tinted backgrounds are where this usually breaks.
- **Semantic feedback colors.** Positive feedback uses the theme's success-side
  accent consistently across the app; negative feedback uses `error` but always
  softened by shape and copy (§2.4). Pick these role mappings once, in the
  theme, and reuse them — a widget must not decide what "correct" looks like.
- Dark mode is not implemented. Do not half-implement it: either a task asks
  for it and it is done properly in the theme, or the app stays light-only.

## 5. Layout, sizing, and spacing

- **Spacing scale: multiples of 8 dp** (4 dp allowed only for tight
  icon/text pairing). No arbitrary paddings.
- **Touch targets.** 48×48 dp is the absolute floor everywhere
  (`flutter-a11y-kids-ui`). In the Kid Zone, the primary action of a screen is
  at least 64×64 dp, and the main play/answer control should be substantially
  larger than that. `IconButton` gives you the floor; a `GestureDetector` on an
  `Icon` or `Text` does not — set `constraints`.
- **Separation.** At least 16 dp of clear space between adjacent Kid Zone
  targets, and more around any control that ends or exits a session. Two
  targets flush against each other are one mistake waiting to happen.
- **Reachability.** Primary actions sit in the lower half of the screen, within
  thumb reach. Back/exit stays in the same corner on every screen. Never place a
  session-ending or zone-leaving control adjacent to a frequently tapped one.
- **No fixed heights on content that holds text.** Layouts grow. Test at ~200%
  text scale; nothing may be clipped, overlapped, or pushed out of reach. Do not
  clamp `textScaler`.
- **Orientation and size.** Design phone-portrait first; the layout must survive
  landscape and tablet width without stretching a single column across the whole
  screen. Constrain content width and center it rather than letting cards grow
  unboundedly.
- **Safe areas.** Respect `SafeArea` and keyboard insets; nothing interactive
  under a notch, a home indicator, or the keyboard.

## 6. Component vocabulary

Names below are the shared vocabulary for discussing FlashKids UI. **None of
them exist yet.** Create one only when a task asks for it, in the owning
feature's `presentation/` directory, one widget per file
(`flutter-feature-slice`).

- **Flashcard** — the focal surface: picture, optional word, optional audio
  trigger. States: idle, revealed, correct, incorrect, disabled.
- **Answer control** — the oversized tap target(s) the child uses to respond.
  States: idle, pressed, correct, incorrect, disabled.
- **Play-audio control** — always visible when audio exists; never the only way
  to get the information (§7).
- **Deck tile** — an entry point to a set of cards. States: available,
  in-progress, completed, locked (locked shows a lock icon *and* muted styling).
- **Progress indicator** — session progress as a count and a shape, readable
  without numbers.
- **Session summary** — what was practised, framed as encouragement.
- **Feedback overlay** — the immediate reaction to an answer; short, then out
  of the way. Never blocks the retry.
- **Parent gate** — see §9.
- **State placeholders** — empty, loading, error, offline. Each has an
  illustration, one line of copy, and, where an action can help, exactly one
  button.

Every component takes an **immutable view-state object**, not a spread of
nullable booleans (`flutter-widget-ui`). If a component needs to know "correct",
that is a state value, not three flags the caller must combine correctly.

## 7. Motion, sound, and time

- **Durations.** Micro-feedback ~100–200 ms; screen and card transitions
  ~200–350 ms. Anything above 400 ms in a child flow is too slow to repeat.
- **Curves.** Standard Material easing; springy for the flashcard flip and for
  answer feedback. Motion always starts from the thing the child touched.
- **Reduced motion is honoured.** Check `MediaQuery.disableAnimations` /
  `MediaQuery.of(context).accessibleNavigation` and degrade to a cross-fade or
  no animation. The screen must remain fully usable.
- **No flashing** above three times per second, anywhere, ever.
- **Audio is a supplement.** Every spoken word, sound cue, or narrated
  instruction has a visible equivalent on screen. The app is fully playable
  muted, and a mute/volume control is always reachable.
- **No hidden timers.** Do not impose a time limit on an answer. If a timer is
  an explicit requirement, it is visible, announced, and testable.
- **Autoplay restraint.** Audio does not start on its own after a return to the
  app; the child or parent starts it.

## 8. Copy and voice

- **No user-facing literal in a widget.** All strings come from the localization
  layer (`flutter-l10n`), including semantics labels.
- **Kid Zone voice:** short, present tense, concrete, encouraging. Ideally 3–6
  words. Address the child directly. No sarcasm, no exclamation-mark spam, no
  negative framing ("wrong", "you failed"). Prefer "Try again" over "Incorrect".
- **Parent Zone voice:** plain, factual, unpatronising. It may use full
  sentences and domain words.
- **Semantics labels say what a control does**, not what it looks like: "play
  the word", not "speaker icon" (`flutter-a11y-kids-ui`).
- **Numbers and dates** are localized, never string-concatenated.

## 9. The parent gate

Any route that leaves the Kid Zone — settings, purchases, account, external
links, data deletion, anything irreversible — is reachable only through a parent
gate.

- The gate is a **deliberate adult action** a young child is unlikely to pass by
  chance (for example a written instruction plus a non-obvious input). It is not
  a single "Are you sure?" tap.
- It sits **away from frequently tapped controls**, and its entry point is
  quiet: an adult should find it, a child should not stumble into it.
- Passing the gate is **not permanent**; leaving the Parent Zone returns to the
  Kid Zone.
- The gate is an accessibility surface too: it must be operable by an adult
  using a screen reader.
- **The concrete challenge mechanism is not decided** (§12). Do not invent one
  as a side effect; ask.

## 10. Widgetbook and the state matrix

`docs/widgetbook_executable_spec.md` is a proposal, and **no catalogue entry
point exists**. Do not create `widgetbook/` as a side effect of a UI change
(`widgetbook-catalogue`).

When stories do exist, a component's story covers the full state matrix from
§6 plus the accessibility-relevant variants: large text scale, long localized
string, reduced motion, and locked/disabled. Stories are specification;
assertions belong in tests (`flutter-testing`).

## 11. UI Definition of Done

In addition to the repository Definition of Done (`flutter-verify`), a UI change
is done only when all of these are true:

- [ ] The screen states from §0.3 are designed, not just the happy path.
- [ ] Zone is unambiguous: it reads as Kid Zone or Parent Zone at a glance.
- [ ] Every interactive element meets the size and separation rules in §5.
- [ ] No destructive, purchase, external-link, or settings action sits in the
      Kid Zone.
- [ ] Colors come from `ColorScheme` roles; no `Colors.*` literal in the widget.
- [ ] Every state that uses color also uses a second channel.
- [ ] Contrast checked against the actual background.
- [ ] Semantics labels present, decorative visuals excluded, control + label
      merged into one node; selected/disabled/correct exposed as flags.
- [ ] Layout verified at ~200% text scale and in landscape; nothing clipped.
- [ ] Animation degrades under reduced motion; nothing flashes >3 Hz.
- [ ] Audio content has a visible equivalent; the flow works muted.
- [ ] No user-facing literal; strings and labels come from localization.
- [ ] Widget test asserts semantics and the large-text-scale layout.
- [ ] Docs this change made false are updated in the same change
      (`sync-docs`) — including this file, if a decision here changed.

## 12. Deliberately undecided

Do not settle any of these on your own. If a task needs one, stop and ask the
user (`AGENTS.md` → Conflicts).

- Whether the `deepPurple` seed stays for the product, and the final palette.
- Dark mode.
- Typeface. The app currently uses the Material 3 default; no font package is a
  dependency.
- The concrete parent-gate challenge.
- Card content domains (letters, numbers, vocabulary, language pairs) and the
  session length and repetition model.
- Sound design, voice-over language coverage, and whether narration is recorded
  or synthesized.
- Onboarding, profiles/multiple children, and any monetization surface.
- Offline behavior, because no data layer exists yet (`flutter-persistence`).
