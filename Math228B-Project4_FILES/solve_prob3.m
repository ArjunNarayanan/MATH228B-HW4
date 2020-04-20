dx = 0.5;
[qp,qw] = three_point_quadrature()
emat = element_matrix(dx,qp,qw);

op = zeros(6,6);
op(1:4,1:4) = op(1:4,1:4) + emat;
op(3:6,3:6) = op(3:6,3:6) + emat;
% Apply boundary conditions:
op(1,:) = 0;
op(:,1) = 0;
op(1,1) = 1;
op(2,:) = 0;
op(:,2) = 0;
op(2,2) = 1;

op(5,:) = 0;
op(:,5) = 0;
op(5,5) = 1;
op(6,:) = 0;
op(:,6) = 0;
op(6,6) = 1;


rhs = zeros(6,1);
rhs(1:4) = rhs(1:4) + element_rhs(0,1/2,qp,qw);
rhs(3:6) = rhs(3:6) + element_rhs(1/2,1,qp,qw);
% Enforce BCs
rhs(1) = 0;
rhs(2) = 0;
rhs(5) = 0;
rhs(6) = 0;

sol = op\rhs;

[xrange,nsol] = interpolate(sol);
esol = arrayfun(@exact_solution,xrange);

figure;
hold on;
ax1 = plot(xrange,nsol,'LineWidth',2);
ax2 = plot(xrange,esol,'--');
xlabel('X');
ylabel('u');
legend([ax1,ax2], ["Numerical","Exact"]);

function val = exact_solution(x)
    val = 4*x^5 - 5*x^4 - 2*x^3 + 3*x^2;
end

function [interpolated_points,interpolated_vals] = interpolate(sol)
    reference_points = -1:1e-1:1;
    npts = length(reference_points);
    
    interpolated_vals = zeros(2*npts,1);
    interpolation_points = zeros(2*npts,1);
    
    coeffs = sol(1:4)';
    for i = 1:npts
       xi = reference_points(i);
       vals = hermite_basis(xi);
       interpolated_vals(i) = coeffs*vals;
       interpolated_points(i) = affine_map(xi,0,0.5);
    end
    coeffs = sol(3:6)';
    for idx = 1:npts
        i = idx + npts;
        xi = reference_points(idx);
        vals = hermite_basis(xi);
        interpolated_vals(i) = coeffs*vals;
        interpolated_points(i) = affine_map(xi,0.5,1);
    end
end

function rhs_vector = element_rhs(xL,xR,qp,qw)
    rhs_vector = zeros(4,1);
    nqp = length(qp);
    dx = xR - xL;
    for q = 1:nqp
       p = qp(q);
       w = qw(q);
       vals = hermite_basis(p);
       x = affine_map(p,xL,xR);
       for I = 1:4
          rhs_vector(I) = rhs_vector(I) + vals(I)*load(x)*dx/2*w;
       end
    end
end

function x = affine_map(xi,xL,xR)
    x = xL + 0.5*(xR - xL)*(xi + 1);
end

function val = load(x)
    val = 480*x - 120;
end

function matrix = element_matrix(dx,qp,qw)
    matrix = zeros(4,4);
    nqp = length(qp);
    for q = 1:nqp
       p = qp(q);
       w = qw(q);
       derivative_vals = hermite_second_derivative(p);
       for I = 1:4
           for J = 1:4
                matrix(I,J) = matrix(I,J) + derivative_vals(I)*derivative_vals(J)*(2/dx)^3*w;
           end 
       end
    end
end


function [qp,qw] = three_point_quadrature()
    qp = [-sqrt(3/5); 0; sqrt(3/5)];
    qw = [5/9;8/9;5/9];
end