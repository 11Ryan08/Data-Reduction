function P = mypoisson(r, T, n)
    P = (r * T)^n * exp(-r * T) / factorial(n);
end