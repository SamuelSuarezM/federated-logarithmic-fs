function binc=f_d_mul_binf(bina,binb,round);
%F_D_MUL_BINF product of two fixed point numbers

% the inputs are structures with bin.sign, bin.I and bin.F
% which are the sign, integer and fractional parts

% the length of the fractional part is fixed, but the length of the integer
% part can grow

% we round the fractional part 

% dependencies: f_d_addbin, f_d_round_bin, f_d_add_bin_one_carry, f_d_bin2dec, f_d_bin2frac,
%               f_d_find_min_max

%
% Author G. Meurant
% May 2020
%

if nargin == 2
 round = 1;
end % if

nbitsa = bina.nbits;
nbitsb = binb.nbits;

if nbitsa ~= nbitsb
 error(' f_d_mul_binf: the inputs must have the same value of nbits')
end % if

lIa = length(bina.I);
lFa = length(bina.F);
lIb = length(binb.I);
lFb = length(binb.F);

pa = lIa - 1;
qa = lFa;
pb = lIb - 1;
qb = lFb;

[minIa,maxFa] = f_d_find_min_max(bina);
% maxFa = nbitsa;
[minIb,maxFb]= f_d_find_min_max(binb);
% maxFb = nbitsb;

exIa = length(bina.I) - minIa;
exIb = length(binb.I) - minIb;
exI = exIa + exIb; % maximum positive power of 2
exFa = maxFa;
exFb = max(maxFb,nbitsa);
exF = exFa + exFb; % maximum negative power of 2
% nq = exI + exF + 1; % total length necessary for the multiplication
nq = max(exI,exF) + 1; % this is too large

% nq = max([2*minIa+1,2*maxFa,2*minIb+1,2*maxFb]) + 1; % is this correct???? not sure

% sign
sig = xor(bina.sign,binb.sign);

% concatenation of I and F and padding with zeros
sa = [zeros(1,nq-pa-1), bina.I, bina.F, zeros(1,nq-qa)];
ea = [nq-1:-1:-nq];
emin = ea(end);
sb = [zeros(1,nq-pb-1), binb.I, binb.F, zeros(1,nq-qb)];
lsa = length(sa);

s = zeros(1,lsa); % to accumulate the products

inda = find(sa); % find the nonzero elements
indb = find(sb);

% for i = indb
%  % multiply sa by sb(i)
%  temp = zeros(1,lsa);
%  
%  for j = inda
%   eaij = ea(i) + ea(j); % power of 2
% 
%   index = lsa - (eaij - emin);
%   
% %   if index < 1
% %    fprintf('\n i = %d, j = %d, nq = %d, index = % d \n',i,j,nq,index)
% %    error(' f_d_mul_binf_d_u: wrong index ')
% %   end % if
%   
%   temp(index) = 1;
%  end % for j
%  
% %  ls = length(s)
%  [s,cnext] = f_d_addbin(s,temp); % pb: carry ?????? 
%  
% end % for i

linda = length(inda);
lindb = length(indb);
if linda <= lindb
 ind1 = inda;
 ind2 = indb;
else
 ind1 = indb;
 ind2 = inda;
end % if

for i = ind1
 % multiply sa by sb(i)
 temp = zeros(1,lsa);
 
 for j = ind2
  eaij = ea(i) + ea(j); % power of 2

  index = lsa - (eaij - emin);
  
%   if index < 1
%    fprintf('\n i = %d, j = %d, nq = %d, index = % d \n',i,j,nq,index)
%    error(' f_d_mul_binf_d_u: wrong index ')
%   end % if
  
  temp(index) = 1;
 end % for j
 
%  ls = length(s)
 [s,cnext] = f_d_addbin(s,temp); % pb: carry ?????? 
 
end % for i

% F = last nq bits of s
ls = length(s);
I = s(1:ls-nq);
F = s(ls-nq+1:end);

if round == 1 % this is to avoid double rounding
 % round F to nbits
 [F,cnext] = f_d_round_bin(F,nbitsa,sig);
 if cnext ~= 0 % we have to add 1 to I
  [I,cnex] = f_d_add_bin_one_carry(I);
  if cnex == 1
   I = [1 I];
  end % if
 end % if
 
end % if

% remove the leading zero bits in I
ind = find(I);
if ~isempty(ind)
 minI = ind(1);
 
else
 minI = 0;
end % if

if minI ~= 0
 I = I(minI:end);
 
else
 I = [];
end % if

x = f_d_bin2dec(I) + f_d_bin2frac(F); % double floating point value
if sig == uint8(1)
 x = -x;
end % if

binc = struct('sign',sig,'I',I,'F',F,'E',[],'float',x,'nbits',nbitsa);







