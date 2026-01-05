function [price, ci95] = monteCarloEuropean(S, K, T, r, sigma, M, type)

    % Ensure M is even
    if mod(M,2) ~= 0
        M = M + 1;
    end

    % Generate antithetic normals
    Z = randn(M/2,1);
    Z = [Z; -Z];

    % Terminal stock prices
    ST = S * exp((r - 0.5*sigma^2)*T + sigma*sqrt(T).*Z);

    % Payoff
    if strcmp(type,'call')
        payoff = max(ST - K, 0);
    else
        payoff = max(K - ST, 0);
    end

    % Discounted payoff
    discPayoff = exp(-r*T) * payoff;

    % Price estimate
    price = mean(discPayoff);

    % 95% confidence interval
    stderr = std(discPayoff) / sqrt(M);
    ci95 = 1.96 * stderr;
end
