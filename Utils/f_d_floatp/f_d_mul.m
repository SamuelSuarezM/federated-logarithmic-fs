function binc=f_d_mul(bina,binb);
%F_D_MUL multiplication of two binary floating point numbers

% dependencies: f_d_mul_binf, f_d_round_bin, f_d_floatp2dec

%
% Author G. Meurant
% May 2020
%

global bits_expo min_expo max_expo

if isempty(bits_expo)
 bits_expo = 0;
end % if

nbitsa = bina.nbits;
nbitsb = binb.nbits;

if nbitsa ~= nbitsb
 error(' f_d_mul: the inputs must have the same value of nbits')
end % if

if isempty(bina.I) && sum(bina.F) == 0
 % bina is zero
 binc = bina;
 return
end % if

if isempty(binb.I) && sum(binb.F) == 0
 % binb is zero
 binc = binb;
 return
end % if

Fa = bina.F;
Fb = binb.F;
if Fa(1) == Inf 
 error(' f_d_mul: some variables are Inf')
end % if
if Fb(1) == Inf
 error(' f_d_mul: some variables are Inf')
end % if

e = bina.E + binb.E; % exponent

bin = f_d_mul_binf(bina,binb,1); % multiplication of the significands 

% we may have to shift to normalize the result

lenI = length(bin.I);
I = bin.I;
F = bin.F;
sig = bin.sign;

if lenI ~= 0 
 % we have to shift right
 F = [I(2:end) F]; % shift
 F = f_d_round_bin(F,nbitsa,sig); 
 I = 1;
 e = e + lenI - 1; % adjust the exponent

else
 % we have to shift left
 if length(F) > nbitsa
  F = F(1:nbitsa);
 end % if
 ind = find(F);
 if ~isempty(ind)
  I = 1;
  F = F(ind(1)+1:end);
  lenF = length(F);
  F = [F zeros(1,nbitsa-lenF)]; % pad with zeros
  e = e - ind(1);
 end % if
 
end % if

% binc = struct('sign',bin.sign,'I',I,'F',F,'E',e,'float',0,'nbits',nbitsa);

if bits_expo ~= 0
 % check the expopnent for over(under)flow
 if e > max_expo % overflow
  I = Inf(1,length(I)); % Inf
  F = Inf(1,length(F));
 end % if
 if e < min_expo % underflow
  I = zeros(1,max(length(I),1));
  F = zeros(1,length(F));
 end % if
end % if bits_expo

binc = bina;
binc.sign = bin.sign;
binc.I = I;
binc.F = F;
binc.E = e;
binc.float = f_d_floatp2dec(binc);
binc.nbits = nbitsa;






