function binc=f_d_minus_binfp(bina,binb);
%F_D_MINUS_BINFP subtraction of two fixed point binary numbers, bina - binb

% bin is a structure containing binary numbers representing the sign, the integer part
% and the fractional part as well as the double precision value if available

% in this function bina and binb must have the same nbits and we do not
% remove the trailing zero bits

% dependencies: f_d_add_binfp, f_d_minus_bin, f_d_isge_bin, f_d_bin2dec, f_d_bin2frac

%
% Author G. Meurant
% May 2020
%

if bina.nbits ~= binb.nbits
 error(' f_d_minus_binfp: the two inputs must have the same value of nbits')
end % if

nbitsa = bina.nbits;

siga = bina.sign;
sigb = binb.sign;

if sum(bina.I) == 0 && sum(bina.F) == 0
 binc = binb;
 binc.sign = ~binb.sign;
 binc.float = -binb.float;
 return
end % if

if sum(binb.I) == 0 && sum(binb.F) == 0
 binc = bina;
 return
end % if

% we have to look at the signs and the absolute values

if siga == 0 && sigb == 1 % bina > 0, binb < 0,  binc = bina + | binb |
 binb.sign = 0;
 binb.float = -binb.float;
 binc = f_d_add_binfp(bina,binb);
 return
end % if

if siga == 1 && sigb == 0 % bina < 0, binb > 0,  binc = -( | bina | + binb )
 bina.sign = 0;
 bina.float = -bina.float;
 binc = f_d_add_binfp(bina,binb);
 binc.sign = 1;
 binc.float = -binc.float;
 return
end % if

if siga == 0 && sigb == 0 % bina > 0, binb >0 
 % the F fields may not have the same lengthes, pad with zeros
 Fa = bina.F;
 lFa = length(Fa);
 Fb = binb.F;
 lFb = length(Fb);
 len = max(lFa,lFb);
 Fa = [Fa zeros(1,len-lFa)];
 Fb = [Fb zeros(1,len-lFb)];
 Ia = bina.I;
 Ib = binb.I;
 if isempty(Ia)
  Ia = 0;
 end % if
 if isempty(Ib)
  Ib = 0;
 end % if
 ba = [Ia Fa];
 bb = [Ib Fb];
 
 if f_d_isge_bin(ba,bb) % a > b 
  [bin,cnext] = f_d_minus_bin(ba,bb,0); 
  % F = last len bits of bin
  ls = length(bin);
  I = bin(1:ls-len);
  F = bin(ls-len+1:end);
  sig = 0;
  ind = find(I);
  if isempty(ind)
   I = [];
  else
   I = I(ind(1):end);
  end % if
  x = f_d_bin2dec(I) + f_d_bin2frac(F); % double floating point value
 
  binc = struct('sign',sig,'I',I,'F',F,'float',x,'nbits',nbitsa);
  return
  
 else % a < b
  binc = f_d_minus_binfp(binb,bina);
  binc.sign = ~binc.sign;
  binc.float = - binc.float;
  return
  
 end % if fix
 
end % if

if siga == 1 && sigb == 1
 bina.sign = 0;
 bina.float = -bina.float;
 binb.sign = 0;
 binb.float = -binb.float;
 % the F fields may not have the same lengthes, pad with zeros
 Fa = bina.F;
 lFa = length(Fa);
 Fb = binb.F;
 lFb = length(Fb);
 len = max(lFa,lFb);
 Fa = [Fa zeros(1,len-lFa)];
 Fb = [Fb zeros(1,len-lFb)];
 ba = [bina.I Fa];
 bb = [bina.I Fb];
 
 if f_d_isge_bin(ba,bb) % | a | >= | b |, binc = -(| a | - | b |)
  binc = f_d_minus_binfp(bina,binb);
  binc.sign = ~binc.sign;
  binc.float = -binc.float;
  return
  
 else % | a | < | b |, binc = | b | - | a |
  binc = f_d_minus_binfp(binb,bina);
  return
  
 end % if isge
 
end % if siga



