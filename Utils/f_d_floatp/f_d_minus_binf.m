function binc=f_d_minus_binf(bina,binb);
%F_D_MINUS_BINF subtraction of two fixed point binary numbers, bina - binb

% bin is a structure bin.sign, bin.I, bin.F, bin.float containing binary numbers
% representing the sign, the integer part and the fractional part as well
% as the double precision value if available

% in this function bina and binb must have the same nbits and we do not
% remove the trailing zero bits

% dependencies: f_d_add_binfp, f_d_minus_bin, f_d_isge_bin, f_d_iszero

%
% Author G. Meurant
% May 2020
%

if bina.nbits ~= binb.nbits
 error(' f_d_minus_binf: the two inputs must have the same value of nbits')
end % if

nbits = bina.nbits;

siga = bina.sign;
sigb = binb.sign;

if f_d_iszero(bina) == 1 
 binc = binb;
 binc.sign = ~binb.sign;
 binc.float = -binb.float;
 return
end % if

if f_d_iszero(binb) == 1 
 binc = bina;
 return
end % if

% we have to look at the signs and the absolute values

if siga == 0 && sigb == 1 % binc = bina + | binb |
 binb.sign = 0;
 binb.float = -binb.float;
 binc = f_d_add_binfp(bina,binb);
 return
end % if

if siga == 1 && sigb == 0 % binc = -( | bina | + binb)
 bina.sign = 0;
 bina.float = -bina.float;
 binc = f_d_add_binfp(bina,binb);
 binc.sign = 1;
 binc.float = -binc.float;
 return
end % if

if siga == 0 && sigb == 0
 ba = [bina.I bina.F];
 bb = [binb.I binb.F];
 
 if f_d_isge_bin(ba,bb) % a > b
  binc = bina;
  [bin,cnext] = f_d_minus_bin(ba,bb,0);
  % F = last nbits bits of bin
  ls = length(bin);
  binc.I = bin(1:ls-nbits);
  binc.F = bin(ls-nbits+1:end);
  binc.sign = 0;
  binc.float = bina.float - binb.float; % ???????????????
  ind = find(binc.I);
  if isempty(ind)
   binc.I = [];
  else
   binc.I = binc.I(ind(1):end);
  end % if
  return
  
 else % a < b
  binc = f_d_minus_binf(binb,bina);
  binc.sign = ~binc.sign;
  binc.float = - binc.float;
  return
  
 end % if
 
end % if

if siga == 1 && sigb == 1
 bina.sign = 0;
 bina.float = -bina.float;
 binb.sign = 0;
 binb.float = -binb.float;
 ba = [bina.I bina.F];
 bb = [binb.I binb.F];
 
 if f_d_isge_bin(ba,bb) % | a | >= | b |, binc = -(| a | - | b |)
  binc = f_d_minus_binf(bina,binb);
  binc.sign = ~binc.sign;
  binc.float = -binc.float;
  return
  
 else % | a | < | b |, binc = | b | - | a |
  binc = f_d_minus_binf(binb,bina);
  return
  
 end % if isge
 
end % if siga



