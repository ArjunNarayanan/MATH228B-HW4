function [rows,cols,vals] = element_matrix_to_operator_entries(matrix,node_ids)
    rows = repmat(node_ids(:),3,1);
    cols = repmat(node_ids,3,1);
    cols = cols(:);
    vals = matrix(:);
end