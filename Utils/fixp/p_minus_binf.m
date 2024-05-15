function binc=p_minus_binf(bina,binb);
%P_MINUS_BINF subtraction of two fixed point binary numbers, bina - binb

% bin is a structure bin.sign, bin.I, bin.F, bin.float containing binary numbers
% representing the sign, the integer part and the fractional part as well
% as the double precision value if available

% in this function bina and binb must have the same nbits and we do not
% remove the trailing zero bits

%
% Author G. Meurant
% April 2020
%

if bina.nbits ~= binb.nbits
 error(' p_minus_binf: the two inputs must have the same value of nbits')
end % if

nbits = bina.nbits;

siga = bina.sign;
sigb = binb.sign;

if p_iszero_binf(bina) == 1
 binc = binb;
 binc.sign = ~binb.sign;
 binc.float = -binb.float;
 return
end % if

if p_iszero_binf(binb) == 1
 binc = bina;
 return
end % if

% we have to look at the signs and the absolute values

if siga == 0 && sigb == 1 % binc = bina + | binb |
 binb.sign = 0;
 binb.float = -binb.float;
 binc = p_add_binf(bina,binb);
 return
end % if

if siga == 1 && sigb == 0 % binc = -( | bina | + binb
 bina.sign = 0;
 bina.float = -bina.float;
 binc = p_add_binf(bina,binb);
 binc.sign = 1;
 binc.float = -binc.float;
 return
end % if

if siga == 0 && sigb == 0
 ba = [bina.I bina.F];
 bb = [binb.I binb.F];
 
 if p_isge_bin(ba,bb) % a > b
  binc = bina;
  [bin,cnext] = p_minus_bin(ba,bb,0);
  % F = last nbits bits of s
  ls = length(bin);
  binc.I = bin(1:ls-nbits);
  binc.F = bin(ls-nbits+1:end);
  binc.sign = 0;
  binc.float = bina.float - binb.float;
  ind = find(binc.I);
  if isempty(ind)
   binc.I = [];
  else
   binc.I = binc.I(ind(1):end);
  end % if
  return
  
 else % a < b
  binc = p_minus_binf(binb,bina);
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
 
 if p_isge_bin(ba,bb) % | a | >= | b |, binc = -(| a | - | b |)
  binc = p_minus_binf(bina,binb);
  binc.sign = ~binc.sign;
  binc.float = -binc.float;
  return
  
 else % | a | < | b |, binc = | b | - | a |
  binc = p_minus_binf(binb,bina);
  return
  
 end % if isge
 
end % if siga



