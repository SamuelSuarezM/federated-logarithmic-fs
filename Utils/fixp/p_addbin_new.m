function [p,cnext]=p_addbin_new(a,b);
%P_ADDBIN_NEW addition of two binary strings

% use conversion to double precision numbers if it could be done

% stored as arrays of 0's and 1's (1,na) and (1,nb)

% cnext = 1 tells that there was a last carry added to the left

% 
% Author G. Meurant
% April 2020
%

cnext = 0;

if sum(a) == 0
 % a is zero
 p = b;
 return
end % if
if sum(b) == 0
 % b is zero
 p = a;
 return
end % if

na = length(a);
nb = length(b);
n = max(na,nb);
% pad with zeros
if nb < na
 b = [zeros(1,na-nb),b];
 
elseif nb > na
 a = [zeros(1,nb-na),a];
end % if

% if a and b can be represented in double precision (this does not work if
% one of the inputs represent a negative number)
if n <= 63
 ia = p_mbin2dec(a);
 ib = p_mbin2dec(b);
 p = p_mdec2bin(ia + ib,64);
 ind = find(p);
 p = p(ind(1):end);
 cnext = 0;
 return
 
else
 [p,cnext] = p_addbin(a,b);
end % if 

