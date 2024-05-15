function s=f_d_sqrt(bina);
%F_D_SQRT square root of a binary floating point number

% uses normalization of the input

% calculate sqrt(bina) for any bina >= 0

% dependencies: f_d_dec2floatp, f_d_add, f_d_mul

%
% Author G. Meurant
% May 2020
%

if bina.float == 0
 s = f_d_dec2floatp(0,bina.nbits); %  zero binfl
 return
end % if

if bina.sign == 1
 error(' f_d_sqrt: negative numbers are not allowed')
end % if

nbits = bina.nbits;

nitermax = 10;
epsi = 1e-10; % this is not enough when nbits is large.....................
% epsi =10 * max(2^(-nbits),1e-30); % this is better but more expensive

% normalize to 0.25 <= r <= 1
[r0,mul] = normalized(bina);

% calculate sqrt(r0), 0.25 <= r0 <= 1

% initial approximation: x0 = (2/3)r0 + 0.3506
c1 = f_d_dec2floatp(2/3,nbits);
c2 = f_d_dec2floatp(0.3506,nbits);
x0 = f_d_add(f_d_mul(c1,r0),c2);

inv2 = f_d_dec2floatp(1/2,nbits);

nit = 0;
while (nit <= nitermax)
 nit = nit + 1;
 
 x1 = f_d_add(f_d_mul(x0,inv2), f_d_div(f_d_mul(r0,inv2),x0)); % x1 = x0 / 2 + r0 / (2 * x0)
 
 if ( abs(f_d_floatp2dec(x1) - f_d_floatp2dec(x0)) / f_d_floatp2dec(x0) ) < epsi
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
  inv4 = f_d_dec2floatp(1/4,nbits);
  four = f_d_dec2floatp(4,nbits);
  
  while f_d_floatp2dec(r0) > 1
   % divide by 4, will later multiply by 2
   r0 = f_d_mul(r0,inv4); % division by 4
   mul = mul * 2;
  end % while
  
  while f_d_floatp2dec(r0) < 0.25
   r0 = f_d_mul(r0,four);
   mul = mul / 2;
  end % while
  
 end % function


 function sm = denormalized(sqrtr0,mul)
  % denorm: reverse the normalization
  mulp = f_d_dec2floatp(mul,nbits);
  sm = f_d_mul(sqrtr0,mulp);
  
 end % function


end % function f_d_sqrt



