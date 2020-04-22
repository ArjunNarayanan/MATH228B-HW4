function [op,rhs] = apply_dirichlet_bc(op,rhs,dirichlet_node_ids)
for i = 1:length(dirichlet_node_ids);
   node_id = dirichlet_node_ids(i);
   op(node_id,:) = 0;
   op(:,node_id) = 0;
   op(node_id,node_id) = 1;
   rhs(node_id) = 0;
end
end