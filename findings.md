# Findings

Data: NPCI monthly UPI totals, Aug 2016 to Sep 2026 (122 months). FY17 (8 months) and FY27 (Apr–Sep 2026) are partial, so growth and CAGR only use complete years FY18–FY26. App and P2P/P2M data: Sep 2024 to Aug 2026 (24 months).

## Day 3: Growth, ticket size, seasonality

### A1. Yearly growth (Q1)
- UPI went from 0.9 bn transactions (₹1.10 lakh cr) in FY18 to 241.6 bn (₹314.23 lakh cr) in FY26.
- YoY volume growth has dropped every year since FY22: 105.8% → 82.2% → 56.6% → 41.7% → 30.0%. The FY21 dip (78.4%) was probably COVID, and it bounced back in FY22.
- In absolute terms it's holding up. FY26 added 55.7 bn transactions, about the same as FY25 (54.8 bn). So UPI adds roughly 55 bn a year now, and the % falls because the base keeps getting bigger.
- Value growth is falling faster than volume: 20.6% vs 30.0% in FY26.

### A2. CAGR (Q1)
- Volume grew 264x from FY18 to FY26, a CAGR of 100.8% over 8 years. On average, UPI doubled every year.
- Value CAGR is a bit higher at 102.8%. That surprised me at first, but FY26's average ticket (₹1,301) is still slightly above FY18's (₹1,200), so value grew a little faster end to end. The rise and fall in between only shows in A4.

### A3. Last 24 months (Q2)
- YoY volume growth cooled from 33–39% (Nov 2024 to May 2025) to 21.5–24.9% since Mar 2026. Sep 2026 is at 22.6%. So yes, % growth is slowing.
- The 3-month rolling average still rose almost every month, from 15.53 bn to 24.08 bn. Usage keeps climbing, just at a lower rate.
- Value grew slower than volume in all 24 months, but the gap is closing: about 12 pp in early 2025 vs 2–5 pp in 2026. Ticket sizes are still falling, just more slowly.
- Sep 2026 shows -1.8% MoM, but Sep has 30 days and Aug has 31. Per day it's up about 1.5%.
- Oct 2024 YoY (45.4%) is inflated because Diwali fell on Oct 31 in 2024 vs Nov 12 in 2023.
- Jul 2026 (23.66 bn) and Aug 2026 (24.51 bn) match the numbers reported in the news, so my data checks out.

### A4. Average ticket size (Q3)
- Average ticket peaked at ₹1,838 in FY21 and has fallen every year since, to ₹1,301 in FY26 (-29%). FY27 so far is ₹1,259.
- UPI is now used for small daily payments (tea, groceries, autos), not just bank transfers.
- FY17's ₹3,912 is only 8 months right after launch with very few users, so I left it out of the trend.

### A5. Seasonality (Q6)
I used volume per day so 28/30/31-day months compare fairly, averaged from 2021 onwards.
- October is strong at +5.9%, 2nd highest, which fits the festive season.
- November is weak at +1.3% because it comes off a high October. Oct + Nov together come to about +7.3%, the same as two normal months (avg ~3.6% each). So the festive season moves spending into October more than it adds extra.
- February is the highest (+6.3%). My guess is fixed monthly payments (rent, bills, EMIs) get packed into fewer days.
- May is the weakest (+0.4%), likely pulled down by the May 2021 lockdown. January (+1.7%) is a post-December lull.
- Oct–Dec use 5 years of data and the rest use 6, since my data ends in Sep 2026.

## Day 4: Apps, concentration, P2P vs P2M

### B1. Market share, Aug 2026 (Q4)
- Top 2 hold 77.9%: PhonePe 45.6%, Google Pay 32.3%. Paytm 8.0%, Navi 4.4%.
- CRED has the highest ticket (₹3,988 vs ~₹1,275 for PhonePe/GPay), likely credit-card bill payments.

### B2. Concentration (Q4)
- Top-2 share fell from 85.4% to 77.9% in 24 months; HHI 3,757 → 3,215. Still highly concentrated (above 2,500).
- Most of the drop is Google Pay (-5.1 pp). PhonePe fell only 2.4 pp.

### B3. Challengers (Q5)
- Navi: +113.9% YoY, +1.88 pp share, now #4. Biggest gainer.
- Paytm recovering (+1.00 pp). BHIM (rank 9 → 6) and WhatsApp (11 → 8) also climbed.
- CRED lost the most ground (rank 6 → 10). Tiny apps show huge % growth but under 0.1% share, so I ignored them.

### B4. P2P vs P2M (Q7)
- P2M is 63.3% of volume but only 30.0% of value, matching PIB's ~63%.
- P2M ticket ₹577 vs P2P ₹2,319 (4x). P2P ticket fell 12% in 24 months; P2M stayed flat.

## Takeaways so far
1. UPI grew 264x in 8 years and now adds about 55 bn transactions a year.
2. % growth has settled in the low 20s, which is expected at this scale.
3. Payments are getting smaller (₹1,838 → ₹1,301), so growth is coming from everyday spending, but that drop is slowing down.
4. The PhonePe–Google Pay duopoly is loosening (top-2: 85.4% → 77.9%), mostly at Google Pay's cost.
5. Navi is the standout challenger; CRED is losing rank.
6. Two-thirds of UPI payments go to shops, but they carry under a third of the money.
