function rhs = poisson_rhs(points,connectivity)
    [nelements,elmt_ndofs] = size(connectivity);
    [num_points,dims] = size(points);
    
    [qp,qw] = reference_quadrature();
    
    grads = basis_gradients();
    vals = basis_values(qp(1),qp(2));
    rhs = zeros(num_points,1);
    
    for elid = 1:nelements
       node_ids = connectivity(elid,:);
       nodes = points(node_ids,:);
       element_vec = element_rhs(nodes,grads,vals);
       rhs(node_ids) = rhs(node_ids) + element_vec;
    end
end

function element_vec = element_rhs(nodes,reference_gradients,reference_values)
    elmt_dofs = 3;
    element_vec = zeros(elmt_dofs,1);
    jac = nodes' * reference_gradients;
    dx = det(jac);

    for I = 1:elmt_dofs
       element_vec(I) = element_vec(I) + reference_values(I)*dx;
    end
end