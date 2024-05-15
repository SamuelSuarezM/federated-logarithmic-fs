function x=f_d_iszero(bin);
%F_D_ISZERO returns true (1) if the floating point binary number is zero

% no dependencies

% 
% Author G. Meurant
% May 2020
%

x = 0;

I = bin.I;
F = bin.F;

if sum(I) == 0 && sum(F) == 0
 x = 1;
end % if


