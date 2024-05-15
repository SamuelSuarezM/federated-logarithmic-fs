function [minI,maxF]=f_d_find_min_max(bin);
%F_D_FIND_MIN_MAX find the first and last significand bits in bin

% bin is a structure containing the integer and fractional parts of a floating point binay number

% min I is the index of the first significand bits in bin.I
% maxF is the last significand bit in bin.F

% no dependencies

%
% Author G. Meurant
% May 2020
%

I = bin.I;
F = bin.F;
lF = length(F);

ind = find(I);

if ~isempty(ind)
 minI = ind(1);
else
 minI = 1;
end % if

ind = find(F);

if ~isempty(ind)
ind = find(F(lF:-1:1));
maxF = lF - ind(1) + 1;
else
 % F is a vector of zeros
 maxF = 1;
end % if

