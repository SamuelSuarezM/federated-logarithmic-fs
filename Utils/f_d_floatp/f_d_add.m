function binc=f_d_add(bina,binb);
%F_D_ADD addition of two binary floating point numbers

% dependencies: f_d_right_shift, f_d_add_binfp, f_d_round_bin

%
% Author G. Meurant
% May 2020
%

global bits_expo min_expo max_expo

nbitsa = bina.nbits;
nbitsb = binb.nbits;

if nbitsa ~= nbitsb
 error(' f_d_add: the inputs must have the same value of nbits')
end % if

if isempty(bina.I) && sum(bina.F) == 0
 % bina is zero
 binc = binb;
 return
end % if

if isempty(binb.I) && sum(binb.F) == 0
 % binb is zero
 binc = bina;
 return
end % if

Fa = bina.F;
Fb = binb.F;
if Fa(1) == Inf 
 error(' f_d_add: some variables are Inf')
end % if
if Fb(1) == Inf
 error(' f_d_add: some variables are Inf')
end % if

% which is the largest exponent?

if bina.E > binb.E
 % we have to shift binb the right
 e = bina.E;
 binb = f_d_right_shift(binb,bina.E-binb.E,binb.sign); 
elseif bina.E < binb.E
 % we have to shift bina to the right
 e = binb.E;
 bina = f_d_right_shift(bina,binb.E-bina.E,bina.sign); 

else
 e = bina.E;
end % if

bin = f_d_add_binfp(bina,binb); % addition of the significands 

% we may have to shift to normalize the result

lenI = length(bin.I);
I = bin.I;
F = bin.F;
sig = bin.sign;

if lenI ~= 0
 % we have to shift right
 F = [I(2:end) F]; % shift
 F = f_d_round_bin(F,nbitsa,sig); % carry ??????????
 I = 1;
 e = e + lenI - 1; % adjust the exponent
 
else
 % we have to shift left
 ind = find(F);
 I = uint8(1);
 if ~isempty(ind)
  ind1 = ind(1);
  F = F(ind1+1:end);
 else % I and F are zero?
  I = [];
  ind1 = 0;
 end % if
 lenF = length(F);
 F = [F zeros(1,nbitsa-lenF')]; % pad with zeros
 e = e - ind1;
 
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




