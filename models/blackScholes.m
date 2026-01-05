function price = blackScholes(S, K, T, r, sigma, type)
    d1 = (log(S./K) + (r + 0.5*sigma.^2).*T) ./ (sigma.*sqrt(T));
    d2 = d1 - sigma.*sqrt(T);

    if strcmp(type,'call')
        price = S.*normcdf(d1) - K.*exp(-r*T).*normcdf(d2);
    else
        price = K.*exp(-r*T).*normcdf(-d2) - S.*normcdf(-d1);
    end
end
