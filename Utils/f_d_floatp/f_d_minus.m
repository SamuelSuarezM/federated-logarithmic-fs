function binc=f_d_minus(bina,binb);
%F_D_MINUS subtraction of two binary floating point numbers

% dependencies: f_d_right_shift, f_d_round_bin, f_d_minus_binf, f_d_floatp2dec

%
% Author G. Meurant
% May 2020
%

global bits_expo min_expo max_expo

nbitsa = bina.nbits;
nbitsb = binb.nbits;

if nbitsa ~= nbitsb
 error(' f_d_minus: the inputs must have the same value of nbits')
end % if

if isempty(bina.I) && sum(bina.F) == 0
 % bina is zero
 binc = binb;
 binc.sign = ~binc.sign;
 binc.float = -binc.float;
 return
end % if

if isempty(binb.I) && sum(binb.F) == 0
 % binb is zero
 binc = bina;
 return
end % if

% which is the largest exponent?

if bina.E > binb.E
 % we have to shift binb the right
 e = bina.E;
 binb = f_d_right_shift(binb,bina.E-binb.E,binb.sign);
elseif bina.E < binb.E
 % we have to shift bina to the right
 e = binb.E;
 bina = f_d_right_shift(bina,binb.E-bina.E,binb.sign);
else
 e = bina.E;
end % if

% the exponents are now the same
bin = f_d_minus_binf(bina,binb); % subtraction of the significands 

% we may have to shift to normalize the result

lenI = length(bin.I);
I = bin.I;
F = bin.F;
sig = bin.sign;

if lenI ~= 0 
 % we have to shift right
 F = [I(2:end) F]; % shift
 F = f_d_round_bin(F,nbitsa,sig);
 I = [1];
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
 F = [F zeros(1,nbitsa-lenF)]; % pad with zeros
 e = e - ind1; % adjust the exponent
 
end % if

% binc = struct('sign',bin.sign,'I',I,'F',F,'E',e,'float',0,'nbits',nbitsa);

if bits_expo ~= 0
 % check the expopnent for over(under)flow
 if e > max_expo % overflow
  I = Inf(1,length(I)); 
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






