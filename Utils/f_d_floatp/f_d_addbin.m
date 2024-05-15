function [p,cnext]=f_d_addbin(a,b);
%F_D_ADDBIN addition of two binary strings (positive integers)

% stored as arrays of 0's and 1's (1,na) and (1,nb)

% no carry in, see f_d_add_bin_carry

% cnext = 1 tells that there was a last carry added to the left

% straightforward algorithm with propagation of the carries to the left

% no dependencies

% 
% Author G. Meurant
% May 2020
%

cnext = 0;

% remove the leading zeros
la = length(a);
lb = length(b);
len = max(la,lb);
inda = find(a);
if ~isempty(inda)
%  a = a(inda(1):end);
end % if
indb = find(b);
if ~isempty(indb)
%  b = b(indb(1):end);
end % if

% if sum(a) == 0
if isempty(inda)
 p = b;
 return
end % if
% if sum(b) == 0
if isempty(indb)
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

% c = 0; % carry
% p = zeros(1,n);
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
%  end % if c = 1
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

if cnext == 1
 p = [1 p]; % if there is a carry out, add the leftmost bit
end % if

lp= length(p);
if lp < len
 p = [zeros(1,len-lp) p];
end % if



