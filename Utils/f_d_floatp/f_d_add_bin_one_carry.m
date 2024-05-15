function [p,cnext]=f_d_add_bin_one_carry(a);
%F_D_ADD_BIN_ONE_CARRY add 1 to the binary number a

% cnext is the carry out

% could be done also with f_d_add_bin_carry adding zero with a carry in

% stored as arrays of uint8

% no dependencies

% 
% Author G. Meurant
% May 2020
%

n = length(a);
b = [zeros(1,n-1) 1];

if n == 0
 p = 1;
 cnext = 0;
 return
end % if

% p = zeros(1,n);
% c = 0; % carry
% for k = n:-1:1
%  cnext = 0; % next carry
%  ad = xor(a(k),b(k)); % addition of the bits
%  if (c == 0) && (a(k) == 1) &&( b(k) == 1)
%   cnext = 1;
%  end % if
%  if c == 1
%   cnext = 1;
%   if (a(k) == 0) &&( b(k) == 0)
%    cnext = 0;
%   end % if
%   ad = ~ad;
%  end % if
%  c = cnext;
%  p(k) = ad;
% end % for k

c = zeros(2,2);
c(1,2) = 1;
c(2,1) = 1;
car = zeros(2,2); % carries
car(2,2) = 1;

% results with carries
cc = eye(2,2);
ccar = ones(2,2); % carries
ccar(1,1) = 0;

ia = a + 1;
ib = b + 1;

ca = 0; % carry
p = zeros(1,n);
for k = n:-1:1
 if ca == 0
  ad = c(ia(k),ib(k));
  cnext = car(ia(k),ib(k));
 else
  ad = cc(ia(k),ib(k));
  cnext = ccar(ia(k),ib(k));
 end % if
 ca = cnext;
 p(k) = ad;
end % for k



