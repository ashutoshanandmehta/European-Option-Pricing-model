function sensitivityAnalysis(S, K, T, r, sigma, type)

    vols = linspace(0.1,0.5,50);
    times = linspace(0.1,2,50);

    pv = arrayfun(@(v) blackScholes(S,K,T,r,v,type), vols);
    pt = arrayfun(@(t) blackScholes(S,K,t,r,sigma,type), times);

    figure;
    subplot(1,2,1); plot(vols*100,pv,'LineWidth',2);
    xlabel('Volatility (%)'); ylabel('Price'); grid on;

    subplot(1,2,2); plot(times,pt,'LineWidth',2);
    xlabel('Maturity (Years)'); ylabel('Price'); grid on;
end
