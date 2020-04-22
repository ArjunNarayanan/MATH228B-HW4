function vals = hermite_basis(x)
    vals = [basis1(x);
            basis2(x);
            basis3(x);
            basis4(x)];
end

function val = basis1(x)
    val = 0.25*(2 - 3*x + x^3);
end

function val = basis2(x)
    val = 0.25*(1 - x - x^2 + x^3);
end

function val = basis3(x)
    val = 0.25*(2 + 3*x - x^3);
end

function val = basis4(x)
    val = 0.25*(-1 -x + x^2 + x^3);
end

