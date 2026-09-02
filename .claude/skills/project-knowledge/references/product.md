# FlashKids — the product

Source of truth: `design.md` (normative UI/UX and concept-style contract).
Everything here is a digest of it; `design.md` wins on any disagreement.

## What the app does

FlashKids teaches through **flashcards**: a card shows something, the child
responds, the app answers immediately and moves on. Sessions are **short,
repeated often**, and usually happen **on a parent's device that the child
borrows** (`design.md` §1). That last fact is why the app is split in two.

## The two zones — the single most important decision

`design.md` §1. The zones must be distinguishable **within one second**. A
screen that could belong to either zone is a design defect.

| | Kid Zone | Parent Zone |
|---|---|---|
| Ages | 3–10, **including pre-readers** | Adult |
| Purpose | play, learn, repeat | configure, review progress, manage account |
| Density | very low — **one decision per screen** | normal adult density |
| Reading | none to minimal | yes |
| Touch targets | oversized: ≥64×64 dp primary | standard Material 3 (≥48×48 dp) |
| Destructive / money / external links / settings | **never present** | only here |
| Entry | default after launch | behind a **parent gate** |
| Look | large, rounded, illustrated, playful | compact, text-led, utilitarian |

## Design principles, in precedence order

`design.md` §2 — when two conflict, the earlier wins.

1. **Picture and sound first, text second.** A pre-reader completes a full
   session without reading a word.
2. **One decision per screen** in the Kid Zone.
3. **No dead ends, no traps.** One obvious way back or forward, same position
   every screen. A child is never stranded without an adult.
4. **Failure is cheap and never scolding.** Calm response, immediate retry. No
   red alarms, no shaming scores, no lives/hearts that end a session.
5. **Reward effort, not just correctness.** Feedback responds to attempts and
   completion, not only accuracy.
6. **Predictable over novel.** Same control, same place, same meaning, same
   animation — that is what makes it learnable by a five-year-old.
7. **Nothing important is behind a gesture.** Taps are primary; swipe/drag/
   long-press only supplement a visible tap target.
8. **The adult owns consequences.** Money, deletion, leaving the app, settings.

## Visual language

`design.md` §3–§5. Mood: warm, calm, generous, hand-made — *a picture book, not
a game console*.

- **Shape:** round is the whole vocabulary; no 90° corners on a child-facing
  surface; one radius scale.
- **Depth:** flat surfaces separated by fill and space; elevation only for
  "this floats" (dialog, sheet, active card); max two visible levels.
- **Composition:** one dominant focal object surrounded by air; chrome stays
  quiet and small.
- **Illustration:** simple, high-contrast, clearly silhouetted, plain
  background, recognizable at a glance and at small size. Decorative art is
  `ExcludeSemantics`.
- **Type:** Material 3 type scale through `Theme.of(context)`. Never hardcode a
  `TextStyle` the theme provides.
- **Color:** Material 3 seeded from `Colors.deepPurple` (`ColorScheme.fromSeed`
  in `FlashKidsApp.build`, `lib/main.dart`). Take colors from `ColorScheme`
  roles, never `Colors.*` literals in a widget. **Color is never the only
  channel** — correct/incorrect/selected/locked/disabled each carry a second
  signal. WCAG AA contrast measured against the real background. **Do not change
  the seed or add a palette as part of another task.**
- **Spacing:** multiples of 8 dp (4 dp only for tight icon/text pairing).
- **Separation:** ≥16 dp between adjacent Kid Zone targets, more around
  session-ending controls.
- **Reachability:** primary actions in the lower half; back/exit in the same
  corner on every screen.
- **Growth:** no fixed heights on text; must survive ~200% text scale and
  landscape/tablet; never clamp `textScaler`.

## Motion, sound, and time

`design.md` §7.

- Micro-feedback ~100–200 ms; transitions ~200–350 ms; **>400 ms is too slow**.
- Springy for card flip and answer feedback; motion starts from what was
  touched.
