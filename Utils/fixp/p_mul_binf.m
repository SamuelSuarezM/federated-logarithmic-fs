function binc=p_mul_binf(bina,binb);
%P_MUL_BINF product of two fixed point numbers

% the inputs are structures with bin.sign, bin.I and bin.F
% which are the sign, integer and fractional parts

% the length of the fractional part is fixed, but the length of the integer
% part can grow

% we round the fractional part to nearest even

%
% Author G. Meurant
% April 2020
%

nbitsa = bina.nbits;
nbitsb = binb.nbits;

if nbitsa ~= nbitsb
 error(' p_mul_binf: the inputs must have the same value of nbits')
end % if

lIa = length(bina.I);
lFa = length(bina.F);
lIb = length(binb.I);
lFb = length(binb.F);

pa = lIa - 1;
qa = lFa;
pb = lIb - 1;
qb = lFb;

[minIa,maxFa] = p_find_min_max(bina);
maxFa = nbitsa;
[minIb,maxFb]=p_find_min_max(binb);
maxFb = nbitsb;
nq= max([2*minIa+1,2*maxFa,2*minIb+1,2*maxFb]) + 1; % is this correct???? not sure
% nq = max(nq,2*nbitsa);
dec = abs(bina.float * binb.float);
nq = max(ceil(log2(dec)),nq);

% sign
sig = xor(bina.sign,binb.sign);

% concatenation of I and F and padding with zeros
sa = [zeros(1,nq-pa-1), bina.I, bina.F, zeros(1,nq-qa)];
ea = [nq-1:-1:-nq];
emin = ea(end);
sb = [zeros(1,nq-pb-1), binb.I, binb.F, zeros(1,nq-qb)];
% eb = [nq-1:-1:-nq]
lsa = length(sa);

if lsa > 500
 error(' too much storage')
end % if

s = zeros(1,lsa); % to accumulate the products

inda = find(sa == 1);
indb = find(sb == 1);

for i = indb
 % multiply sa by sb(i)
 temp = zeros(1,lsa);
 
 for j = inda
  eaij = ea(i) + ea(j); % power of 2
  
%   if eaij > ea(1)
%    fprintf(' an index is too large \n') % this must not happen
%   end % if
  
  if eaij < ea(end)
   fprintf(' an index is too small \n') % this must not happen
  end % if
  
  % find the index where to store it in temp
%   index = i + j - nq;
% index = find(ea == eaij);

  index = lsa - (eaij - emin);
  
  if index < 1
   fprintf('\n i = %d, j = %d, nq = %d, index = % d \n',i,j,nq,index)
   error(' p_mul_binf: wrong index ')
  end % if
  
  temp(index) = 1;
 end % for j
 
%  if length(temp) > lsa
%   fprintf(' Caution: the length of temp has increased \n')
%  end % if
 
 ls = length(s);
 [s,cnext] = p_addbin(s,temp); % pb: carry ??????
 
%  if length(s) > ls
%   fprintf(' the length of s is increasing, before = % d, after % d \n',ls,length(s))
%  end % if
 
end % for i

% if length(s) > 2 * nq
%  fprintf(' Problem: s is longer than 2 nq with length %d \n',length(s))
% end % if

% I = s(1:nq); % this is not correct if the length of s has increased
% F = s(nq+1:2*nq);

% F = last nq bits of s
ls = length(s);
I = s(1:ls-nq);
F = s(ls-nq+1:end);

% F = F(1:nbitsa); % chop F

% round F to nbits
[F,cnext] = f_d_round_bin(F,nbitsa,sig);
if cnext ~= 0 % we have to add 1 to I
 [I,cnex] = p_add_bin_one_carry(I);
 if cnex == 1
  I = [1 I];
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

x = p_mbin2dec(I) + p_mbin2frac(F); % double floating point value
if sig == 1
 x = -x;
end % if

binc = struct('sign',sig,'I',I,'F',F,'float',x,'nbits',nbitsa);







