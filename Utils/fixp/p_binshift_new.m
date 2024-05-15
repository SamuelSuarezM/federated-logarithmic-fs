function p=p_binshift_new(a,n,nbits);
%P_BINSHIFT shift the bit string a by n positions, left (right) if positive (negative)

% nbits has to be large enough

% This is multiplication by a power of 2, 2^n
% integer division if n < 0

% a is a row vector

% returns a string with nbits or more if necessary for a positive shift
% for a negative shift the rightmost bits are lost since we return nbits

%
% Author G. Meurant
% March 2020
%

a = [zeros(1,nbits - length(a)), a]; % pad with zeros

if n == 0
 p = a;
 return
end % if

if n > 0
 p = [a zeros(1,n)];
 lp = length(p);
 p = p(lp-nbits+1:lp); % keep only nbits
 return
 
else
 p = [zeros(1,abs(n)) a];
 p = p(1:nbits);
 
end % if 

