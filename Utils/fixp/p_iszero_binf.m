function x=p_iszero_binf(bin);
%P_ISZERO_BINF returns true (1) if the fixed point binary number is zero

x = 0;

I = bin.I;
F = bin.F;

if sum(I) == 0 && sum(F) == 0
 x = 1;
end % if


