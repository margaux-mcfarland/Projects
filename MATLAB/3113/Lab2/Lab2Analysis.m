% Authors: Trace Valade, Bruce Barnstable
% Purpose: Calculate Steady State and Transient Temperature distributions
%   for an arbitrary rod, compare to experimental data.
% Written for CU-Boulder ASEN 3113 Experiement Lab 2
% Date: 11/3/2019
%% HOUSEKEEPING
close all
clear
clc

%% Master Loop
fileset = files_in_folder('Data');
L = 0.127;

full_data = containers.Map;
for i = 1:length(fileset)
    set_data = file_extractor(fileset{i});
    full_data(fileset{i}) = set_data;
end

full_data = lin_reg(full_data);

keys = full_data.keys();
for i = 1:length(keys)
   plot_exp_analytical(full_data(keys{i}), keys{i})
   plot_exp_init(full_data(keys{i}), keys{i})
   single_data = full_data(keys{i});
   alpha=alpha_reg(single_data, keys{i})
   tss = -log(0.01)*4*L^2 / (pi^2*alpha);
   tau = alpha*tss / L^2;
   single_data('alpha_est')= alpha;
   single_data('tss') = tss;
   single_data('tau') = tau;
   full_data(keys{i}) = single_data;
   
   plot_full_temps(full_data(keys{i}), keys{i})
end
    
%% Function Declarations
% plotting function for full temps on every thermocouple.
function plot_full_temps(single_data, filename)
    temps = single_data('temps');
    temps_lower = single_data('temps_lower');
    temps_upper  = single_data('temps_upper');
    times = single_data('time');
    len = length(times);
    L = 0.127;    
    n = 1:100;
    alpha = single_data('alpha_est');
    
    % Fourier Series Calculation
    function bn = bncalc
        bn = (2*H*L*(-1).^n) ./ (pi^2.*(n-1/2).^2);
    end

    function lambda = lambdacalc
       lambda = (n-1/2) .* (pi/L); 
    end

    function est_temps = tempfun
        est_temps = T_0 +H*x + sum((ones(len, 1)*bncalc) .* exp(times*(-abs(alpha).*lambdacalc.^2)) .* (ones(len, 1)*sin(lambdacalc.*x)), 2);
    end

    % plotting with version check for sgtitle
    xl = [11/8; 15/8; 19/8; 23/8; 27/8; 31/8; 35/8; 39/8] .* 0.0254;
    
    v = version;
    v = str2num(v(3));
    
    figure
    if v >= 5
        sgtitle(filename(1:end-4), 'Interpreter', 'none')
    end
    
    for i = 1:length(xl)
       x = xl(i);
       H = single_data('H_exp');
       T_0 = single_data('T_0');
       est_temps = tempfun;
       
       H = single_data('H_lower');
       T_0 = single_data('T_0_lower');
       est_temps_lower = tempfun;
       
       H = single_data('H_upper');      
       T_0 = single_data('T_0_upper');
       est_temps_upper = tempfun;
       
       subplot(2, 4, i)
       title(['Thermocouple ', num2str(i)])
       hold on
       grid on
       plot(times, temps(:, i), 'k', times, est_temps, 'b', times,...
           est_temps_lower, '-.y', times, est_temps_upper, '-.y',...
           times, temps_lower(:,i), '--r', times, temps_upper(:,i), '--r')
       xlabel('Time (s)')
       ylabel('Temperature (C)')
       if i == 1
           legend('Experimental', 'Theoretical', 'AutoUpdate', 'off')
       end
    end
end

% Non-linear regression for best estimate of true alpha value.
function alpha = alpha_reg(single_data, filename)
    % Metal type check
    if contains(filename, 'Aluminum')
        a_0 = 5e-5;
    elseif contains(filename, 'Brass')
        a_0 = 5e-6;
    elseif contains(filename, 'Steel')
        a_0 = 4e-5;
    end
    H = single_data('H_exp');
    L = 0.127;
    T_0 = single_data('T_0');
    n = 1:10;

    % Fourier helpers for regressions function
    function bn = bncalc
        bn = (2*H*L*(-1).^n) ./ (pi^2.*(n-1/2).^2);
    end

    function lambda = lambdacalc
       lambda = (n-1/2) .* (pi/L); 
    end
    
    xl = [11/8; 15/8; 19/8; 23/8; 27/8; 31/8; 35/8; 39/8].*0.0254;
    time = single_data('time');
    temps = single_data('temps');
    al = zeros(1, length(xl));
    len = length(time);

    % regression loop
    for i = 1:length(xl)
        x = xl(i);
        tempfun = @(alph, t)T_0 + H*x +...
           sum((ones(len, 1)*bncalc) .* exp(t*(-abs(alph).*lambdacalc.^2)) .*...
           (ones(len, 1)*sin(lambdacalc.*x)), 2);
       al(i) = abs(nlinfit(time, temps(:, i), tempfun, a_0));
    end    
    alpha = mean(al);
