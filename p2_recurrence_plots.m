% nonlinear time series analysis

% tutorial 2: recurrence plots

% (c) Merten Stender
% Hamburg University of Technology, Dynamics Group
% m.stender@tuhh.de
% -------------------------------------------------------------------------

clear; close all; clc; 

% model parameter
sigma = 10; 
rho = 28; 
beta = 8/3; 

% time integration
tspan = [0:0.02:40];
y0 = [1; 0; 0]; 
[T,Y] = ode45(@(t,y) ode_lorenz(t, y, sigma, rho, beta), tspan, y0);


%% compute first RP in the chaotic regime

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


% compute the density
rho = sum(RP(:))/numel(RP);
print(['density rho = ', num2str(rho)]); 