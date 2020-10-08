function ydot = g_fun(t,state_vec, A, B, K)
%ode function to find the lateral states, with controls and gains 
    %closed loop
    ydot = (A-(B*K))*state_vec;
end