function [dydt] = ode_lorenz(t, y, sigma, rho, beta)
% [dydt] = ode_lorenz(t, y, sigma, rho, beta)

% Lorenz systems
% dxdt = sigma*(y-x);
% dydt = x*(rho-z)-y;
% dzdt = x*y-beta*z;

% x = y(1); 
% y = y(2); 
% z = y(3); 

% ODE system definition
dydt = [sigma*(y(2)-y(1)); 
        y(1)*(rho-y(3))-y(2); 
        y(1)*y(2)-beta*y(3)];

end

