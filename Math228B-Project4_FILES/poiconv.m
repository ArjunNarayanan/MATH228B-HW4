function errors = poiconv(pv,hmax,nrefmax)
    [p,t,e] = pmesh(pv,hmax,nrefmax);
    fine_sol = fempoi(p,t,e);
    
    errors = zeros(nrefmax,1);
    
    for i = 0:nrefmax-1
       [p,t,e] = pmesh(pv,hmax,i);
       sol = fempoi(p,t,e);
       ndofs = length(sol);
       errors(i+1) = max(abs(sol - fine_sol(1:ndofs)));
    end
end