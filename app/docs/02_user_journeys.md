# 02 · User journeys

Each journey names the role (see `03_architecture.md` → Roles), the screens it touches and the book pages it implements. Diagrams are Mermaid; GitHub and most IDEs render them.

## J1 · First run (administrator)

```mermaid
flowchart LR
  A[Open app] --> B{Any users?}
  B -- no --> C[Create first administrator]
  B -- yes --> D[Pick user / sign in]
  C --> E[Settings: casino name, jurisdiction profile]
  E --> F[Add users and roles]
  F --> G[Home]
  D --> G
```

Local mode keeps everything on the device. Cloud mode signs in with Firebase email/password; roles are assigned by the `setUserRole` function, never by the client.

## J2 · Rate a player's session (pit supervisor) — Ch 12 pp.221–225, Ch 19 pp.357–376

```mermaid
sequenceDiagram
  actor PS as Pit supervisor
  participant App
  PS->>App: Players → search / add player
  PS->>App: Rate play
  PS->>App: game, initial bet, time, players at table, player type
  App-->>PS: live theo = bet × hours × decisions/hr × HA × multiplier
  PS->>App: actual result (+ = casino won)
  PS->>App: Save
  App-->>PS: Player page: trip theo, weighted avg bet, comp allowance, ±2σ range
```

Rules taken from the book: record the **initial** bet (not doubles/splits, p.225); decisions per hour drop as players join (Table 13.1); comps use theoretical, not actual, loss (p.220).

## J3 · Close a table shift and investigate hold (pit/cage) — Ch 9–10, Ch 13

```mermaid
flowchart TD
  A[Record shift: opener, fills, credits, closer, drop] --> B[Win = drop − (opener + fills − credits − closer)]
  B --> C[Hold % = win ÷ drop]
  C --> D{Outside base hold ± tolerance?}
  D -- no --> E[Dashboard: OK]
  D -- yes --> F[Flag table]
  F --> G[Hold tools: diagnostics checklist]
  G --> H[Remove documented hits from hold]
  H --> I[Statistical hold, incl. markers repaid with cheques]
```

## J4 · Issue credit (credit executive, casino manager) — Ch 6 pp.91–110, Fig 6.4

```mermaid
flowchart TD
  A[New credit application] --> B[Answer Fig 6.4 questions: ID, bank, CCA, prior credit, outstanding]
  B --> C[Run assessment]
  C --> D{Outcome}
  D -- do not issue --> X[Decline]
  D -- refer to credit manager --> R[Credit manager signs]
  D -- ready / caution --> S[Collect signatures per Table 6.2 matrix]
  R --> S
  S --> T{Signatures sufficient for amount + line type?}
  T -- no --> S
  T -- yes --> U[Approve line]
  U --> V[Issue markers ≤ available credit]
  V --> W[Payments · aging buckets · collection notes]
  W --> Y{Uncollectable?}
  Y -- yes --> Z[Write-off with two authorized signatures]
```

## J5 · Cash transaction compliance (cage, compliance officer) — Ch 5 pp.61–82

```mermaid
flowchart TD
  A[Log cash transaction] --> B{Patron barred?}
  B -- yes --> X[Block + alert]
  B -- no --> C{≥ MTL threshold $3,000 or aggregate?}
  C --> D[Multiple Transaction Log entry]
  D --> E[Aggregate per patron, gaming day, direction, like-kind]
  E --> F{> $10,000 one direction?}
  F -- yes --> G[CTR draft → prepared → reviewed by a different user → filed]
  E --> H{Suspicious pattern?}
  H -- yes --> I[SAR case: 30-day due date, +30 if subject unknown]
```

Cash-in and cash-out are never netted against each other (p.66). The gaming-day cutoff and thresholds live in the jurisdiction profile, so a property outside Nevada edits them in Settings instead of code.

## J6 · Evaluate a promotion or deal (marketing, casino manager) — Ch 14–16

```mermaid
flowchart LR
  A[Promotions & deals] --> B[Match play coupon cost]
  A --> C[Package / gambler's spree P&L]
  A --> D[Rebate on loss: exact model + MacDonald]
  A --> E[Premium player deal]
  A --> F[Dead chip program]
  A --> G[Comp schedule]
  B & C & D & E & F & G --> H[Decision with book citation]
```

## J7 · Staff the pit (casino manager) — Ch 4 pp.51–59, Ch 13

Enter tables opened per day and shift → dealers per shift (×80/60 relief), weekly heads (÷5 × 52/50 vacation), floorpersons (1 per N tables, rounded up per shift) → payroll → table-opening break-even by occupancy (Table 13.2).

## J8 · Look something up (anyone) — all chapters

Library: chapter notes with page references, plus a 168-term glossary. Every calculation screen carries "Book · Ch x p.y" chips that point to the same source.
