# Optimal Portfolio Rebalancing via Stochastic Optimal Control

**Course Project — Optimal Control Theory | IIT Delhi (M.Tech EE, 2025)**

This project applies the **Hamilton-Jacobi-Bellman (HJB) equation** to derive the analytically optimal continuous-time investment strategy for a two-asset portfolio, and validates it via Monte Carlo simulation in MATLAB.

---

## The Core Result

The HJB equation applied to a stochastic wealth SDE yields a closed-form optimal control law — the **Merton Proportion**:

$$u^* = \frac{\mu - r}{\gamma \, \sigma^2}$$

| Symbol | Meaning |
|--------|---------|
| `μ` | Expected stock return |
| `r` | Risk-free rate |
| `σ` | Stock volatility |
| `γ` | Investor risk aversion (CRRA coefficient) |

This is the **constant fraction of wealth** to invest in the risky asset at all times — regardless of current wealth or time remaining. It is derived purely from market parameters and investor preferences.

---

## Background

The portfolio rebalancing problem is formulated as a **stochastic optimal control problem**:

**State equation (Wealth SDE):**
```
dW_t = [r + u_t(μ - r)] W_t dt  +  u_t σ W_t dW_t
```

**Objective — maximize expected CRRA utility of terminal wealth:**
```
J = E[ W_T^(1-γ) / (1-γ) ]
```

**HJB PDE:**
```
V_t + max_u { [r + u(μ-r)] w V_w  +  ½ u² σ² w² V_ww } = 0
```

Solving via first-order condition + power function ansatz gives `u*` above.

---

## Strategies Compared

| Strategy | u value | Stock Allocation |
|----------|---------|-----------------|
| ★ Optimal (HJB/Merton) | `u* = 0.417` | 41.7% |
| 50/50 Balanced | `u = 0.50` | 50.0% |
| All-Stock (Aggressive) | `u = 1.00` | 100.0% |

---

## Simulation Results

Parameters: `r = 0.03`, `μ = 0.08`, `σ = 0.20`, `γ = 3`, `T = 1 year`, `M = 2000 paths`

| Strategy | Mean Wealth ($) | Avg CRRA Utility |
|----------|----------------|-----------------|
| ★ Optimal (HJB) | 1,053 | **−4.6 × 10⁻⁷ (Best)** |
| 50/50 Balanced | 1,058 | −4.6 × 10⁻⁷ |
| All-Stock | 1,086 | −4.8 × 10⁻⁷ |

> The optimal strategy does **not** have the highest mean wealth — the All-Stock strategy does.  
> But it achieves the **highest expected utility**, which is the correct objective under risk aversion.  
> The Merton controller trades some expected return for a tighter, lower-risk wealth distribution.

---

## How to Run

**Requirements:** MATLAB (any recent version, no toolboxes needed)

```matlab
% Clone the repo, open MATLAB, and run:
Project.m
```

The script will:
1. Compute `u*` analytically from the Merton formula
2. Simulate 2000 wealth paths for all three strategies (Euler-Maruyama)
3. Print a results table to the console
4. Generate two figures: wealth trajectories and terminal wealth distributions

---

## Files

```
├── Project.m                        # MATLAB simulation (main file)
├── Optimal_Control_Project_Report.pdf  # Full project report with derivations
├── README.md
└── results/                         # (optional) save MATLAB figures here as PNG
```

---

## Key Concepts Demonstrated

- **Stochastic Differential Equations** — GBM model for stock prices
- **HJB Equation** — PDE formulation of stochastic optimal control
- **Dynamic Programming / Principle of Optimality**
- **CRRA Utility** — risk-averse objective function
- **Euler-Maruyama** — SDE discretization for Monte Carlo simulation
- **Monte Carlo Methods** — validating analytical results numerically

---

## Report

The full derivation — from SDEs through HJB to the Merton Proportion — is in [`Optimal_Control_Project_Report.pdf`](./Optimal_Control_Project_Report.pdf).

---

## Reference

> Merton, R. C. (1969). *Lifetime Portfolio Selection under Uncertainty: The Continuous-Time Case.* Review of Economics and Statistics, 51(3), 247–257.

---

*Muhammed Aslam A · Roll No. 2025EEA2819 · IIT Delhi · Dept. of Electrical Engineering*
