clear; clc;

S0 = 100; K = 100; T = 1; r = 0.05; sigma = 0.2;
type = 'call';

BS = blackScholes(S0,K,T,r,sigma,type);
BIN = binomialEuropean(S0,K,T,r,sigma,200,type);
[MC_price, MC_ci] = monteCarloEuropean(S0, K, T, r, sigma, 100000, type);

fprintf('BS: %.4f | Binomial: %.4f | MC: %.4f ± %.4f (95%% CI)\n', BS, BIN,  MC_price, MC_ci);

monteCarloPaths(S0,T,r,sigma,50,200);
scenarioAnalysis([90 100 110],K,T,r,sigma,type);
sensitivityAnalysis(S0,K,T,r,sigma,type);
convergenceAnalysis(S0, K, T, r, sigma, type);
