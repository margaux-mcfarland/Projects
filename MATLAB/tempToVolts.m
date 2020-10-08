function T = tempToVolt(V)
%takes in volatge and returns the temperature
T=[2.508355e-2*V 7.860106e-8*V^2 -2.503131e-10*V^3 8.315270e-14*V^4 -1.228034e-17*V^5 9.804036e-22*V^6 -4.413030e-26*V^7 1.0577034e-30*V^8 -1.052755e-35*V^9];

return V;

end

