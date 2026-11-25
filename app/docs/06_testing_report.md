# 06 · Testing report

Last run on 2026-11-25 with Flutter 3.50.1 / Dart 3.14, after adding demo data, the brand theme and the desktop web layout.

| Suite | Command | Result |
|---|---|---|
| Book formula check (Python, independent implementation) | `python3 kb/book_formulas.py` | **45 / 45** book examples reproduced |
| Engine golden & rule tests | `cd packages/casino_engine && dart test` | **65 / 65** pass |
| App tests: models, domain, notifiers (through the privileged actions), registration, demo data, widgets | `cd app && flutter test` | **38 / 38** pass |
| Cloud Functions (Node.js 24, real SDKs loaded): all 8 callables are 2nd gen in asia-southeast1; JS port of Table 6.2; marker balance | `cd firebase/functions && npm test` | **6 / 6** pass |
| Static analysis | `flutter analyze` | 0 errors, 0 warnings (infos only: `material.dart` deprecation in Flutter 3.50) |
| Release web build | `flutter build web --release --no-web-resources-cdn` | builds |
| Browser check | Playwright + Chrome on the release build with demo data, desktop 1440 px and phone 390 px, light and dark | all 11 screens render (screenshots in `docs/screenshots/`); first-run admin creation and reload persistence verified |

The Python and Dart implementations were written separately; both reproduce the same book figures, which guards against a mistake being copied from one into the other.

## Firebase emulator checks (Auth + Firestore, firebase-tools 15)

| Check | Result |
|---|---|
| `create-user.js`: admin with password, staff with reset link, registrant approved (request removed), role change keeps password and credit role, `--credit-role none`, hidden prompt (not echoed), bad role / credit role / short password / no terminal rejected | all as expected; created accounts sign in with the chosen password |
| `access_requests` rules: own request with own email allowed; other uid, other email, extra `role` field refused; own `users` profile not writable; no data readable without a role | 7 / 7 as expected |
| `seed-demo-data.js` via `tool/seed_demo_data.sh`: 548 documents and 9 logins written; a demo pit supervisor signs in, reads players and is refused a direct marker write by the rules; a 3-day-old file moves its dates forward; re-running replaces rather than duplicates; `--remove` leaves no demo documents or logins; `--project prod` and the production project id are refused | all as expected |

## Calculations verified against the book (engine tests)

**Credit (Ch 6).** Signature matrix (Table 6.2): permanent $40k, $80k, >$100k; temporary tiers; duplicate signer counts once; cage director is not a credit executive; write-off needs two authorized roles (p.105). Authorization flow (Fig 6.4): clean applicant reaches steps 23–27; incomplete stops at step 1; "4 in 14" refers to credit manager; owed derogatories → do not issue; after-hours with no bank info → proceed with caution. Bank codes Low 5/High 4 (p.93); temporary increase $10k → $12.5k (p.102).

**Currency reporting (Ch 5).** Single-visit rule $4k + $4k chips + $4k losing wager → $12k reportable (p.71); without single visit only like-kind aggregates → no report; Title 31 $5,000 front money + $5,001 chips → report (p.74); cash-in never combined with cash-out; gaming-day cutoff splits a night (p.72); two $2,000 jackpots → MTL (p.63); prohibited transactions and SAR due date.

**Taxes & management (Ch 3–4).** NV tiers on $200,000 (p.36); Atlantic City adjusted win (p.39); Monday BJ 40/40/20 → 133.3 dealers (p.55); 1,066.5 weekly shifts → 213.30 → 221.83 (p.56); floor staffing 13 and 7 (p.57); busiest day binds 74.67 vs 80 (p.59).

**Slots & table games (Ch 7, 9, 11).** Joker-wild volatility index 8.01219 (p.128); par-sheet range 53.40 %–130.58 % at 1,000 pulls (p.123); PRNG 6z mod 13 (p.139); marker vs name credit same $20,000 win (p.174); Martingale 1 in 375,899.74 (p.186); pass line with odds (p.211); roulette 5.26 % (p.214); baccarat edges with/without ties (pp.214–216); tie bet 9-for-1/10-for-1 (p.300); keno 4-spot 27.13 % (p.218); BJ 6 decks H17 0.76 % (Table 11.5); Ch12 rule set 0.26 % (p.223).

