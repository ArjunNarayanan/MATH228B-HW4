function val = hermite_derivative(x)
    val = [derivative1(x);
           derivative2(x);
           derivative3(x);
           derivative4(x)];
end

function val = derivative1(x)
    val = 0.25*(-3 + 3*x^2);
end

function val = derivative2(x)
    val = 0.25*(-1 -2*x + 3*x^2);
end

function val = derivative3(x)
    val = 0.25*(3 - 3*x^2);
end

function val = derivative4(x)
    val = 0.25*(-1 + 2*x + 3*x^2);
end