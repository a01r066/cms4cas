# 05 · UI / UX design

Screenshots of every module, desktop (1440 px) and phone (390 px), are in `docs/screenshots/` (`wide_*.png`, `phone_*.png`), taken from the release web build with the demo data loaded (updated 2026-11-25).

## Principles

1. **Show the formula's inputs and the answer together.** Every calculator updates live as you type; nothing is hidden behind a "Calculate" button except actions that change records (save, sign, file).
2. **Every number can be traced to the book.** Citation tags ("Book · Ch13 p.249") sit beside the result they justify and open the full reference. Values that are app defaults rather than book figures are labelled as such (for example hands per hour for games the book does not time).
3. **Say what to do, not just what the number is.** Callouts translate results into the book's guidance: "Hold reflects count timing, credit policy, occupancy and player mix as much as staff performance — check the hold tools before drawing conclusions (Ch13)."
4. **Roles shape the screen.** Actions a role cannot perform are not shown; read-only users see the same data with no edit controls.
5. **Separation of duties is visible.** Signature lists show who signed and in which credit role; CTR cards show preparer and reviewer.
6. **Quiet chrome, rich data.** On desktop the navigation, buttons and text stay neutral; the one rich element on a screen is the data itself (the hold chart).

## Layout

| Width | Navigation | Content |
|---|---|---|
| ≥ 1000 px (web, desktop, tablets in landscape) | Light sidebar (256 px) grouped by department — Home · Floor (Players, Tables) · Cage & credit (Credit, Compliance) · Planning (Promotions, Staffing) · Reference (Library); Settings and the signed-in user (with sign-out) at the bottom. Top bar: page title and a gaming-day tag | Fills the width up to 1,440 px, left-aligned; forms keep a narrower width; tables span their card; stat rows fit on one line (up to 5) |
| < 1000 px (phones) | Floating dark-green bottom bar: Home, Players, Tables, Credit and **More** (opens the drawer with every module). Account menu behind the initials in the top bar | Single column with room below for the bottom bar; card headers stack their actions under 560 px; wide tables scroll sideways |

Sub-areas of a module use tabs (e.g. Table games: Hold dashboard · Record shift · Hold tools); on desktop the tabs sit at the left.

Pop-up forms (add table, add player, user, credit application, issue marker, barred patron, SAR case) keep 16 px between fields so floating labels and hints never touch the field above.

## Visual system

Defined in `lib/core/theme/theme.dart` (`Brand` colours, `AppPalette` theme extension, `Radii`). `buildTheme(brightness, desktop: …)` returns the phone theme or the quieter desktop variant; `app.dart` switches at 1000 px. Light and dark modes follow the system.

| Token | Phone | Desktop (≥ 1000 px) |
|---|---|---|
| Brand colours | Forest `#1D5A3C` (headers, bottom bar, primary buttons), lime `#B4E86A` (call-to-action), mint `#E6F2EA` (icon tiles), canvas `#F5F8F6` | Same palette; forest is the only accent in the chrome; lime only marks the selected sidebar row and (dark mode) the highlighted chart day |
| Semantic colours | Good `#2E7A50`, warning `#A8661C`, danger `#B4473F` — toned to sit inside the palette, used only for meaning (status, losses) | Same; statuses are a small dot plus a label (`StatusText`) |
| Type | System font (Roboto on Android/web, SF on iOS); headings 700–800 | Headings 600, body 400, labels 500; tabular figures everywhere so columns of money line up |
| Shapes | Pill buttons and chips, cards 20 px radius | Controls 10 px, cards 16 px, tags 6 px; 1 px hairline borders, no shadows |
| Signature | Green Book chips | Mono **ledger tags** (`LedgerTag`) for citations and the gaming day |
| Numbers | Money with currency symbol; whole dollars for totals, cents for unit costs; percentages to 1–2 decimals unless the book uses more | Same |
| Sign convention | Positive = casino wins (stated on every input that takes a result) | Same |
| Empty states | Icon + one line + the action that fills it | Same |

### Hold chart

`features/tables/presentation/widgets/hold_chart.dart`, on Home (desktop) and the Tables hold dashboard. It shows hold (win ÷ drop) for each of the last 14 gaming days against the objective band: the drop-weighted base hold of the tables played ± the hold tolerance in Settings. Bars are neutral and the latest day is highlighted; hovering a day shows its drop, win and objective. Single days are not flagged because one day's hold swings widely — the ±tolerance rule is applied per table over the selected period in the *By table* list, which shows **Investigate**.

## Key screens

| Screen | Purpose | Primary action |
|---|---|---|
| Home | Desktop: date and gaming day, four figures with comparisons (theo 24 h, hold 7 days vs objective, outstanding markers and amount over 60 days, CTRs in progress), hold chart, *Needs attention* list (reportable totals, SARs due ≤ 7 days, credit awaiting signatures). Phone: green header with outstanding markers and three actions, quick-access tiles, alerts, figures | Rate a player |
| Players → player | Trip theo, actual, weighted average bet, comp allowance, expected ±2σ range, credit summary, sessions | Rate play |
| Rate play | Rating card (Fig 12.1) with live theo | Save rating |
| Table games | Hold dashboard by period with the 14-day hold chart, flags outside base hold ± tolerance; shift entry; diagnostics, hold objective, documented hits | Record shift |
| Credit | Applications (Fig 6.4 assessment, signatures, approve/decline); markers & collections (aging, payments, write-off) | New application / Issue marker |
| Currency compliance | Cash log (MTL), aggregation & CTR workflow, barred list, SAR cases | Record |
| Promotions & deals | Six evaluators side by side in tabs | — (calculators) |
| Staffing | Dealer & floor plan; table-opening economics | — (calculators) |
| Library | Chapter notes and glossary search | Search |
| Settings | Jurisdiction profile, policies, per-game figures, users & roles, demo data (admins) | Save / Reset to book defaults |

## Accessibility

- Material components with semantic labels; all actions reachable by keyboard on web.
- Colour is never the only signal: statuses carry a label next to their dot ("Investigate", "Declined"), losses carry a minus sign.
- The phone bottom bar exposes each item to screen readers as a selectable button with its label.
- Text scales with system settings; layouts tested at phone width without overflow (automated test).

Known gap: strings are in English only and not yet in ARB files; Vietnamese localisation is a straightforward next step.
