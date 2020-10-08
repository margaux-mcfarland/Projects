function ydot = g_fun2(t,state_vec, A)
%ode function to find the lateral states, with controls and gains 
%open loop
    ydot = A*state_vec;
end