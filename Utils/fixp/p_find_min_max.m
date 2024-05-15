function [minI,maxF]=p_find_min_max(bin);
%P_FIND_MAX_MIN find the first and last significand bits in bin

% bin is a structure containing the integer and fractional parts of a fixed point binay number

% min I is the index of the first significand bits in bin.I
% maxF is the last significand bit in bin.F

%
% Author G. Meurant
% April 2020
%

I = bin.I;
F = bin.F;
lI = length(I);
lF = length(F);

ind = find(I);

if ~isempty(ind)
%  minI = lI - ind(1);
 minI = ind(1);
else
 minI = 1;
end % if

ind = find(F);

if ~isempty(ind)
ind = find(F(lF:-1:1));
% maxF = ind(1);
maxF = lF - ind(1) + 1;
else
 % F is a vector of zeros
 maxF = 1;
end % if

