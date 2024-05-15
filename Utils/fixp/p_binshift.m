function p=p_binshift(a,n,nbits);
%P_BINSHIFT shift the bit string a by n positions, left (right) if positive (negative)

% This is multiplication by a power of 2, 2^n

% a is a row vector

% this is not a real shifting but this is what we need for p_dec2positGb

% for a real shift, see p_binshift_new

%
% Author G. Meurant
% March 2020
%

a = [zeros(1,nbits - length(a)), a];

if n == 0
 p = a;
 return
end % if

if n > 0
 p = [a zeros(1,n)];
 lp = length(p);
 p = p(lp-nbits+1:lp);
 return
 
else
 p = [zeros(1,n) a];
 p = p(1:nbits);
end % if 

