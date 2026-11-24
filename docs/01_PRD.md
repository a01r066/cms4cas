# CMS KISS: Product Requirements (v1)

**Source knowledge:** Kilby, Fox & Lucas, *Casino Operations Management*, 2nd ed. (Wiley, 2005).
Every calculation in the app cites its chapter and page. The book's figures describe Nevada and Atlantic City as of 2003, so all regulatory thresholds live in an editable **jurisdiction profile**. They are not hard-coded.

## 1. Vision
Give casino operators the tools to do daily what the book teaches: rate players on theoretical win, approve credit by a controlled process, keep table games and the cage accountable, comply with currency-transaction rules, and price promotions and premium deals before agreeing to them.

## 2. Target users and roles
| Role | Typical person | Main jobs in the app |
|---|---|---|
| Admin | IT / system owner | Users, roles, jurisdiction profile, rating parameters |
| Casino Manager | Games manager, shift manager | Hold dashboard, table opening & staffing, approves deals and credit |
| Pit Supervisor | Floorperson, pit manager | Rate players, openers/closers, fills/credits, table card |
| Cage Cashier | Cage, credit cashier | Cash transactions (MTL), front money, marker payments |
| Credit Executive | Credit manager, host | Credit applications, authorization flow, limits, collections |
| Compliance Officer | AML / internal audit | Aggregation, CTR drafts, barred list, SAR cases |
| Marketing / Host | Casino marketing, hosts | Comps, player action criteria, promotion & premium deal evaluator |
| Auditor | Internal / casino audit | Read-only access to everything, exception lists |

## 3. Problems solved (book grounding)
1. Players are comped on actual loss or on gut feeling; theoretical win is the correct basis (Ch12 p.220).
2. Credit decisions skip steps and approvals (Ch6 Fig 6.4, Table 6.2).
3. Hold % gets misread as a measure of honesty or performance (Ch13 p.241).
4. Missed currency aggregation leads to regulatory exposure (Ch5).
5. Promotions and rebates cost several times more than they appear to (Ch14–16).
6. Tables are over- or under-staffed (Ch4, Ch13).

## 4. v1 scope: modules
| # | Module | Must-have functionality | Book |
|---|---|---|---|
| 1 | Player rating | Player directory; rate session (game, avg initial bet, minutes, # players → speed, player type); theo; trip view with time-weighted average bet; actual vs theo; expected range (±1σ/±2σ) | Ch12, Ch19 |
| 2 | Comps & player action criteria | Comp eligibility from theo (configurable % of theo, quick-loss rule); criteria schedule generated from assumptions (Table 15.6) | Ch15, Ch16 |
| 3 | Table games & hold | Table registry; shift record (opener, fills, credits, markers issued/redeemed in pit, currency+cheques in drop box, closer) → drop, missing, win, hold, statistical drop; hits adjustment; hold diagnostic checklist; hold objective | Ch9, Ch10, Ch13 |
| 4 | Credit | Application; 27-step authorization flow as a guided checklist with stop rules; bank rating decoder; required signatures by line type/amount; approvals by authorized roles; TTO cap; marker ledger; collections status & settlement/write-off approvals | Ch6, Ch3 |
| 5 | Currency compliance | Cash transaction log (MTL) with gaming day cutoff; like-kind and single-visit aggregation; CTR threshold alerts; prohibited-transaction checks; barred patron list; SAR case with 30/60-day deadline | Ch5 |
| 6 | Promotion & deal evaluator | Match play / nonnegotiable cost and recovery; gambler's spree P&L & break-even; dead-chip program; rebate on loss (normal approx + MacDonald); premium trip contribution | Ch14–16 |
| 7 | Staffing & table opening | Dealer/floor headcount from stations by day/shift; labor per table; break-even bet by occupancy; occupancy vs profit scenario | Ch4, Ch13 |
| + | Knowledge library | Chapter notes, glossary search, "from the book" citations on every calculator | All |
| + | Settings | Jurisdiction profile, rating parameters, comp policy, users & roles | — |

**Later releases:** slot analytics (Ch7), drop & count + key control (Ch10), audit scheduler, game math lab/training (Ch8, Ch11), sports/race (Ch17–18), book-grounded AI assistant (RAG).

## 5. Non-functional requirements
- Flutter app for web (cage/back office), tablet (pit) and phone (managers).
- Works offline-first in local mode; Firebase (Auth + Firestore + Functions) when configured.
- Every money calculation reproducible: the engine is pure Dart with golden tests from the book.
- Audit trail: every record stores who created it and when; approvals are separate records.
- Input validation on every form; no button without a handler.

## 6. What is book knowledge vs. app additions
| Kind | Examples | How it's shown |
|---|---|---|
| Book knowledge | Formulas, thresholds, flows, default HAs and multipliers | "Book · Ch12 p.223" citation chip |
| Interpretation | Mapping # players → speed tier; using Table 13.1 for hands/hr | Labelled "App default (from Table 13.1)" |
| New functionality | Persistence, roles, alerts, jurisdiction profiles | Not attributed to the book |
