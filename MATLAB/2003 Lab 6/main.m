
%% user defined variables
%proportional gain applied to the hub angle measured
K1 = 20;
%proportional gain applied to the top sensor measurement
K2 = -30;
%Derivative gain applied to the hub angle rate
K3 = 1.5;
%derivative gain applied to the tip sensor rate
K4 = 1;

rigidArmSimulation(K1,K3);
flexArmSimulation(K1,K2,K3,K4);