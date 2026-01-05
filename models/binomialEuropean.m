function price = binomialEuropean(S, K, T, r, sigma, N, type)

    dt = T/N;
    u = exp(sigma*sqrt(dt));
    d = 1/u;
    p = (exp(r*dt) - d) / (u - d);

    ST = S * u.^(N:-1:0) .* d.^(0:N);

    if strcmp(type,'call')
        C = max(ST - K, 0);
    else
        C = max(K - ST, 0);
    end

    for t = N:-1:1
        C = exp(-r*dt) * (p*C(1:end-1) + (1-p)*C(2:end));
    end

    price = C(1);
end