**Rating, hold, marketing (Ch 12–16).** Roulette $1,065.15 (p.221); average BJ player $720 (p.223); game speed interpolation (Table 13.1); hold objective 4.75× (p.249); utilization 20.9 % vs 5.2 % (p.244); $5 match play (p.257); after-tax $2.3922 → $170.11 → 34.02 hands → 40.8 min (pp.259–260); gambler's spree (Table 14.1); dead-chip wash $224,598 / $2,785 / 3.7 h (pp.268–269); dead-chip bonus effective HA (pp.271–273); Table 16.1 and Table 15.3 rebate effective HA (exact model); equivalent bet $488 (Table 15.2); MacDonald 32.85 % and 15.7 % (pp.288–289); session SD $4,756 and $1,345.66; 10 % rebate ≈ 35–38 % of theo (p.286); premium trip ≈ $280 (Table 16.2); action criteria for a $3,000 line (Table 15.6); comps quick-loss vs theo basis.

**Sports, race, statistics (Ch 17–19).** 7:5 → −145/+135 (pp.326–327); ideal balance 57.98 % / 3.36 % (p.330); 3-team parlay 25 % and line moves (pp.331, 338); pari-mutuel $4.20, house quinella $777, trifecta $13,799.52 (pp.344–354); mean/median/variance/SE (pp.359–363); weighted average bet $416.67 vs $110.42 (p.364); multi-spot BJ SD (p.369).

## App tests

| File | What it proves |
|---|---|
| `models_test.dart` | Settings round trip with overrides; model defaults equal the engine's book profile; table shift stores computed win/hold; documents written before the refactor still read (wire values unchanged); unknown enum values fall back safely |
| `domain_test.dart` | Available credit; time-weighted average bet (p.364); role permissions and least-privilege fallback; referred application needs a Credit Manager signature; CTR completeness |
| `notifiers_test.dart` | `setUserRole`: first user must be admin, a non-admin cannot escalate. Credit end to end: assess → submit → sign (no double signing) → approve only when Table 6.2 is met → marker capped at available credit **even when the client sends a wrong figure** → payment → write-off refused without two authorized signers, then settled. CTR: fields required, reviewer ≠ preparer, filed. Hits below threshold rejected. SAR cases hidden from roles that may not read them |
| `registration_test.dart` | Registration validation; local backend refuses registration with a clear message; only admins see requests; approving creates the profile and removes the request; dismissing; full flow against a Firebase-shaped fake: forgot password, mismatched passwords rejected, waiting screen, self-promotion refused once an admin exists, approval opens the app without signing in again |
| `demo_data_test.dart` | The generated set covers all 13 collections with `demo-` ids, is deterministic, and every record parses through its model; it contains the book's roulette rating (theo $1,065.15, p.221); every table shift passes validation and BJ-04 holds below objective; approved credit lines meet Table 6.2 while pending and referred ones do not; open markers fall in every aging bucket and the settled write-off has two authorized signers; cash transactions produce the reportable aggregates behind the CTRs. Loading and removing through the notifier (admin only, local backend only) keeps the signed-in admin; the Settings card loads the data |
| `widget_test.dart` | First run → every module opens; phone width without overflow; corrupted data shows an error; deep link while signed out returns there after sign-in; tabs keep their own stack (desktop sidebar); rating a session through the form saves theo $766.50 |

## Differences from the printed book (errata)

| Where | Book prints | App computes | Reason |
|---|---|---|---|
| Table 14.1 gambler's spree, minimum play | −$229.24 | −$229.27 | The book's own line items sum to −$229.27 |
| p.56 weekly BJ dealers | 221.83 | 221.87 (UI) / 221.83 (test with book rounding) | Book rounds each shift before summing |
| Table 16.1, 25 % rebate at 100 hands | 0.01 % | −0.01 % | Exact trinomial model; sign lost in print |

The full list (six items) is in the Phase 1–3 document. None changes a business conclusion.

## Known limitations

- **Local mode has no password.** It is for evaluation and training. Use cloud mode for live data.
- **Jurisdiction figures are the book's (Nevada, 2003).** Thresholds are editable in Settings; the operator must confirm them against current local regulation (for Vietnam, the applicable decree and State Bank reporting rules).
- **Decisions per hour** for some games (pai gow, pai gow poker, Caribbean stud) are app defaults where the book gives no timing; they are labelled in the UI and editable.
- **Not covered in v1:** slot floor analytics, drop & count with key control, audit scheduler, sports/race operations UI (engine functions exist and are tested), localisation, PDF/CSV export.
- **Fonts on web** fall back to Google Fonts for some symbols; offline deployments should bundle a font (no functional impact). The app uses the system font; a brand typeface is not bundled yet.
- **Cloud Functions** were not exercised in the Functions emulator here (the Dart twins of every callable are tested through the notifiers, and the JS signature port is unit-tested). Auth and the Firestore rules were checked in the emulators (above). Run `firebase emulators:start` with functions before going live.
- **The desktop layout's dialogs** were checked by reading the code and the widget tests, not by a rendered screenshot.
- **Android/iOS flavor builds** were not compiled here (no Android SDK / Xcode); the web build was.
