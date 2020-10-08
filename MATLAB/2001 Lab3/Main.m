%% Constants
t = 13/16; % Thickness
Ef = 0.035483 *10^9; % Modulus of Elasticity of Foam
Eb = 3.2953 *10^9; % Modulus of Elasticity of Balsa
FOS = 1.5; % Factor of Safety

L = 36  ; % Length of 36in
x = linspace(-18,18,22)  ; % Position vector
% p0 = ; % 


%% Test Data
[~,~,cellData] = xlsread('TestData.xlsx');
F = cell2mat(cellData(3:24,2)); % Force at failure
a = cell2mat(cellData(3:24,3)); % Distance from support reaction
w = cell2mat(cellData(3:24,4)); % Width of beam from top
d_f = cell2mat(cellData(3:24,5)); % Distance from fialure location

% F(4,:) = 0;
% F(16,:) = 0;
% a(4,:) = 0;
% a(16,:) = 0;
% w(4,:) = 0;
% w(16,:) = 0;
% d_f(4,:) = 0;
% d_f(16,:) = 0;
%% Calculations
type1 = zeros(length(a),1);
for i = 1:length(a) % If d_f is greater than a, failure is shear
    if a(i) > d_f(i)
        type1(i) = 1; % 1 indicates shear failure, 0 indicates bending failure
    end
end
type0 = abs(type1 - 1);  % 1 indicates bending failure, 0 indicates shear failure

Acs = t .* w; % Cross sectional area of beam
Af = 3/4 * 1  .* w; % Cross sectional area of foam

Mfail = F .* abs(d_f - a); % Moment at failure
c = t / 2; % Half of the thickness
Ibb = 2*((1/32)^3 .* w / 12) + ((3/8 + 1/64 )  )^2 .* w /16; % Moment of inertia of balsa
Iff = 0.75^3 * w / 12; % Moment of inertia of foam

B = 0.009541829427084;
F = 0.035156250000000;

sigFmat = (Mfail .* c) ./ ( Ibb + (Ef/Eb)*Iff ); % Bending failure stress

V = F / 2; % Shear force

tauFmat = 1.5 * V ./ Af; % Shear failure stress

sigF = sum(type0 .* sigFmat) / sum(type0); % Average bending failure stress
tauF = sum(type1 .* tauFmat) / sum(type1); % Average shear failure stress

Ib = vertcat(Ibb(1:12,1),Ibb(14:end,1));
If = vertcat(Iff(1:12,1),Iff(14:end,1));
%% 11/12/18
w = 4  ; % Width of 4in
sigAllow = sigF / FOS; % Maximum allowable 
tauAllow = tauF / FOS;

width = - c / ((B + F * (Ef/Eb)) * sigAllow);



syms p0 x
q = p0 * w * sqrt(1 - (2*x/L).^2);
int1 = matlabFunction(int(q,x)); % Shear function
int2 = matlabFunction(int(int1,x)); % Moment function
% int3 = @(p0,x)(1.5/(tauF*0.8125)*p0.*(asin(x./1.8e1).*3.24e2+x.*sqrt(-x.^2+3.24e2)))./9.0;
% int4 = @(p0,x) width * p0.*((x.*asin(x./1.8e1))./1.8e1+sqrt(x.^2.*(-1.0./3.24e2)+1.0)).*6.48e2-(p0.*(-x.^2+3.24e2).^(3.0./2.0))./2.7e1;
x = linspace(-18,18,22)  ;
p0 = sigAllow * inetias / (p0 * c);



int3 = @(p0,x)(1.5/(tauF*0.8125)*p0.*(asin(x./1.8e1).*3.24e2+x.*sqrt(-x.^2+3.24e2)))./9.0;
int4 = @(p0,x) width * p0.*((x.*asin(x./1.8e1))./1.8e1+sqrt(x.^2.*(-1.0./3.24e2)+1.0)).*6.48e2-(p0.*(-x.^2+3.24e2).^(3.0./2.0))./2.7e1;

hold on
plot(x,int1(p0,x)) % Shear diagram
plot(x,int2(p0,x)) % Moment diagram
legend('Shear','Moment'); xlabel('Position [in]'); ylabel('lb & lb*in')
hold on
plot(x,int3(p0,x)) % Width Shear
plot(x,int4(p0,x)) % With moment


% wid = 

% ww = sigAllow ./ (p0 * sqrt(1 - (2*x/L).^2));
% 
% figure(1)
% hold on
% plot(x,ww)
% plot(x,-ww)