function [p,cnext]=f_d_round_bin_old(bin,nbits,sig);
%F_D_ROUND_BIN round the binary number bin to nbits

% round_mode = 1, round to nearest
%            = 2, round to + infty
%            = 3, round to - intfy
%            = 4, round to zero
%            = 5, stochastic rounding (distance)
%            = 6, stochastic rounding (equal probability)

% dependencies: f_d_add_bin_one_carry

%
% Author G. Meurant
% May 2020
%

global round_mode

if isempty(round_mode)
 round_mode = 1;
end % if

flipbit = 0;
flipprob = 0.5;

if flipbit == 1 && rand > (1 - flipprob)
 % we flip one bit randomly to simulate hardware failures
 k = randi(length(bin));
 bin(k) = ~bin(k);
end % if

% no rounding to do

len = length(bin);
if len <= nbits
 % do nothing
 p = bin;
 cnext = 0;
 return
end % if

switch round_mode 
 
 case 1
 
 % round to nearest
 
 bint = bin(1:nbits);
 binr = bin(nbits+1:len);
 
 % we need at least 3 bits in binr to do the rounding to nearest
 if length(binr) < 3
  % pad with zeros
  binr = [binr zeros(1, 3 - length(binr))];
 end % if
 
 g = binr(1);
 r = binr(2); % next bit
 s = any(binr(3:end)); % sticky bit 
 
 if g == 0
  % the last bit is zero, do nothing
  p = bint;
  cnext = 0;
  return
 end % if
 
 if r == 0 && s == 0 % tie
  % add 1 to bint if last bit = 1
  if bint(nbits) == 1
   [p,cnext] = f_d_add_bin_one_carry(bint(1:nbits)); 
   return
  else
   p = bint;
   cnext = 0;
   return
  end % if
  
 else
  % (0, 1), (1,0) and (1, 1), round up
  [p,cnext] = f_d_add_bin_one_carry(bint(1:nbits));
  return
  
 end % if r
 

 case 2
 
 % round to + infty
 
 if sig == 1
  
  p = bin(1:nbits); % chop
  cnext = 0;
  return
  
 else
  [p,cnext] = f_d_add_bin_one_carry(bin(1:nbits));
  return
  
 end % if
 

 case 3
 
 % round to - infty
 
 if sig == 0
  
  p = bin(1:nbits); % chop
  cnext = 0;
  return
  
 else
  [p,cnext] = f_d_add_bin_one_carry(bin(1:nbits));
  return
  
 end % if
 

 case 4

 % round to zero
 
 p = bin(1:nbits); % chop
 cnext = 0;
 return
 
 case 5
 
 % stochastic rounding, probability proportional to the distance
 
 dec = f_d_bin2frac(bin); 
 r = rand;
 if r <= dec
  if sig == 0
   p = bin(1:nbits); % chop
   cnext = 0;
   return
  else
   [p,cnext] = f_d_add_bin_one_carry(bin(1:nbits));
   return
  end % if sig
  
 else % r > dec
  if sig == 1
   p = bin(1:nbits); % chop
   cnext = 0;
   return
   
  else
   [p,cnext] = f_d_add_bin_one_carry(bin(1:nbits));
   return
  end % if sig
  
 end % if r

 case 6
 
 % stochastic rounding, equal probability
 
 r = rand;
 if r <= 0.5
  if sig == 0
   p = bin(1:nbits); % chop
   cnext = 0;
   return
  else
   [p,cnext] = f_d_add_bin_one_carry(bin(1:nbits));
   return
  end % if sig
  
 else % r > 0.5
  if sig == 1
   p = bin(1:nbits); % chop
   cnext = 0;
   return
   
  else
   [p,cnext] = f_d_add_bin_one_carry(bin(1:nbits));
   return
  end % if sig
  
 end % if r
 

 otherwise
  
  error(' f_d_round_bin: unsupported rounding mode')
 
end % switch



