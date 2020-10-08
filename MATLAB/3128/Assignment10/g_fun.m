function ydot = g_fun(t,state_vec, A)
%ode function to find the lateral states
    ydot = A*state_vec;
end