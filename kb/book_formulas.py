"""
Reference implementation of the quantitative knowledge in
Kilby, Fox & Lucas, *Casino Operations Management*, 2nd ed. (Wiley, 2005).

Every function cites the chapter/page it comes from. `BOOK_CHECKS` re-computes the
book's own worked examples; running this file asserts that each implementation
reproduces the printed result (within rounding). These checks become the golden
test fixtures for the production app (ported to Dart).
"""
import math

# ---------- Ch3 Gaming taxes ----------
def nv_taxable_win(gross_win, credit_issued_outstanding, prior_credit_collected):
    """NV cash-basis taxable gross gaming win (p.36)."""
    return gross_win - credit_issued_outstanding + prior_credit_collected

def nv_monthly_gaming_tax(taxable_win):
    """NV tiers: 3.5% first $50k, 4.5% next $84k, 6.75% above $134k (p.36)."""
    t1 = min(taxable_win, 50_000) * 0.035
    t2 = min(max(taxable_win - 50_000, 0), 84_000) * 0.045
    t3 = max(taxable_win - 134_000, 0) * 0.0675
    return t1 + t2 + t3

def nj_gaming_tax(gross_win, bad_debt_provision):
    """Atlantic City: 8% of adjusted win; adjusted = gross − min(4% gross, bad-debt provision) (p.39)."""
    return 0.08 * (gross_win - min(0.04 * gross_win, bad_debt_provision))

# ---------- Ch4 Staffing ----------
def dealers_per_shift(stations, on_min=60, off_min=20):
    """stations × (on+off)/on (p.54)."""
    return stations * (on_min + off_min) / on_min

def payroll_heads(weekly_shifts, days_worked=5, vacation_weeks=2):
    """weekly shifts ÷ 5 days × 52/(52−vacation) (p.56)."""
    return weekly_shifts / days_worked * 52 / (52 - vacation_weeks)

def floor_per_shift(bj_stations, tables_per_floor=4, cycle=480, worked=380):
    """1 floor station per 4 BJ tables; × 480/380; rounded UP (pp.56–57)."""
    return math.ceil(bj_stations / tables_per_floor * cycle / worked)

# ---------- Ch6 Credit ----------
def bank_rating_range(level, digits):
    """'Low 5' → $10,000–$39,999; Low=1, Med=4, High=7 (pp.92–93)."""
    base = {"low": 1, "med": 4, "high": 7}[level.lower()]
    nxt = {"low": 4, "med": 7, "high": 10}[level.lower()]
    lo = base * 10 ** (digits - 1)
    hi = nxt * 10 ** (digits - 1) - 1
    return lo, hi

def max_temporary_line(established_line, pct=0.25):
    """Temporary increases ≤ 20–25% of established line (p.102)."""
    return established_line * (1 + pct)

# ---------- Ch7 Slots ----------
def slot_win(drop, jackpots, fills, progressive_accrual=0.0):
    """Slot win = drop − jackpots − fills − progressive accrual (p.134)."""
    return drop - jackpots - fills - progressive_accrual

def slot_win_for_tax(drop, jackpots, fills):
    """NV tax basis excludes progressive accrual (p.135)."""
    return drop - jackpots - fills

def volatility_index(net_pays_and_hits, ev, z=1.65):
    """V.I. = z·σ, σ = sqrt(Σ (net_i − EV)² p_i) (pp.126–128)."""
    total = sum(h for _, h in net_pays_and_hits)
    var = sum(((n - ev) ** 2) * (h / total) for n, h in net_pays_and_hits)
    return z * math.sqrt(var), var

def payback_limits(payback, vi, games):
    """payback ± V.I./√games (p.129)."""
    d = vi / math.sqrt(games)
    return payback - d, payback + d

def lcg_6z_mod_13(seed=1, n=12):
    """Elementary PRNG from p.139."""
    out, z = [], seed
    for _ in range(n):
        z = (6 * z) % 13
        out.append(z)
    return out

# ---------- Ch9 Table games ----------
def table_drop(currency_and_cheques, markers_issued, markers_redeemed_in_pit):
    return currency_and_cheques + markers_issued - markers_redeemed_in_pit  # p.172

def cheques_missing(begin_inv, fills, credits, end_inv):
    return begin_inv + fills - credits - end_inv  # p.174

def table_win(drop, missing):
    return drop - missing  # p.174

def theoretical_win(avg_bet, hours, decisions_per_hour, house_adv, multiplier=1.0):
    """Ch12 p.221/223; Ch9 p.184."""
    return avg_bet * hours * decisions_per_hour * house_adv * multiplier

def prob_streak_loss(p_loss, n):
    return p_loss ** n  # p.186

