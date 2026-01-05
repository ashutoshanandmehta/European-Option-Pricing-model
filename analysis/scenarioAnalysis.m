function scenarioAnalysis(Svec, K, T, r, sigma, type)

    results = zeros(length(Svec),3);

    for i = 1:length(Svec)
        results(i,1) = blackScholes(Svec(i),K,T,r,sigma,type);
        results(i,2) = binomialEuropean(Svec(i),K,T,r,sigma,100,type);
        results(i,3) = monteCarloEuropean(Svec(i),K,T,r,sigma,50000,type);
    end

    figure;
    bar(results);
    legend('Black-Scholes','Binomial','Monte Carlo');
    set(gca,'XTickLabel',{'OTM','ATM','ITM'});
    ylabel('Option Price');
    grid on;
end
