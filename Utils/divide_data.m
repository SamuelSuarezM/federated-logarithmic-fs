function [X_d, Y_d] = divide_data(X, Y, n, seed)
% Summary 
%    ----
% Inputs
%    X
%    Y
%    n: Number of 

if nargin == 4
    rng(seed)
end

m = size(X,1);
feat = size(X,2);
idx = randperm(m);
%X_d = cell(n,round(m/n));
%Y_d = cell(n,round(m/n));
for j = 1:feat
    for i = 0:(n-1)
        X_d{i+1,j} = X(idx((round(m*(i/n))+1):round(m*((i+1)/n))),j);
    end
end
for i = 0:(n-1)
    Y_d{i+1,:} = Y(idx((round(m*(i/n))+1):round(m*((i+1)/n))),:);
end