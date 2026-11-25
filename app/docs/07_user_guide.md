# 07 · User guide

Conventions used everywhere: **positive results mean the casino won**; **Book** citations (green chips on phones, small tags on desktop) open the source page reference; fields marked * are required.

## Finding your way around

- **Desktop and web (wide windows):** the sidebar on the left groups the modules by department: *Floor* (Players & ratings, Table games & hold), *Cage & credit* (Credit & markers, Currency compliance), *Planning* (Promotions & deals, Staffing) and *Reference* (Knowledge library). Settings and your name are at the bottom; the arrow next to your name switches user or signs out. The tag at the top right shows the current gaming day.
- **Phone:** the bar at the bottom holds Home, Players, Tables and Credit; **More** opens every other module. Tap your initials at the top right to switch user or sign out.
- **Home** shows the gaming day, the day's key figures, the hold chart for the last 14 gaming days (desktop) and *Needs attention*: totals over the CTR threshold, SAR cases due within 7 days and credit applications awaiting signatures. Select an item to go straight to it.

## Getting started

1. Open the app. On a new installation you are asked to create the first administrator.
2. **Settings** → set the casino name and jurisdiction label. Check the AML thresholds, gaming-day start hour, tax rate and comp policy against your local regulation. *Reset to book defaults* restores the book's Nevada-2003 figures.
3. **Settings → Users & roles** → add each person with a role, and a credit role for anyone who signs credit (see `03_architecture.md`).
4. Each user signs in (cloud mode) or picks their name (local mode).

### Trying the app with demo data

- **Local mode:** sign in as an administrator → **Settings → Demo data → Load demo data**. You get staff for every role, 14 players with rated sessions, 10 tables with two weeks of shifts, credit applications, markers and compliance records. The demo staff appear on the sign-in screen, so you can see the app as a pit supervisor, cage cashier or compliance officer. **Remove demo data** deletes only demo records (ids starting `demo-`) and keeps your own profile.
- **Firebase dev project:** an administrator runs `bash app/tool/seed_demo_data.sh` (see the README). Demo staff sign in as `demo.<role>@cms4cas.test` with the password chosen when seeding. The script refuses the production project.

## Registering and signing in (Firebase)

- **Create an account:** on the sign-in screen choose *Create an account*, enter your full name, work email and a password (at least 8 characters). You are signed in straight away, but see only a *waiting for a role* screen. Confirm your email with the link we send.
- **Administrators:** *Settings → Users and roles → Waiting for a role* lists new registrations. *Assign role* opens the usual user form with the name and email filled in; *Dismiss* removes a request you don't recognise. As soon as a role is assigned, the person's screen opens the app — they don't need to sign in again.
- **Forgot password:** type your email on the sign-in screen and choose *Forgot password?*; a reset link is emailed.
- **New casino:** the very first account may choose *Set up as first administrator*. After that, only administrators assign roles.

## Players and ratings (Ch 12)

- **Players** → *Add player*: name, player number, ID document, address.
- Open a player → **Rate play**: choose the game, enter the **initial** average bet (not doubles or splits), the time played, average players at the table, and the player type (when unsure choose the more conservative type). Enter the actual result if known. Theo updates as you type. **Save**.
- The player page shows trip theo, actual result, time-weighted average bet, hours, comp allowance (the lower of % of theo and, if enabled, the quick-loss % of actual loss) and the expected ±2σ range of results.

## Table games and hold (Ch 9–10, 13)

- **Hold tools** → add your tables once (game, pit, limits, base hold %, marker or name-credit system).
- **Record shift** at each close: opener, fills, credits, closer, currency and cheques in the drop box, markers issued and redeemed in the pit. Drop, win, hold and statistical drop are calculated and saved.
- **Hold dashboard**: choose 1 d / 7 d / 30 d / 1 y. The chart shows hold for each of the last 14 gaming days against the objective band (base hold ± tolerance); hover a day to see its drop, win and objective. One day's hold swings a lot, so judge staff on the period: in *By table*, tables outside base hold ± tolerance show **Investigate**.
- Before blaming staff, work through **Hold tools → diagnostics checklist**, and record large documented player results under **Hits** so they can be removed from the adjusted hold.

## Credit and markers (Ch 6)

1. **Credit → New application**: player, line type (permanent / temporary), amount.
2. Answer the Fig 6.4 questions (ID verified, bank rating, Central Credit report, prior credit, amounts owed) → **Run assessment**. The outcome is one of: ready for decision, proceed with caution, refer to credit manager, do not issue, incomplete.
3. Authorized users **Sign**. The panel says whether the signatures meet Table 6.2 for this amount and line type.
4. **Approve** or **Decline** (with reason).
5. **Markers & collections** → *Issue marker* (capped at available credit), record payments, add collection notes. Aging buckets show 0–30 / 31–60 / 61–90 / over 90 days. A write-off needs two different authorized signers.

## Currency compliance (Ch 5)

- **Cash log**: record every cash transaction over the MTL threshold and smaller ones that may aggregate. Choose a known patron or describe an unknown one. Turn on *Same continuous visit* when the single-visit rule applies. Barred patrons are blocked with an alert.
- **Aggregation & CTR**: totals per patron, gaming day and direction (cash-in and cash-out are never netted). When a total exceeds the CTR threshold, **Start CTR**, complete the required fields, mark *prepared*; a **different** user reviews; then mark *filed*.
- **Barred**: add, deactivate or review barred patrons.
- **SAR cases**: open a case, see the due date (30 days; +30 with extension when the subject is unidentified), mark filed. Visible only to admin, compliance, casino manager and auditor.

## Promotions and deals (Ch 14–16)

Each tab is a calculator; change any input and the result updates.

| Tab | Answers |
|---|---|
| Match play | What a coupon really costs, with/without exchange, and how much play recovers it |
| Package program | Gambler's spree P&L and break-even play |
| Rebate on loss | Effective house advantage after a rebate (exact model), MacDonald formula, graduated schedule |
| Premium deal | Expected contribution of a premium player's trip after rebate, comps and airfare |
| Dead chips | Wash, cost and effective advantage of a dead-chip program |
| Comp schedule | Player action criteria for a given credit line |

## Staffing (Ch 4, 13)

Enter tables open per day and shift for blackjack, craps and baccarat; adjust dealing/break minutes, days per week, vacation weeks and tables per floorperson. Read dealers per shift, weekly heads, floorpersons and payroll. **Table opening economics** shows labour per table and the break-even average bet at each occupancy.

## Library

Search chapter notes and the glossary (168 terms). Use it with the Book chips to check any figure.

## Good practice

- Keep local mode for training only. Live operations: cloud mode, one account per person, never shared.
- Review Settings whenever regulations change; the change applies to new records only — stored ratings and shifts keep the values used at the time.
