function [RP, DP] = compute_rp(Y, epsilon)
% [R] = compute_rp(Y, epsilon)

% manual brute-force implementation for computing a recurrence plot

% (c) Merten Stender
% Hamburg University of Technology, Dynamics Group
% m.stender@tuhh.de
% -------------------------------------------------------------------------

% number of time samples
N = size(Y,1);

% let's normalize the data to [-1, 1];
a = -1; b = 1;
Y = (Y-min(Y(:)))*(b-a)/(max(Y(:))-min(Y(:)))+a;

% compute pairwise distance plot
DP = pdist(Y, 'euclidean');

% reshape into N x N
RP_temp = squareform(DP); % this will have zeros on the diagonal by default

% threshold (binarize) the distance plot by epsilon
RP = zeros(N,N);
RP(RP_temp<=epsilon) = 1;

end

