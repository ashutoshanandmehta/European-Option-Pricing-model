# European Option Pricing Model Project
## 1. Overview

This project presents a modular implementation of European option pricing models using three standard approaches. 

The implementation is compatible with **MATLAB R2025a**.

## 2. Financial Model Assumptions

All models are based on the standard **Black–Scholes market assumptions**:

- The underlying asset price follows a **Geometric Brownian Motion (GBM)**.
- The asset dynamics under the risk-neutral measure are given by:

  \$\$dS\_t = r S\_t dt + \sigma S\_t dW\_t\$\$
- Constant risk-free interest rate (\$r\$) and constant volatility (\$\sigma\$).
- No arbitrage opportunities and frictionless markets (no transaction costs, infinite liquidity).
- European-style options (exercise only at maturity).

## 3. Core Pricing Models

### 3.1 Black-Scholes Analytical Model (`blackScholes.m`)

The benchmark analytical model uses the standard closed-form solution. It serves as the "ground truth" for evaluating the accuracy of numerical methods.

- **Formula (Call):** \$C = S\_0 \Phi(d\_1) - K e^{-rT} \Phi(d\_2)\$
- **Where:**

  \$\$d\_1 = \frac{\ln(S\_0/K) + (r + \frac{1}{2}\sigma^2)T}{\sigma \sqrt{T}}, \quad d\_2 = d\_1 - \sigma \sqrt{T}\$\$

### 3.2 Binomial Tree Model (`binomialEuropean.m`)

A discrete-time numerical method approximating the GBM process using a lattice.

-  Up factor: \$u = e^{\sigma\sqrt{\Delta t}}\$
- Down factor: \$d = 1/u\$
- Risk-neutral probability: \$p = \frac{e^{r\Delta t} - d}{u - d}\$

* **Convergence:** The model exhibits deterministic convergence to Black-Scholes at a rate of approximately \$O(1/N)\$.

### 3.3 Monte Carlo Simulation (`monteCarloEuropean.m`)

A stochastic approach estimating price as the discounted expected payoff across many simulated terminal prices.

- **Terminal Price:** \$S\_T = S\_0 \exp\left((r - \frac{1}{2}\sigma^2)T + \sigma\sqrt{T}Z\right), \quad Z \sim N(0,1)\$
- **Optimization:** Uses **Antithetic Variates** (\$Z\$ and \$-Z\$) to significantly reduce estimator variance.
- **Convergence:** The error follows \$O(1/\sqrt{M})\$, where \$M\$ is the number of simulations.
- Output provides the mean price and a 95% Confidence Interval: \$\hat{C} \pm 1.96 \frac{s}{\sqrt{M}}\$.

## 4. Analysis & Risk Management

### 4.1 The Greeks (`greeksBS.m`)

Calculates sensitivities to manage risk and design hedging strategies:

- **Delta (**\$\Delta\$**):** Sensitivity to underlying price (\$S\$).
- **Gamma (**\$\Gamma\$**):** Curvature/sensitivity of Delta to price changes.
- **Vega (**\$\nu\$**):** Sensitivity to volatility (reported per 1% change).
- **Theta (**\$\Theta\$**):** Time decay (reported per day).
- **Rho (**\$\rho\$**):** Sensitivity to interest rates (reported per 1% change).

### 4.2 Convergence & Scenario Analysis

- **Convergence Analysis:** Compares absolute errors of the Binomial and Monte Carlo methods against the Black-Scholes benchmark.
- **Scenario Analysis:** Evaluates model consistency across three moneyness regimes: **Out-of-the-Money (OTM)**, **At-the-Money (ATM)**, and **In-the-Money (ITM)**.

## 5. Usage Instructions

To execute the full project pipeline, run the `main_pricing.m` script. This script:

1. Defines initial parameters (\$S\_0, K, T, r, \sigma\$).
2. Computes and prints prices from all three models.
3. Triggers all visualization and analysis routines, including sensitivity plots and convergence tests.

**Example Console Output:**

```
BS: 10.4506 | Binomial: 10.4500 | MC: 10.4521 ± 0.0124 (95% CI)

```

## 6. Project Structure & Scope

### 6.1 Software Architecture

The codebase is organized into a modular structure to improve readability and extensibility:

```
OptionPricing/
├── main_pricing.m             # Main execution entry point
├── models/
│   ├── blackScholes.m         # Analytical solver
│   ├── binomialEuropean.m     # Discrete-time tree solver
│   └── monteCarloEuropean.m   # Stochastic simulation solver
├── analysis/
│   ├── convergenceAnalysis.m  # Accuracy vs. Benchmark
│   ├── scenarioAnalysis.m     # Moneyness comparison
│   ├── sensitivityAnalysis.m  # Parameter sweeps
│   └── greeksBS.m             # Risk sensitivity calculation
└── visualisation/
    └── monteCarloPaths.m      # GBM path generation

```

### 6.2 Limitations

- Supports only **European-style** options (no early exercise).
- Assumes constant market parameters (volatility and rates).
- Does not account for dividends or transaction costs.
