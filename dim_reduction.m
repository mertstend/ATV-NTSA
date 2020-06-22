function [Xred] = dim_reduction(X, dim)
% [Xred] = dimensionalityReduction(X, dim)

% Linear projection of X onto lower dimensional space with dimension dim.

% (c) Merten Stender
% Hamburg University of Technology, Dynamics Group
% m.stender@tuhh.de
% -------------------------------------------------------------------------

if size(X,2)>size(X,1)
    X = X'; % make it a column matrix
end

if dim>size(X,2)
    error('Choose a smaller dimension to project onto');
end

% PCA
[coeff, ~] = pca(X);

% select the first <dim> principle components
reducedDimension = coeff(:,1:dim);

% project original data onto the first <dim> components
Xred = X * reducedDimension;


end

