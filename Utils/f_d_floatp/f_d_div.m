function [r,flag] = f_d_div(diva,divb);
%F_D_DIV division of binary floating point numbers diva / divb

% compute an approximation of the inverse of divb and multiply by diva

% this code uses an approximate inverse of divb 

% dependencies: f_d_binfl_inv_Newton, f_d_mul_binfl

% 
% Author G. Meurant
% May 2020
% 

divaI = diva.I;
divaF = diva.F;
divbI = divb.I;
divbF = divb.F;

flag = 0;
if (sum(divbI) == 0) && (sum(divbF) == 0)
 % division by zero
 fprintf(' f_div: division by zero \n')
 flag = 1;
 r = diva;
 r.I = Inf(1,length(r.I)); % Inf
 r.F = Inf(1,length(r.F));
 r.float = Inf;
 return
end % if

if (sum(divaI) == 0) && (sum(divaF) == 0)
 % return zero
 r = diva;
 return
end % if

absdivb = divb;
absdivb.sign = 0;

[r,flag] = f_d_inv_Newton(absdivb); % Newton iteration for 1 / abs(divb) 

if flag == 1
 r = diva;
 return
end % if

r.sign = divb.sign;
if r.sign == 1
 r.float = -r.float;
end % if

r = f_d_mul(r, diva);




