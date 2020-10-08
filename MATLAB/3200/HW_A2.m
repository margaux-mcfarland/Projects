%Hw A-2: Problem 3
%moment of inertia matrix wrt the center of mass
I_G = [783.5 351.7 40.27;
    351.7 783.5 -80.27;
    40.27 -80.27 783.5];

%eigenvectors and eigenvalues
[V,D] = eig(I_G)

%DCM
Q = V'

%moment of inertia matrix in PA frame
I_pa = Q*I_G*Q'