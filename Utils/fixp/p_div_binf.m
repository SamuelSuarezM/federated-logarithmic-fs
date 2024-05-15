function [r,flag] = p_div_binf(diva,divb);
%P_DIV_BINF division of binary floating point numbers diva / divb

% compute an approximation of the inverse of divb and multiply by diva

% this code uses an approximate inverse of divb 

flag = 0;
if (sum(divb.I) + sum(divb.F)) == 0
 % division by zero
 fprintf(' p_div_binf: division by zero \n')
 flag = 1;
 r = diva;
 return
end % if

if (sum(diva.I) + sum(diva.F)) == 0
 % return zero
 r = diva;
 return
end % if

absdivb = divb;
absdivb.sign = 0;

[r,flag] = p_binf_inv_Newton(absdivb); % Newton iteration for 1 / abs(divb)

if flag == 1
 r = diva;
 return
end % if

r.sign = divb.sign;
if r.sign == 1
 r.float = -r.float;
end % if

r = p_mul_binf(r, diva);

