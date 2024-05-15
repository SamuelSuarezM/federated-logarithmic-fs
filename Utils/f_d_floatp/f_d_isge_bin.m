function x=f_d_isge_bin(a,b);
%F_D_ISGE_BIN true if a >= b

% a and b are two binary integers stored as row vectors of 0s and 1s

% no dependencies

%
% Author G. Meurant
% May 2020
%

na = length(a);
nb = length(b);

if na > nb
 x = 1;
 return
end % if

n = max(na,nb);
% pad with zeros
if nb < na
 b = [zeros(1,na-nb),b];
 
elseif nb > na
 a = [zeros(1,nb-na),a];
end % if

% test of equality (a is not > b)
if isequal(a,b)
 x = 1;
 return
end % if

x = 0;
for k = 1:n
 
 if a(k) == 1 && b(k) == 0
  x = 1;
  return
  
 elseif a(k) == 0 && b(k) == 1
  x = 0;
  return
 end % if
 
end % for k

x = 1;





