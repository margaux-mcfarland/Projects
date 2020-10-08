%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CODE CHALLENGE 1 - Implement the Bisection Method of Finding a Root
%
% The purpose of this program is to find the value of x for a single 
% nonlinear function where f(x)=0.
%
% To complete the challenge, finish the code below to 1) load a function
% from a file, 2) open a new file for writing results, 3) implement
% the bisection method to find the root of the function, and 4) write the
% results to a file. As this is the first challenge, many helpful comments
% have been provided.
%
% Please ZIP and upload the 'func.txt', your team's script(s), and the
% results file to Canvas to complete the challenge.
% 
% STUDENT TEAMMATES
% 1. Margaux McFarland
% 2. Braden Campbell
% 3. Katie Nyland
% 4.
%
% CHALLENGE AUTHORS
% Jelliffe Jackson, Allison Anderson, John Jackson 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Housekeeping: Clear the variables and close all open plots
      % Clears all the variables
      % Closes all the plots
      % Clears the command line
%
%% Initialization: Define the Functions, Load Data, and Set Known Values
% 
% 1. The function f(x) is specified in the file func.txt. Open the file 
% using fopen() to read the function handle.
filename = 'func.txt';  
                          % Open the file
f1 = fopen(filename);
                          
% These two lines create a function handle from the contents of the file.
% Setting up the function this way is atypical, but it could be useful 
% to test many arbitrary functions in a single file.
string_exp = fgetl(f1);     % Read the single line
f_x = eval(string_exp);     % Evaluate the single line to get a handle

% 2. Open an output file to save results - use 'w' argument for write
% permissions
filename2 = 'output.txt';

f2 = fopen(filename(w));


% 3. Set the input variables
% Interval a,b; convergence tolerance; maximum number of iterations
a = -10;
b = 10;
convTol = 0.1;
maxIterations = 50;
iterations = 0;
p = 100; % ot of range for now...

%% Run The Algorithm: Iterate, Solve, Etc.
% Begin iterative procedure.

% 4. While the stop conditions are not satisfied,
while(abs(f_x(p)) >= convTol && iterations <= maxIterations)
    % 5. Calculate the mid-point, p
    p = (a+b)/2;
     % 6. If f(p) has the same sign as f(b) set b = p, otherwise, set 
     if((f_x(p) > 0 && f_x(b) > 0) || (f_x(p) < 0 && f_x(b) < 0))
        b = p;
     else
        a = p;
     end
 
 iterations = iterations + 1;
   
end
    
fprintf(
    % 7. If the absolute value of ? is less than the convergence, write the 
    % result and exit the program 
    % Hint: fprintf(file_handle, 'My message %f\n', value)

% 8. If a solution is not found within the maximum number of iterations, 
% state this with the iteration reached in the results file
