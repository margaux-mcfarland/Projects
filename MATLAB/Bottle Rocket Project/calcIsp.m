
function I_sp = calcIsp(force, t_span, g, m_prop)
%this function calculates the specific impulse of the water bottle rocket

%[t, I] = ode45( @(t,I) force,t_span, initial_conditions);

I = 0;
%time step is same as sampling frequency
t_step = 1/1652;
for i = 1:length(force)-1
    I = I + ((force(i+1) + force(i))/2)*t_step;
end
   
I_sp = I/(m_prop*g);



end