% CONVERGENCEANALYSIS
% Compares convergence of Binomial and Monte Carlo prices
% against Black-Scholes benchmark for European options.
function convergenceAnalysis(S0, K, T, r, sigma, type)
    % Benchmark
    BS_price = blackScholes(S0, K, T, r, sigma, type);

    %% BINOMIAL CONVERGENCE
    binSteps = [5 10 20 30 50 75 100 150 200 300 500];
    binPrices = zeros(size(binSteps));
    binErrors = zeros(size(binSteps));

    for i = 1:length(binSteps)
        binPrices(i) = binomialEuropean( ...
            S0, K, T, r, sigma, binSteps(i), type);
        binErrors(i) = abs(binPrices(i) - BS_price);
    end

    %% MONTE CARLO CONVERGENCE
    mcSims = [100 500 1000 2500 5000 10000 25000 50000 100000];
    mcPrices = zeros(size(mcSims));
    mcErrors = zeros(size(mcSims));

    for i = 1:length(mcSims)
        mcPrices(i) = monteCarloEuropean( ...
            S0, K, T, r, sigma, mcSims(i), type);
        mcErrors(i) = abs(mcPrices(i) - BS_price);
    end

    %% PLOTS

    % --- Price convergence ---
    figure('Name','Convergence to Black-Scholes','Position',[100 100 1200 450]);

    subplot(1,2,1); hold on;
    plot(binSteps, binPrices, 'b-o', 'LineWidth', 2);
    plot(mcSims, mcPrices, 'g-s', 'LineWidth', 2);
    yline(BS_price, 'r--', 'LineWidth', 2);
    xlabel('Steps / Simulations');
    ylabel('Option Price');
    title('Price Convergence');
    legend('Binomial','Monte Carlo','Black-Scholes','Location','best');
    grid on;

    % --- Error convergence (log scale) ---
    subplot(1,2,2); hold on;
    semilogy(binSteps, binErrors, 'b-o', 'LineWidth', 2);
    semilogy(mcSims, mcErrors, 'g-s', 'LineWidth', 2);
    xlabel('Steps / Simulations');
    ylabel('Absolute Error (log scale)');
    title('Error vs Black-Scholes');
    legend('Binomial Error','Monte Carlo Error','Location','best');
    grid on;

    %% Console summary
    fprintf('\n=== Convergence Summary ===\n');
    fprintf('Black-Scholes Price : %.6f\n', BS_price);
    fprintf('Binomial (%d steps) : %.6f | Error: %.6e\n', ...
            binSteps(end), binPrices(end), binErrors(end));
    fprintf('Monte Carlo (%d sims): %.6f | Error: %.6e\n', ...
            mcSims(end), mcPrices(end), mcErrors(end));
end