# ---------- Ch11 Game math ----------
def pass_line_with_odds(x):
    """0.5090909 / (36 + 24x) (p.211)."""
    return 0.5090909 / (36 + 24 * x)

def ev(outcomes):
    """Σ p·payoff."""
    return sum(p * v for p, v in outcomes)

def keno_house_edge(spots, pays):
    """pays: {catch: total paid per $1}. Uses book's convention (p.216–218)."""
    tot = math.comb(80, spots)
    ways = {c: math.comb(20, c) * math.comb(60, spots - c) for c in range(spots + 1)}
    paid = sum(ways[c] * pays.get(c, 0) for c in ways)
    return (tot - paid) / tot, ways

# ---------- Ch13 Hold ----------
def hold(win, drop):
    return win / drop

def wagers_required_for_hold(hold_objective, house_adv):
    """× buy-in (p.249)."""
    return hold_objective / house_adv

def hits_adjust(total_win, total_drop, player_drop, player_result_for_casino):
    """Remove a documented 'hit': drop always removed; casino result reversed (p.249)."""
    return total_win - player_result_for_casino, total_drop - player_drop

def labor_cost_per_table(dealer_pay=50, floor_pay=150, burden=0.30, floor_ratio=0.25):
    """8-hour shift (p.251)."""
    dealer = 80 / 60 * dealer_pay * (1 + burden)
    floor = 480 / 380 * floor_ratio * floor_pay * (1 + burden)
    return dealer, floor, dealer + floor

def break_even_bet(hands_per_hour, players, house_adv, tax, labor_per_hour):
    """hands × players × HA×(1−tax) × Y = labor/hr (p.253)."""
    return labor_per_hour / (hands_per_hour * players * house_adv * (1 - tax))

# ---------- Ch14 Promotions ----------
def match_play_cost(face, cash_match, house_adv, with_exchange=True, tax=0.0):
    """Cost of a match play (pp.256, 259)."""
    p_win = 0.5 - house_adv / 2
    p_loss = 0.5 + house_adv / 2
    if with_exchange:
        coupon = p_win * face
        cash_gain = cash_match * house_adv * (1 - tax)
    else:
        times = 1 / p_loss
        coupon = face - face * times * house_adv
        cash_gain = cash_match * times * house_adv * (1 - tax)
    return coupon - cash_gain

def wagers_to_recover(cost, house_adv, tax=0.0625):
    return cost / (house_adv * (1 - tax))  # p.260

def dead_chip_wash(dead_chips, p_other_side_wins, house_adv):
    wagers = dead_chips / p_other_side_wins
    return wagers, wagers * house_adv  # p.268

# ---------- Ch15 Rebates ----------
def session_sd(bets_and_hands, sd_per_dollar):
    """sqrt(Σ bet²·n) × σ/$ (pp.285, 367–368)."""
    return math.sqrt(sum(b * b * n for b, n in bets_and_hands)) * sd_per_dollar

def macdonald_rebate_pct(a, n, y):
    """b = a·(yN·√N) / (0.5·yN·√N + 0.171·(yN)² + 0.408N) (p.288)."""
    yn = y * n
    k = yn * math.sqrt(n) / (0.5 * yn * math.sqrt(n) + 0.171 * yn ** 2 + 0.408 * n)
    return a * k

def macdonald_rebate_cost(b, n, y):
    yn = y * n
    k = yn * math.sqrt(n) / (0.5 * yn * math.sqrt(n) + 0.171 * yn ** 2 + 0.408 * n)
    return b / k

def effective_n(total_wagered, largest_bet):
    return total_wagered / largest_bet  # p.288

def player_action_criteria(credit, bet_pct=0.02, bets_won_per_hour=1.0, hours_per_night=4,
                           nights=3, markers_pct=0.60, bad_debt_pct=0.035, tax=0.0625):
    """Table 15.6 logic (pp.297–298)."""
    bet = credit * bet_pct
    theo = bet * bets_won_per_hour * hours_per_night * nights
    bad_debt = credit * markers_pct * bad_debt_pct
    taxes = (theo - bad_debt) * tax
    return {"bet": bet, "theo": theo, "bad_debt": bad_debt, "taxes": taxes,
            "available_for_comps": theo - bad_debt - taxes}

# ---------- Ch16 Premium ----------
def premium_trip_contribution(credit=150_000, bet_pct=0.02, hours=9, hands_per_hour=60,
                              eff_adv=0.0084, base_adv=0.0106, comp_pct=0.45, variable_pct=0.45,
                              airfare=9_000, tax=0.0625):
    """Table 16.2 (p.307)."""
    wagered = credit * bet_pct * hours * hands_per_hour
    theo = wagered * eff_adv
    rfb = wagered * base_adv * comp_pct * variable_pct
    return theo - rfb - airfare - theo * tax, theo, rfb

