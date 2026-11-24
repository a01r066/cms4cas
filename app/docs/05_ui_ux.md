# 05 · UI / UX design

Screenshots of every module, desktop (1440 px) and phone (390 px), are in `docs/screenshots/` (`wide_*.png`, `phone_*.png`), taken from the release web build.

## Principles

1. **Show the formula's inputs and the answer together.** Every calculator updates live as you type; nothing is hidden behind a "Calculate" button except actions that change records (save, sign, file).
2. **Every number can be traced to the book.** Green "Book · Ch x p.y" chips sit beside the result they justify. Values that are app defaults rather than book figures are labelled as such (for example hands per hour for games the book does not time).
3. **Say what to do, not just what the number is.** Callouts translate results into the book's guidance: "Hold reflects count timing, credit policy, occupancy and player mix as much as staff performance — check the hold tools before drawing conclusions (Ch13)."
4. **Roles shape the screen.** Actions a role cannot perform are not shown; read-only users see the same data with no edit controls.
5. **Separation of duties is visible.** Signature lists show who signed and in which credit role; CTR cards show preparer and reviewer.

## Layout

| Width | Navigation | Content |
|---|---|---|
| ≥ 1000 px | Extended navigation rail with full labels | Two-column card grids where useful |
| < 1000 px | Drawer with short labels (Home, Players, Tables, Credit, Compliance, Promotions, Staffing, Library, Settings) | Single column; card headers stack their actions below the title under 560 px; wide grids scroll sideways |

Sub-areas of a module use tabs (e.g. Table games: Hold dashboard · Record shift · Hold tools).

## Visual system

| Token | Value |
|---|---|
| Colour | Material 3 scheme from seed `#0B5D4B` (felt green); red for losses/overdue, amber for warnings |
| Cards | Flat, 14 px radius, 1 px outline |
| Numbers | Money with currency symbol; whole dollars for totals, cents for unit costs; percentages to 2 decimals unless the book uses more |
| Sign convention | Positive = casino wins (stated on every input that takes a result) |
| Empty states | Icon + one line + the action that fills it |

## Key screens

| Screen | Purpose | Primary action |
|---|---|---|
| Home | Alerts (reportable aggregates, SARs due ≤ 7 days, pending credit), day metrics, quick actions | Jump into the task |
| Players → player | Trip theo, actual, weighted average bet, comp allowance, expected ±2σ range, credit summary, sessions | Rate play |
| Rate play | Rating card (Fig 12.1) with live theo | Save rating |
| Table games | Hold dashboard by period, flags outside base hold ± tolerance; shift entry; diagnostics, hold objective, documented hits | Record shift |
| Credit | Applications (Fig 6.4 assessment, signatures, approve/decline); markers & collections (aging, payments, write-off) | New application / Issue marker |
| Currency compliance | Cash log (MTL), aggregation & CTR workflow, barred list, SAR cases | Record |
| Promotions & deals | Six evaluators side by side in tabs | — (calculators) |
| Staffing | Dealer & floor plan; table-opening economics | — (calculators) |
| Library | Chapter notes and glossary search | Search |
| Settings | Jurisdiction profile, policies, per-game figures, users & roles | Save / Reset to book defaults |

## Accessibility

- Material components with semantic labels; all actions reachable by keyboard on web.
- Colour is never the only signal: flags also carry text ("Investigate"), losses carry a minus sign.
- Text scales with system settings; layouts tested at phone width without overflow (automated test).

Known gap: strings are in English only and not yet in ARB files; Vietnamese localisation is a straightforward next step.
