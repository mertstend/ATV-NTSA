function [X] = delay_embedd(s, tau, m)
% [X] = delay_embedd(s, tau, m)

%  According to Taken's Theorem
%  (http://en.wikipedia.org/wiki/Takens%27_theorem)

% X(n)=(s_n, s_n-tau, s_n-2*tau, ... ,s_n-(m-1)*tau)

% (c) Merten Stender
% Hamburg University of Technology, Dynamics Group
% m.stender@tuhh.de
% -------------------------------------------------------------------------

% Time delay embedding of a single univariate time series s

% number of samples in s(t)
N = length(s);

% resulting length of the time delay embedded vectors
N_max = N-(tau*(m-1));

% per-allocate the resulting array [N, m]
X = nan(N_max, m);
% X(:,1) = s(1:N_max);

% generate the time-delayed vectors
for i = 1:m
    X(1:end,i) = s(1+(i-1)*tau:end-(m-i)*tau);
end

end