# ---------- Ch17 Sports ----------
def money_line_from_odds(fav, dog, line_cents=10):
    """7:5 → −140/+140 → 10¢ line −145/+135 (p.326)."""
    true = fav / dog * 100
    half = line_cents / 2
    return -(true + half), true - half

def money_line_disadvantage(fav, dog, fav_line, dog_line):
    """p.326–327; lines as positive magnitudes (fav_line=145 means −145)."""
    n = fav + dog
    dog_loss = (n * 1.0 - dog * (1 + dog_line / 100)) / n
    staked = n * fav_line / 100
    fav_loss = (staked - fav * (fav_line / 100 + 1)) / staked
    return fav_loss, dog_loss

def ideal_balance(fav_line, dog_line):
    """p.330."""
    f = fav_line / (fav_line + 100)
    d = 100 / (100 + dog_line)
    share = f / (f + d)
    book = 1 - (share * (100 / fav_line) + share)
    return share, book

def break_even_win_pct(cost):
    return cost / (cost + 100)  # p.330

def line_move_cents(line_size_cents):
    return line_size_cents / 2 if line_size_cents < 40 else line_size_cents / 4  # p.331

def parlay_edge(teams, pays_for_one):
    p = 0.5 ** teams
    return -(p * (pays_for_one - 1) + (1 - p) * -1)  # p.338 (house edge)

# ---------- Ch18 Race ----------
def parimutuel_payout_per_2(pool_total, on_horse, takeout=0.15, breakage=0.20):
    """True odds × (1−takeout), rounded down to 20¢ (pp.343–345)."""
    true_return = 2 * pool_total / on_horse
    raw = true_return * (1 - takeout)
    return math.floor(round(raw / breakage, 6)) * breakage

def house_quinella(win_pay, place_pay):
    return win_pay * 0.5 * place_pay  # p.353

def house_trifecta(win_pay, place_pay, show_pay):
    return win_pay * place_pay * show_pay * 1.20  # p.354

# ---------- Ch19 Stats ----------
def weighted_avg_bet(sessions):
    total = sum(h for _, h in sessions)
    return sum(b * h for b, h in sessions) / total

def bj_multi_spot_sd(n):
    return math.sqrt(1.26 * n + 0.50 * n * (n - 1))  # p.369


