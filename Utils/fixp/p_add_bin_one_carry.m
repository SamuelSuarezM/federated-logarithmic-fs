function [p,cnext]=p_add_bin_one_carry(a);
%P_ADD_BIN_ONE_CARRY add 1 to the binary number a

% cnext is the carry out

% could be done also with p_add_bin_carry adding zero with a carry in

% stored as arrays of 0's and 1's 

% 
% Author G. Meurant
% March 2020
%

n = length(a);
b = [zeros(1,n-1) 1];

if n == 0
 p = 1;
 cnext = 0;
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
 end % if
 c = cnext;
 p(k) = ad;
end % for k