- **Reduced motion is honoured** (`MediaQuery.disableAnimations` /
  `accessibleNavigation`) — degrade to cross-fade or none, stay usable.
- **No flashing above 3 Hz, anywhere, ever.**
- **Audio is a supplement.** Everything spoken has a visible equivalent; the app
  is fully playable muted; mute is always reachable.
- **No hidden timers.** No time limit on an answer unless explicitly required,
  and then visible, announced, and testable.
- **No autoplay** after returning to the app.

## Copy and voice

`design.md` §8. No user-facing literal in a widget — everything comes from the
localization layer, **including semantics labels** (`flutter-l10n`).

- **Kid Zone:** short, present tense, concrete, encouraging, ideally 3–6 words.
  Address the child. "Try again", never "Incorrect" or "You failed".
- **Parent Zone:** plain, factual, unpatronising; full sentences allowed.
- **Semantics say what a control does**, not what it looks like: "play the
  word", not "speaker icon".

## The component vocabulary

`design.md` §6 — shared names for discussion. **None of them exist in code.**
Create one only when a task asks, in the owning feature's `presentation/`.

Flashcard (idle / revealed / correct / incorrect / disabled) · Answer control
(idle / pressed / correct / incorrect / disabled) · Play-audio control · Deck
tile (available / in-progress / completed / locked) · Progress indicator ·
Session summary · Feedback overlay · Parent gate · State placeholders (empty /
loading / error / offline).

Every component takes an **immutable view-state object**, not a spread of
nullable booleans.

## The parent gate

`design.md` §9. Any route leaving the Kid Zone — settings, purchases, account,
external links, data deletion, anything irreversible — is reachable only through
it.

- A **deliberate adult action** a young child is unlikely to pass by chance.
  Not a single "Are you sure?" tap.
- Entry point is quiet and sits away from frequently tapped controls.
- **Not permanent** — leaving the Parent Zone returns to the Kid Zone.
- Must be operable by an adult using a screen reader.
- **The concrete challenge is undecided** (§12). Ask; do not invent one.

## Every screen owes a state matrix

`design.md` §0.3: empty, loading, populated, error, offline (once network
exists), plus any locked/disabled variant. **A screen with only a populated
state is unfinished.**

## UI Definition of Done

`design.md` §11 — thirteen checkboxes, on top of the repository Definition of
Done (`flutter-verify`). The substance: states designed not just the happy path;
zone unambiguous; sizes and separation met; nothing destructive in the Kid Zone;
`ColorScheme` roles only; second channel beside color; contrast checked against
the real background; semantics present and merged, decorative excluded; verified
at ~200% text scale and in landscape; motion degrades and nothing flashes >3 Hz;
audio has a visible equivalent; no user-facing literal; a widget test asserting
semantics and large text scale; docs updated in the same change.

## What is deliberately undecided

`design.md` §12. **Do not settle any of these; ask the user.**

Whether `deepPurple` stays and the final palette · dark mode · typeface ·
mascot, illustration style guide, and asset pipeline · the parent-gate challenge
· **card content domains (letters, numbers, vocabulary, language pairs), session
length, and the repetition model** · sound design, voice-over coverage,
recorded vs. synthesized narration · onboarding, profiles/multiple children,
monetization · offline behavior.

Note the third item from last: **the actual teaching content of the app is not
decided.** FlashKids knows exactly how a card must look and behave, and not yet
what is on it.

## The image-prompt proposal

`concepts/` (Vietnamese) holds image-generation prompts for mascot, flashcard
subjects, deck covers, feedback, progress/rewards, state placeholders,
onboarding/avatars, Parent Zone, backgrounds, app icon, and store listing —
~150 assets at full maturity, ~30 for a first release, with 16 marked
"draw in code, no image file".

It is **an unapproved proposal**, by its own README: `design.md` §12 lists the
mascot and illustration guide as undecided. It authorises nothing in `lib/` or
`pubspec.yaml`. Approving it means recording the decision in `design.md` §3 and
§12 **in the same change**. It is untracked in git (`git status`: `?? concepts/`).