BOOK_CHECKS = [
    ("NV tax tiers on $200k", lambda: round(nv_monthly_gaming_tax(200_000), 2), round(1750 + 3780 + 66_000 * 0.0675, 2)),
    ("Dealers Mon BJ 40 stations", lambda: round(dealers_per_shift(40), 1), 53.3),
    ("BJ payroll 1066.5 shifts → 221.83", lambda: round(payroll_heads(1066.5), 2), 221.83),
    ("Floor Mon days 10 stations ×480/380 → 13", lambda: floor_per_shift(40), 13),
    ("Bank 'Low 5'", lambda: bank_rating_range("low", 5), (10_000, 39_999)),
    ("Bank 'High 4'", lambda: bank_rating_range("high", 4), (7_000, 9_999)),
    ("Temp line $10k → $12.5k", lambda: max_temporary_line(10_000), 12_500),
    ("Joker reel V.I. 90% = 8.01219", lambda: round(volatility_index(
        [(1, 28111), (-1, 2455), (-4, 1536), (-9, 559), (-49, 99), (-199, 7), (-399, 1)], 0.2392)[0], 3), 8.012),
    ("Par sheet 91.99% ±38.589 at 1,000", lambda: tuple(round(x, 2) for x in payback_limits(91.99, 1220.3, 1000)), (53.40, 130.58)),
    ("PRNG 6z mod 13", lambda: lcg_6z_mod_13(), [6, 10, 8, 9, 2, 12, 7, 3, 5, 4, 11, 1]),
    ("Table win marker system", lambda: table_win(table_drop(60_000, 100_000, 70_000), cheques_missing(140_000, 50_000, 10_000, 110_000)), 20_000),
    ("Table win name-credit system", lambda: table_win(table_drop(60_000, 100_000, 0), cheques_missing(140_000, 50_000, 10_000, 40_000)), 20_000),
    ("Theo roulette $150 2.25h", lambda: round(theoretical_win(150, 2.25, 60, 0.0526), 2), 1065.15),
    ("Theo BJ avg player $720", lambda: round(theoretical_win(150, 4, 80, 0.025, 0.60), 2), 720.0),
    ("Martingale 20 losses 1 in 375,899.74", lambda: round(1 / prob_streak_loss(20 / 38, 20), 0), 375_900),
    ("Pass line 4× odds 0.3857%", lambda: round(pass_line_with_odds(4) * 100, 4), 0.3857),
    ("Pass line 2× odds 0.6061%", lambda: round(pass_line_with_odds(2) * 100, 4), 0.6061),
    ("Baccarat bank incl ties −1.0579%", lambda: round(ev([(0.4585974, 0.95), (0.4462466, -1)]) * 100, 4), -1.0579),
    ("Keno 4-spot 27.13%", lambda: round(keno_house_edge(4, {4: 112, 3: 4, 2: 1})[0] * 100, 2), 27.13),
    ("Hold objective 25%/5.26% = 4.75×", lambda: round(wagers_required_for_hold(0.25, 0.0526), 2), 4.75),
    ("Labor per table $148.25", lambda: round(labor_cost_per_table()[2], 2), 148.25),
    ("Break-even bet 7 players $5.43", lambda: round(break_even_bet(52, 7, 0.01, 0.0625, 148.25 / 8), 2), 5.43),
    ("Break-even bet 1 player $9.46", lambda: round(break_even_bet(209, 1, 0.01, 0.0625, 148.25 / 8), 2), 9.46),
    ("$5 WE match play $2.3875", lambda: round(match_play_cost(5, 5, 0.015), 4), 2.3875),
    ("$5 WOE match play $4.7044", lambda: round(match_play_cost(5, 5, 0.015, with_exchange=False), 4), 4.7044),
    ("Match play after tax $2.3922", lambda: round(match_play_cost(5, 5, 0.015, tax=0.0625), 4), 2.3922),
    ("Wagers to recover $170.11", lambda: round(wagers_to_recover(2.3922, 0.015), 2), 170.11),
    ("Dead chip wash $224,598 / $2,785", lambda: tuple(round(x) for x in dead_chip_wash(103_000, 0.4585974, 0.0124)), (224_598, 2_785)),
    ("Session SD $500×100 = $4,756", lambda: round(session_sd([(500, 100)], 0.9512)), 4756),
    ("Uneven betting SD $1,345.66", lambda: round(session_sd([(120, 40), (200, 35), (50, 10), (5, 15)], 0.9512), 2), 1345.66),
    ("MacDonald a=50% N=1000 → 32.85%", lambda: round(macdonald_rebate_pct(0.5, 1000, 0.0136) * 100, 2), 32.85),
    ("MacDonald b=10% N=900 → 15.7%", lambda: round(macdonald_rebate_cost(0.10, 900, 0.0136) * 100, 1), 15.7),
    ("Effective N 1.99", lambda: round(effective_n(1999, 1000), 2), 2.0),
    ("Player action criteria $3,000 line → $616", lambda: round(player_action_criteria(3000)["available_for_comps"]), 616),
    ("Premium trip contribution ≈ $280", lambda: round(premium_trip_contribution()[0]), 280),
    ("Money line 7:5 10¢", lambda: money_line_from_odds(7, 5), (-145, 135)),
    ("Money line disadvantages 1.4368%/2.0833%", lambda: tuple(round(x * 100, 4) for x in money_line_disadvantage(7, 5, 145, 135)), (1.4368, 2.0833)),
    ("Ideal balance −150/+130", lambda: tuple(round(x, 6) for x in ideal_balance(150, 130)), (0.579832, 0.033613)),
    ("Break-even −160 = 61.5%", lambda: round(break_even_win_pct(160) * 100, 1), 61.5),
    ("3-team parlay 25%", lambda: parlay_edge(3, 6), 0.25),
    ("Pari-mutuel Baby Blue $4.20", lambda: round(parimutuel_payout_per_2(2000, 800), 2), 4.20),
    ("House quinella $777", lambda: house_quinella(74, 21), 777),
    ("House trifecta $13,799.52", lambda: round(house_trifecta(74, 21, 7.40), 2), 13_799.52),
    ("Weighted avg bet A $416.67", lambda: round(weighted_avg_bet([(500, 2), (450, 4), (700, 1), (300, 5)]), 2), 416.67),
    ("BJ 7-spot SD 5.4608", lambda: round(bj_multi_spot_sd(7), 4), 5.4608),
]

if __name__ == "__main__":
    fails = 0
    for name, fn, expected in BOOK_CHECKS:
        got = fn()
        ok = got == expected
        fails += not ok
        print(("PASS" if ok else "FAIL"), name, "→", got, "" if ok else f"(book: {expected})")
    print(f"\n{len(BOOK_CHECKS) - fails}/{len(BOOK_CHECKS)} book examples reproduced")
