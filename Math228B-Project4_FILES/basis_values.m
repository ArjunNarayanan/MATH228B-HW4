function values = basis_values(xi,eta)
values = [basis1(xi,eta);basis2(xi,eta);basis3(xi,eta)];
end

function val = basis1(xi,eta)
    val = 1.0 - xi - eta;
end

function val = basis2(xi,eta) 
    val = xi;
end

function val = basis3(xi,eta)
    val = eta;
end