# merton-portfolio-optimization
Optimal continuous-time portfolio rebalancing using the HJB equation and Merton Proportion — MATLAB Monte Carlo simulation 

**Course Project — Optimal Control Theory | IIT Delhi (M.Tech EE, 2025)**

This project applies the **Hamilton-Jacobi-Bellman (HJB) equation** to derive the analytically optimal continuous-time investment strategy for a two-asset portfolio, and validates it via Monte Carlo simulation in MATLAB.
The HJB equation applied to a stochastic wealth SDE yields a closed-form optimal control law — the **Merton Proportion**:

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

## Key Concepts Demonstrated

- **Stochastic Differential Equations** — GBM model for stock prices
- **HJB Equation** — PDE formulation of stochastic optimal control
- **Dynamic Programming / Principle of Optimality**
- **CRRA Utility** — risk-averse objective function
- **Euler-Maruyama** — SDE discretization for Monte Carlo simulation
- **Monte Carlo Methods** — validating analytical results numerically

---

## Report

The full derivation — from SDEs through HJB to the Merton Proportion — is in [`optimal_portfolio_report`](./optimal_portfolio_report).

---

## Reference

> Merton, R. C. (1969). *Lifetime Portfolio Selection under Uncertainty: The Continuous-Time Case.* Review of Economics and Statistics, 51(3), 247–257.

---

*Muhammed Aslam A · Roll No. 2025EEA2819 · IIT Delhi · Dept. of Electrical Engineering*
