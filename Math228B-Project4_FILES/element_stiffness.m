function element_matrix = element_stiffness(nodes,reference_gradients)
ELMTDOFS = 3;
element_matrix = zeros(ELMTDOFS,ELMTDOFS);
jac = nodes' * reference_gradients;
dx = det(jac);
spatial_gradients = reference_gradients/jac;

for I = 1:ELMTDOFS
   DNI = spatial_gradients(I,:);
   for J = 1:ELMTDOFS
       DNJ = spatial_gradients(J,:);
       element_matrix(I,J) = element_matrix(I,J) + dot(DNI,DNJ)*dx;
   end 
end

end