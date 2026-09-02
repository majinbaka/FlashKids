# Where the authoritative answer lives

The digest saves a scan. This file says which document to open when the answer
must be exact — before writing code, approving a phase, or deciding a contract.

## Precedence

`AGENTS.md` and accepted ADRs **outrank** `design.md`, which outranks personal
taste, framework defaults, and patterns from other apps (`design.md` §0.1). The
code outranks any document's claim that something *exists*; a document outranks
the code on what *should* be. Those two disagreeing is a conflict for the user,
not a judgement call (`AGENTS.md` → Conflicts).

## Routing table

| Question | Authoritative source |
|---|---|
| May I do this at all? change discipline, ownership, abstraction, security | `AGENTS.md` |
| The always-on working rules, the skill index | `CLAUDE.md` |
| Architecture, layering, dependency direction, why `get_it`/layer-first were rejected | `docs/adr/0001-feature-first-slices-riverpod-go-router.md` |
| How to write a new ADR; what is and is not ADR-worthy | `docs/adr/README.md`, `docs/adr/TEMPLATE.md` |
| Who the app is for, zones, principles, color, sizing, motion, copy, the parent gate, the UI DoD | `design.md` |
| What is undecided and must be asked | `design.md` §12 |
| Widgetbook direction, prototype sandbox, phased plan | `docs/widgetbook_executable_spec.md` — **proposal** |
| Image/asset prompts | `concepts/` — **unapproved proposal**, untracked |
| What the app actually does today | `lib/main.dart` |
| What is actually tested | `test/` |
| The exact Definition of Done, as run by CI | `.github/workflows/ci.yml`, `AGENTS.md` → Definition of done |
| Which commands run without prompting; the format hook | `.claude/settings.json`, `.claude/hooks/format-dart.sh` |
| Known problems nobody is fixing yet | `deferred-work/` |
| How to do a specific kind of change | the matching skill in `.claude/skills/` |
| Why something was done this way | `git log`, then the commit's message |

## Which skill for which task

`AGENTS.md`/`CLAUDE.md` index these; the mapping worth memorising:

- new feature, or moving behavior out of `main.dart` → `flutter-feature-slice`
- any screen, widget, or story → `flutter-widget-ui` (+ `design.md`)
- providers, notifiers, view state, overrides → `flutter-riverpod-state`
- adding/renaming/removing/redirecting a route → `flutter-routing`
- models, DTOs, Freezed, JSON, `build_runner` → `flutter-data-model`
- any test → `flutter-testing`
- **before reporting anything complete** → `flutter-verify` (or `/dod`)
- any user-facing string, including semantics labels → `flutter-l10n`
- targets, semantics, contrast, text scale, motion, audio → `flutter-a11y-kids-ui`
- anything that can fail; the first error boundary → `flutter-error-handling`
- the first thing that outlives the session → `flutter-persistence`
- the Widgetbook executable and its use-cases → `widgetbook-catalogue`
- committing, branching, opening a PR → `commit-and-pr`
- a problem outside the current task → `log-issue` (or `/defer <slug>`)
- after any code change → `sync-docs`

## Freshness

The digest was written from commit `3616f3c` (2026-09-02), when `lib/` held one
file. Before relying on it for work you are about to build:

```sh
git log --oneline 3616f3c..HEAD -- \
  AGENTS.md CLAUDE.md design.md README.md docs/ lib/ test/ pubspec.yaml \
  deferred-work/ .claude/ .github/
```

Empty output means the digest is current. Otherwise read what those commits
changed, answer from the sources, and update this skill in the same change
(`CLAUDE.md` rule 4).

Three cheap signals that the digest has gone stale regardless of git:

```sh
ls lib/                 # anything beyond main.dart means slices exist now
ls widgetbook/ 2>/dev/null || echo 'no catalogue'   # Phase 2 landed?
ls deferred-work/       # new items since this digest
```

## What this digest deliberately does not contain

- **Line numbers into other files.** They rot — the repository has already
  logged one stale-line-reference item
  (`deferred-work/2026-09-02-a11y-skill-stale-line-reference.md`). Cite symbols
  and section numbers; resolve to a line only when you are looking at the file.
- **The full text of `AGENTS.md`, `design.md`, or the spec.** A second copy of a
  contract is a second source of truth, and the repository's own rule 5 treats
  that as a defect waiting to happen. Summaries here point; they do not replace.
- **Any decision from `design.md` §12.** Those belong to the user.
