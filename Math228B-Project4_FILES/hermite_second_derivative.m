function val = hermite_second_derivative(x)
    val = [second_derivative1(x);
           second_derivative2(x);
           second_derivative3(x);
           second_derivative4(x)];
end

function val = second_derivative1(x)
    val = 1.5*x;
end

function val = second_derivative2(x)
    val = 0.25*(-2 + 6*x);
end

function val = second_derivative3(x)
    val = -1.5*x;
end

function val = second_derivative4(x)
    val = 0.25*(2 + 6*x);
end