function [p,cnext]=p_add_bin_carry(a,b,c);
%P_ADD_BIN_CARRY addition of two unsigned binary strings with a carry in

% stored as arrays of 0's and 1's (1,na) and (1,nb)

% c is the carry, c = 0 or 1, this is useful to add 1 to the sum

% cnext = 1 tells that there was a last carry added to the left (carry out)

% straightforward algorithm with propagation of the carries to the left
% (can be slow for large numbers)

% One can do better with less tests (see p_minus_bin)

% 
% Author G. Meurant
% April 2020
%

cnext = 0;

% one of the inputs is zero
if sum(a) == 0 && c == 0
 p = b;
 return
end % if

if sum(b) == 0 && c == 0
 p = a;
 return
end % if

na = length(a);
nb = length(b);
n = max(na,nb);
p = zeros(1,n);

% pad the smallest one with zeros
if nb < na
 b = [zeros(1,na-nb),b];
 
elseif nb > na
 a = [zeros(1,nb-na),a];
end % if

if nargin == 2
 c = 0; % no carry in
end % if

if (na == 0) && (nb == 0)
 p = c;
 cnext = 0;
end % if

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
 p = [1 p]; % if there is a carry left, add the leftmost bit
end % if


