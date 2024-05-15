function [r,flag] = f_d_div_INT(diva,divb);
%DIV_INT logarithmic division of binary integer fixed point numbers diva / divb
% 
% 

divaI = diva.I;
divaF = diva.F;
divbI = divb.I;
divbF = divb.F;

flag = 0;
if (sum(divbI) == 0) && (sum(divbF) == 0)
 % division by zero
 fprintf(' div_binf: division by zero \n')
 flag = 1;
 r = diva;
 return
end % if

% if fix_iszero(divaI) && fix_iszero(divaF)
if (sum(divaI) == 0) && (sum(divaF) == 0)
 % return zero
 r = diva;
 return
end % if

absdivb = divb;
absdivb.sign = 0;


if flag == 1
 r = diva;
 return
end % if

%r = mul_binf(r, diva);
k1= length(divaI)-1;
x1= divaI;
x1(1) = [];
x1_2 = f_d_bin2frac(x1);
k2= length(divbI)-1;
x2= divbI;
x2(1) = [];
x2_2 = f_d_bin2frac(x2);

if x1_2-x2_2 < 0 
    q = 2^(k1-k2-1)*(2+x1_2-x2_2);
else
    q = 2^(k1-k2)*(1+x1_2-x2_2);
end
r = fix_dec2binfm(q,diva.nbits);

if length(r.I) > 512
 fprintf(' Caution: the integer part is larger than %g \n',2^512)
end % if