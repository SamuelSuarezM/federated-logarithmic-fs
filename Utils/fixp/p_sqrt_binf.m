function s=p_sqrt_binf(bina);
%P_SQRT_BINF square root of a binary fixed point number

% uses normalization of the input

% calculate sqrt(bina) for any bina >= 0


if bina.float == 0
 s = p_dec2binf(0,bina.nbits); %  zero binf
 return
end % if

if bina.sign == 1
 error(' p_sqrt_binf: negative numbers are not allowed')
end % if

nbits = bina.nbits;

nitermax = 10;
% epsi = 1e-10; % ???????????????
epsi = max(2^(-nbits),1e-10);
epsi = epsi * 10;

% normalize to 0.25 <= r <= 1
[r0,mul] = normalized(bina);

% calculate sqrt(r0), 0.25 <= r0 <= 1

% initial approximation: x0 = (2/3)r0 + 0.3506
c1 = p_dec2binf(2/3,nbits);
c2 = p_dec2binf(0.3506,nbits);
x0 = p_add_binf(p_mul_binf(c1,r0),c2);

inv2 = p_dec2binf(1/2,nbits);

nit = 0;
while (nit <= nitermax)
 nit = nit + 1;
 
 x1 = p_add_binf(p_mul_binf(x0,inv2), p_div_binf(p_mul_binf(r0,inv2),x0)); % x1 = x0 / 2 + r0 / (2 * x0)
 
 if ( abs(p_binf2dec(x1) - p_binf2dec(x0)) / p_binf2dec(x0) ) < epsi
  break
 end % if
 
 x0 = x1;
 
end % while

% denormalize: multiply x1 by mul
s = denormalized(x1,mul);


 function [r0,mul] = normalized(r)
  % normalize to 0.25 <= r <= 1.0
  
  % divide r by even power of 2
  mul = 1; % power of 2
  r0 = r;
  inv4 = p_dec2binf(1/4,nbits);
  four = p_dec2binf(4,nbits);
  
  while p_binf2dec(r0) > 1
   % divide by 4, will later multiply by 2
   r0 = p_mul_binf(r0,inv4); % division by 4
   mul = mul * 2;
  end % while
  
  while p_binf2dec(r0) < 0.25
   r0 = p_mul_binf(r0,four);
   mul = mul / 2;
  end % while
  
 end % function


 function sm = denormalized(sqrtr0,mul)
  % denorm: reverse the normalization
  mulp = p_dec2binf(mul,nbits);
  sm = p_mul_binf(sqrtr0,mulp);
  
 end % function


end % function p_sqrt_binf



