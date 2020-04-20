function sol = fempoi(points,connectivity,dirichlet_node_ids)
    op = poisson_operator(points,connectivity);
    rhs = poisson_rhs(points,connectivity);
    [op,rhs] = apply_dirichlet_bc(op,rhs,dirichlet_node_ids);
    sol = op\rhs;
end