function [p,cnext]=p_addbin(a,b);
%P_ADDBIN addition of two binary strings (positive integers)

% stored as arrays of 0's and 1's (1,na) and (1,nb)

% cnext = 1 tells that there was a last carry added to the left

% straightforward algorithm with propagation of the carries to the left

% This works, but one can do better with less tests (see p_minus_bin)

% 
% Author G. Meurant
% March 2020
%

cnext = 0;

if sum(a) == 0
 p = b;
 return
end % if
if sum(b) == 0
 p = a;
 return
end % if

na = length(a);
nb = length(b);
n = max(na,nb);
% padd with zeros
if nb < na
 b = [zeros(1,na-nb),b];
elseif nb > na
 a = [zeros(1,nb-na),a];
end % if

c = 0; % carry
for k = n:-1:1
 cnext = 0; % next carry
 ad = xor(a(k),b(k)); % addition of the bits
 if (c == 0) && (a(k) == 1) &&( b(k) == 1)
  cnext = 1;
 end % if
 if c == 1
  cnext = 1;
  if (a(k) == 0) &&( b(k) == 0)
   cnext = 0;
  end % if
  ad = ~ad;
 end % if c = 1
 c = cnext;
 p(k) = ad;
end % for k

if cnext == 1
 p = [1 p]; % if there is a carry out, add the leftmost bit
end % if