end

% plot initial temperatures
function plot_exp_init(single_data, filename)
    temps = single_data('temps');
    temps_lower = single_data('temps_lower');
    temps_upper = single_data('temps_upper');
    x = [11/8; 15/8; 19/8; 23/8; 27/8; 31/8; 35/8; 39/8].*0.0254;
    
    figure
    hold on
    grid on
    xlabel('Position (m)')
    ylabel('Initial Temperature (C)')
    title({'Measure Initial Temperature', filename(1:end-4)},...
        'Interpreter', 'none')
    plot(x, temps(1, :), x, temps_lower(1, :), '--r',...
        x, temps_upper(1, :), '--r')    
    legend('Measured', 'Error');
end

% plot experiement vs analytical steady states
function plot_exp_analytical(single_data, filename)
    x = 0: 0.01 :(5.875*0.0254);
    T_0 = single_data('T_0');
    T_0_lower = single_data('T_0_lower');
    T_0_upper = single_data('T_0_upper');
    H_exp = single_data('H_exp');
    H_lower = single_data('H_lower');
    H_upper = single_data('H_upper');
    H_theo = single_data('H_theo');
    H_vary = single_data('H_vary');
    exp_temps = x*H_exp + T_0;
    lower_temps = x*H_lower + T_0_lower;
    upper_temps = x*H_upper + T_0_upper;
    theo_temps = x*H_theo + T_0;
    
    figure
    hold on
    grid minor
    xlabel('Position (m)')
    ylabel('Steady State Temperature (C)')
    title({'Theoretical and Experimental Temperature vs Position';...
        filename(1:end-4)}, 'Interpreter', 'none')
    plot(x, exp_temps, 'k', x, theo_temps, 'b')
    plot(x, lower_temps, '--r')
    plot(x, upper_temps, '--r')
    legend('Experimental', 'Theoretical', 'AutoUpdate', 'off')
    
    % plot H variations from allowable k range for material.
    for i=1:length(H_vary)
        vary_temps = x*H_vary(i) + T_0;
        plot(x, vary_temps, '-.y')       
    end   
end

% Linear Regression for H and T_0
function [added_reg_vals] = lin_reg(dataset)
    A = [11/8, 1;
        15/8, 1;
        19/8, 1;
        23/8, 1;
        27/8, 1;
        31/8, 1;
        35/8, 1;
        39/8, 1];

    A(:, 1) = A(:, 1) .* 0.0254;
    
    Area = (0.0254/2)^2 * pi;

    keys = dataset.keys();
    for i = 1:length(keys)
        single_data = dataset(keys{i});
        temps = single_data('temps');
        temps_lower = single_data('temps_lower');
        reg_temps_lower = temps_lower(end, :).';
        reg_lower = A \ reg_temps_lower;
        temps_upper = single_data('temps_upper');
        reg_temps_upper = temps_upper(end, :).';
        reg_upper = A \ reg_temps_upper;
        
        lin_reg_temps = temps(end, :).';
        reg = A \ lin_reg_temps;
        
        if contains(keys{i}, 'Aluminum')
            k = 130;
            kvary = 70: 10 :225;
        elseif contains(keys{i}, 'Steel')
            k = 16.2;
            kvary = 14:28;
        elseif contains(keys{i}, 'Brass')
            k = 115;
            kvary = 106: 5 :170;
        end
        power = str2power(keys{i});
        
        single_data('H_vary')= power ./ (Area.*kvary);
        
        single_data('H_theo') = power / (k*Area);
        single_data('H_exp') = reg(1);
        single_data('T_0') = reg(2);
        
        single_data('H_lower') = reg_lower(1);
        single_data('T_0_lower') = reg_lower(2);
        
        single_data('H_upper') = reg_upper(1);
        single_data('T_0_upper') = reg_upper(2);
        
        dataset(keys{i}) = single_data;        
    end   
    added_reg_vals = dataset;
end

% helper function to convert filename string to a power.
function power = str2power(filename)
    V_ind = strfind(filename, 'V');
    mA_ind = strfind(filename, 'mA');
    
    V = str2double(filename(V_ind-2:V_ind-1));
    A = str2double(filename(mA_ind-3:mA_ind-1)) / 1000;
    power = V * A;
end

% helper function to extract data from file.
function file_vals = file_extractor(filename)
    info = dlmread(filename, '\t', 1, 0);
    file_vals = containers.Map;
    file_vals('time') = info(:, 1) - info(1, 1);
    file_vals('temps') = info(:, 2:9);
    file_vals('temps_lower') = info(:, 2:9) - 2;
    file_vals('temps_upper') = info(:, 2:9) + 2;
end