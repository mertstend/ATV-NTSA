% intro to nonlinear time series analysis

% tutorial 2: recurrence plots

% (c) Merten Stender
% Hamburg University of Technology, Dynamics Group
% m.stender@tuhh.de
% -------------------------------------------------------------------------

clear; close all; clc;




%% compute first RP in the chaotic regime

% model parameter
sigma = 10;
rho = 28;
beta = 8/3;

% time integration
tspan = [0:0.02:40];
y0 = [1; 0; 0];
[T,Y] = ode45(@(t,y) ode_lorenz(t, y, sigma, rho, beta), tspan, y0);

% set threshold
epsilon = .1;

% compute RP
[RP, DP] = compute_rp(Y, epsilon);

figure;
subplot(2,1,1);
plot(Y(:,1)); axis square;

subplot(2,1,2);
spy(RP,'k.', 0.2); set(gca, 'Ydir', 'normal'); axis square;
xlabel('$i$', 'interpreter', 'latex'); ylabel('$j$', 'interpreter', 'latex');
title(['recurrence plot, $\epsilon = $', num2str(epsilon)], 'interpreter', 'latex');


% compute the RP density
r = sum(RP(:))/numel(RP);
disp(['density rho = ', num2str(r)]);


%% periodic regime

% model parameter
sigma = 10;
rho = 24;
beta = 8/3;

% time integration
tspan = [0:0.02:10];
y0 = [1; 0; 0];
[T,Y] = ode45(@(t,y) ode_lorenz(t, y, sigma, rho, beta), tspan, y0);

% set threshold
epsilon = .05;

% compute RP
[RP, DP] = compute_rp(Y, epsilon);

figure;
subplot(2,1,1);
plot(Y(:,1)); axis square; ylabel('$x$', 'interpreter', 'latex');

subplot(2,1,2);
spy(RP,'k.', 0.2); set(gca, 'Ydir', 'normal'); axis square;
xlabel('$i$', 'interpreter', 'latex'); ylabel('$j$', 'interpreter', 'latex');
title(['recurrence plot, $\epsilon = $', num2str(epsilon)], 'interpreter', 'latex');


% compute the density
r = sum(RP(:))/numel(RP);
disp(['density rho = ', num2str(r)]);


%% transition analysis

% study the recurrence plot density for a fixed epsilon threshold along
% varying values of \rho
rho_grid = [22:0.1:60];

% set fixed epsilon
epsilon = .1;

% time integration
tspan = [0:0.02:10];
y0 = [1; 0; 0];

r_vals = zeros(size(rho_grid));

for i = 1:length(rho_grid)
    
    disp([num2str(i), '/', num2str(length(rho_grid))]); 
    
    rho = rho_grid(i); % update parameter value
    
    [T,Y] = ode45(@(t,y) ode_lorenz(t, y, sigma, rho, beta), tspan, y0);

    % compute RP
    [RP, DP] = compute_rp(Y, epsilon);
    
    r_vals(i) = sum(RP(:))/numel(RP);
    
end

figure; 
plot(rho_grid, r_vals, 'k-', 'marker', '.', 'markersize', 4); 
xlabel('$\rho$', 'interpreter', 'latex'); 
ylabel('density', 'interpreter', 'latex'); 
title(['RPQA Lorenz system, $\epsilon = $', num2str(epsilon)], 'interpreter', 'latex'); 
