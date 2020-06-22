% nonlinear time series analysis

% tutorial 1: delay embedding of the Lorenz system

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
tspan = [0:0.01:40];
y0 = [1; 0; 0]; 
[T,Y] = ode45(@(t,y) ode_lorenz(t, y, sigma, rho, beta), tspan, y0);

figure; 
subplot(3,2,[1, 3, 5]); 
plot3(Y(:,1), Y(:,2), Y(:,3), 'k-'); 
xlabel('$x$', 'interpreter', 'latex'); ylabel('$y$', 'interpreter', 'latex'); 
zlabel('$z$', 'interpreter', 'latex'); set(gca,'FontSize', 18);

subplot(3,2,2); 
plot(T, Y(:,1), 'b'); ylabel('$x$', 'interpreter', 'latex'); set(gca,'FontSize', 18);

subplot(3,2,4); 
plot(T, Y(:,2), 'r'); ylabel('$y$', 'interpreter', 'latex'); set(gca,'FontSize', 18);

subplot(3,2,6); 
plot(T, Y(:,3), 'g'); ylabel('$z$', 'interpreter', 'latex'); xlabel('time', 'interpreter', 'latex');set(gca,'FontSize', 18);


%% time delay embedding

% suppose that we have recorded only the first state of the system
s = Y(:,1); 

% set the embedding parameters
tau = 10; 
m = 3; 

% create delay-embedding vectors
X = delay_embedd(s, tau, m); 

% compare time-delay embedded vectors against true system
figure; 
ax1 = subplot(1,2,1); 
plot3(Y(:,1), Y(:,2), Y(:,3), 'k-'); 
xlabel('$x$', 'interpreter', 'latex'); ylabel('$y$', 'interpreter', 'latex'); 
zlabel('$z$', 'interpreter', 'latex'); set(gca,'FontSize', 18);

ax2 = subplot(1,2,2); 
plot3(X(:,1), X(:,2), X(:,3), 'r-'); 
xlabel('$x$', 'interpreter', 'latex'); ylabel('$y$', 'interpreter', 'latex'); 
zlabel('$z$', 'interpreter', 'latex'); set(gca,'FontSize', 18);



%% impact of embedding parameters

m = 2; 

% create delay-embedding vectors for \tau=1
tau1 = 1; 
X1 = delay_embedd(s, tau1, m); 

% create delay-embedding vectors for \tau=1
tau2 = 10;
X2 = delay_embedd(s, tau2, m); 

% create delay-embedding vectors for \tau=1
tau3 = 40;
X3 = delay_embedd(s, tau3, m); 

figure;
ax1 = subplot(1,3,1);
plot(X1(:,1), X1(:,2)); title(['tau = ', num2str(tau1)]); 
xlabel('$X_1$', 'interpreter', 'latex'); ylabel('$X_2$', 'interpreter', 'latex'); 

ax2 = subplot(1,3,2);
plot(X2(:,1), X2(:,2)); title(['tau = ', num2str(tau2)]); 
xlabel('$X_1$', 'interpreter', 'latex'); ylabel('$X_2$', 'interpreter', 'latex'); 

ax3 = subplot(1,3,3);
plot(X3(:,1), X3(:,2)); title(['tau = ', num2str(tau3)]);  
xlabel('$X_1$', 'interpreter', 'latex'); ylabel('$X_2$', 'interpreter', 'latex'); 

% normally, you would find \tau through the autocorrelation function or the
% mutual information function


%% how to select the embedding dimension

% intersection of trajectories is not possible --> criterion

% let's try some embedding dimensions
m1 = 3; 
m2 = 4; 
m3 = 5;

tau = 10; % fixed embedding delay

X1 = delay_embedd(s, tau, m1); 
[X1] = dim_reduction(X1, 3); %project into 3D using PCA for visualization

X2 = delay_embedd(s, tau, m2); 
[X2] = dim_reduction(X2, 3);

X3 = delay_embedd(s, tau, m3); 
[X3] = dim_reduction(X3, 3);

figure;
ax1 = subplot(1,3,1);
plot3(X1(:,1), X1(:,2), X1(:,3)); title(['m = ', num2str(m1)]); 
xlabel('$X_1$', 'interpreter', 'latex'); ylabel('$X_2$', 'interpreter', 'latex'); zlabel('$X_3$', 'interpreter', 'latex'); 

ax2 = subplot(1,3,2);
plot3(X2(:,1), X2(:,2), X2(:,3)); title(['m = ', num2str(m2)]); 
xlabel('$X_1$', 'interpreter', 'latex'); ylabel('$X_2$', 'interpreter', 'latex'); zlabel('$X_3$', 'interpreter', 'latex'); 

ax3 = subplot(1,3,3);
plot3(X3(:,1), X3(:,2), X3(:,3)); title(['m = ', num2str(m3)]);  
xlabel('$X_1$', 'interpreter', 'latex'); ylabel('$X_2$', 'interpreter', 'latex'); zlabel('$X_3$', 'interpreter', 'latex'); 

