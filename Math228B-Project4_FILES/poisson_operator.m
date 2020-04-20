function op = poisson_operator(points,connectivity)
    [nelements,elmt_ndofs] = size(connectivity);
    [num_points,dims] = size(points);
 
    grads = basis_gradients();
    
    op_rows = [];
    op_cols = [];
    op_vals = [];
    
    for elid = 1:nelements
       node_ids = connectivity(elid,:);
       nodes = points(node_ids,:);
       element_matrix = element_stiffness(nodes,grads);
       [rows,cols,vals] = element_matrix_to_operator_entries(element_matrix,node_ids);
       
       op_rows = [op_rows;rows];
       op_cols = [op_cols;cols];
       op_vals = [op_vals;vals];
    end
    op = sparse(op_rows,op_cols,op_vals,num_points,num_points);
end

