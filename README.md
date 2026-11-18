# Synthetic instance and demand generator for “A Two-Stage Stochastic Allocation Model for Empty Containers and Tarpaulins under Railway Tarpaulin Accumulation”

This repository accompanies the paper *“A Two-Stage Stochastic Allocation Model for Empty Containers
and Tarpaulins under Railway Tarpaulin Accumulation”* (IMDS 2026).

**Status.** The synthetic network instance and the held-out demand generator are released here, so
that the instance reported in Section 4.1 and the batches used in Section 4.2 can be inspected and
regenerated. The solver and the experiment scripts that produce Tables 1–8 are being prepared and
**will be added to this repository upon acceptance of the paper**; a table-by-table reproduction
guide will ship with them.

All files are kept in the repository root so that the scripts run without any folder setup: put the
download in one folder, `cd` into it, and run.

## The instance

| Quantity | Value |
|---|---|
| Supply stations | 14 (489 twenty-ft + 129 forty-ft = 747 TEU; 308 tarpaulins) |
| Demand stations | 12 (42 twenty-ft + 11 forty-ft = 64 TEU of local stock; 135 tarpaulins; 784 TEU of cumulative budgets) |
| Network totals | 811 TEU and 443 tarpaulins (supply plus local stock) |
| Links | 168 directed supply–demand links, 7-day planning horizon |
| Scenarios | 8, with weights summing to 1 |

All quantities are the synthetic instance described in Section 4.1 of the paper. Station labels are
identifiers and do not report actual inventories.

## Files

| File | Content |
|---|---|
| `source_stocks.csv` | supply stations: `Stock20`, `Stock40` (boxes), `StockTarp` (tarpaulins) |
| `destination_stocks_budgets.csv` | demand stations: `Local20`, `Local40` (boxes), `LocalTarp` (tarpaulins), `BudgetTEU` (cumulative budget) |
| `links.csv` | `Source`, `Destination`, `DistanceKm`, `TimeHour`, `DailyCapacity` (boxes/day), and stage prices `Pre20`, `Pre40`, `PreTarp`, `Rec20`, `Rec40`, `RecTarp` (CNY per unit) |
| `scenario_weights.csv` | `Scenario`, `Weight` (probability), `CapacityMultiplier` |
| `demand20.csv`, `demand40.csv`, `demand_tarp.csv` | baseline demand, destinations (rows) × scenarios (columns), seven-day totals |
| `parameters.json` | penalties, substitution caps, budget weights and solver settings |
| `generateTest.m` | held-out demand generator, reproduced verbatim from the experiment code |
| `makeScenarioBatch.m` | reads the instance and returns one batch for a given seed |
| `demo_generate_batch.m` | runs the six seeds of Section 4.2 and prints each batch |

## Regenerating the held-out batches

No toolbox is needed for this part.

```matlab
cd <this folder>
demo_generate_batch
```

or, for a single batch:

```matlab
b = makeScenarioBatch(20261012, 32);
```

Multipliers (Section 4.2): common U(0.85, 1.15), station U(0.90, 1.10), daily U(0.95, 1.05),
tarpaulin intensity U(0.20, 0.65) per TEU, tarpaulin weather U(1.00, 1.10); container demand is
rounded, tarpaulin demand rounded upward. The perturbed-demand check reported in Section 4.3 uses
seed 20261109.

## License and citation

Data files and code: see `LICENSE` (code MIT, data CC BY 4.0). Please cite the paper.
