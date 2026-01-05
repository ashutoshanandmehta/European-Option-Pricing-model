function g = greeksBS(S, K, T, r, sigma, type)

    d1 = (log(S/K) + (r + 0.5*sigma^2)*T)/(sigma*sqrt(T));
    d2 = d1 - sigma*sqrt(T);

    g.delta = strcmp(type,'call')*normcdf(d1) + ...
             strcmp(type,'put')*(normcdf(d1)-1);

    g.gamma = normpdf(d1)/(S*sigma*sqrt(T));
    g.vega  = S*normpdf(d1)*sqrt(T)/100;

    if strcmp(type,'call')
        g.theta = (-(S*normpdf(d1)*sigma)/(2*sqrt(T)) ...
                  - r*K*exp(-r*T)*normcdf(d2))/365;
        g.rho   = K*T*exp(-r*T)*normcdf(d2)/100;
    else
        g.theta = (-(S*normpdf(d1)*sigma)/(2*sqrt(T)) ...
                  + r*K*exp(-r*T)*normcdf(-d2))/365;
        g.rho   = -K*T*exp(-r*T)*normcdf(-d2)/100;
    end
end
