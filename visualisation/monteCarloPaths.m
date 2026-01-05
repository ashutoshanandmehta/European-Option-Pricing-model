function monteCarloPaths(S0, T, r, sigma, numPaths, numSteps)

    dt = T/numSteps;
    t = linspace(0, T, numSteps+1);

    paths = zeros(numPaths, numSteps+1);
    paths(:,1) = S0;

    for j = 2:numSteps+1
        Z = randn(numPaths,1);
        paths(:,j) = paths(:,j-1) .* ...
            exp((r - 0.5*sigma^2)*dt + sigma*sqrt(dt).*Z);
    end

    figure;
    plot(t, paths','LineWidth',0.8);
    xlabel('Time');
    ylabel('Stock Price');
    title('Monte Carlo Simulation: True GBM Paths');
    grid on;
end
