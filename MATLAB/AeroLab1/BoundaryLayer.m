function delta = BoundaryLayer(Data, airv)
Vcenter = airv(Data.yDist > 100);
Vedge = airv(Data.yDist < 100);
Vcenter = sum(Vcenter)/length(Vcenter);
delta = Data.yDist(abs(Vedge - 0.95*Vcenter) < 0.1);
if isempty(delta)
    airv = calcAirSpeed(Data.AtmP,Data.AtmT,Data.PDiff1,2);
    Vcenter = airv(Data.yDist > 100);
    Vedge = airv(Data.yDist < 100);
    Vcenter = sum(Vcenter)/length(Vcenter);
    delta = Data.yDist(abs(Vedge - 0.95*Vcenter) < 0.01);
    delta = sum(delta)/length(delta);
end
delta = sum(delta)/length(delta);
end