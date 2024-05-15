function [x,flag]=p_binf_inv_Newton(d);
%P_BINF_INV_NEWTON computation of binary fixed point 1/d by Newton iteration with normalization

%
% Author G. Meurant
% April 2020
%

flag = 0;
if (sum(d.I) + sum(d.F)) == 0
 % division by zero
 fprintf(' p_binf_inv_Newton: division by zero \n')
 flag = 1;
 x = d;
 return
end % if

nbits = d.nbits;
sig = d.sign;
% make the input positive
d.sign = 0;
d.float = abs(d.float);

[d0,mul] = normalized(d);
% fprintf(' mul = %d, d = %12.5e, mul*d0 = %12.5e \n',mul,p_binf2dec(d),mul*p_binf2dec(d0))
nitermax = 10;
% epsi = 1e-10;
epsi = max(2^(-nbits),1e-10);
epsi = epsi * 10;
method = 1;

one = p_dec2binf(1,nbits);

% initial approx: 48/17 - 32/17 * d0
c1 = p_dec2binf(48/17,nbits);
c2 = p_dec2binf(32/17,nbits);
x0 = p_minus_binf(c1,p_mul_binf(c2,d0)); % x0 = c1 - c2 * d0;

nit = 0;
while (nit <= nitermax)
 nit = nit + 1;
 %  x1 = x0 * (2 - d0 * x0);
 h = p_minus_binf(one,p_mul_binf(d0,x0)); % h = 1 - d0 * x0
 
 switch method
  case 1
   x1  = p_add_binf(x0,p_mul_binf(x0,h)); % x1 = x0 + x0 * h;
   
  case 2
   x1 = p_add_binf(x0,p_mul_binf(x0,p_add_binf(h,p_mul_binf(h,h)))); % x1 = x0 + x0 * (h + h^2);
   
  case 3
   h2 = p_mul(h,h);
   x1 = p_add_binf(x0,p_mul_binf(x0,p_add_binf(h,p_add_binf(h,h2)))); % x1 = x0 + x0 * (h + h^2 + h^3);
   
  case 4
   h2 = p_mul(h,h);
   x1 = p_add_binf(x0,p_mul_binf(x0,p_mul_binf(p_add_binf(one,h2),p_add_binf(h,h2)))); % x1 = x0 + x0 * (1 + h^2 ) * (h + h^2);
   
  otherwise
   error('p_binf_inv_Newton: method must be <= 4')
 end % switch
 
 if abs(p_binf2dec(x1) - p_binf2dec(x0)) / abs(p_binf2dec(x0)) < epsi
  break;
 end % if
 
 x0 = x1;

end % while

if nit > nitermax
 fprintf('\n p_binf_inv_Newton: no convergence after %d iterations, eps = %g \n',nitermax,epsi)
%  fprintf(' d = %24.10e, normalized d = %24.10e \n',p_posit2dec(d),p_posit2dec(d0))
 
%  inv2 = p_dec2binf(1/2,nbits);
%  x1 = p_mul_binf(inv2,p_add_binf(x0,x1));
 
else
 %  fprintf('p_binf_inv_Newton: number of iterations = %d \n',nit)
end % if

% fprintf(' final approx = %24.10e, true inverse = %24.10e, relative difference = %24.10e \n\n',p_binf2dec(x1),...
%   1/p_binf2dec(d0),abs(1/p_binf2dec(d0)-p_binf2dec(x1))/abs(1/p_binf2dec(d0)))

x = denormalized(x1,mul);
 
if nit > nitermax
 fprintf(' final inverse = %24.10e, true inverse = %24.10e, relative difference = %24.10e \n\n',p_binf2dec(x),...
  1/p_binf2dec(d),abs(1/p_binf2dec(d)-p_binf2dec(x))/abs(1/p_binf2dec(d)))
end % if

% put the sign back
x.sign = sig;
if sig == 1
 x.float = -x.float;
end % if


 function [d0,mul] = normalized(d)
  
  % normalize to 0.5 <= d <= 1
  
  inv2 = p_dec2binf(1/2,nbits);
  two = p_dec2binf(2,nbits);
  
  % divide d by power of 2
  mul = 1; % power of 2
  d0 = d;
  decd0 = p_binf2dec(d0);
  
  while decd0 > 1
   % divide by 2, will later divide by 2 again
   d0 = p_mul_binf(d0,inv2); % d0 = d0 / 2;
   mul = mul * 2;
   decd0 = p_binf2dec(d0);
  end % while
  
  while decd0 < 0.5
   d0 = p_mul_binf(d0,two); % d0 = d0 * 2;
   mul = mul / 2;
   decd0 = p_binf2dec(d0);
  end % while
  
 end % function

 function den = denormalized(invD0,mul)
  
  % reverse the normalization
  if mul >= 2
   type = 0; % positive power
   
  else
   type = 1;
  end % if
  
%   powm = p_pow2(mul,type); % mul is a power of 2
%   pmul = p_dec2binf(2^(-powm),nbits); % inverse of mul
  pmul = p_dec2binf(1/mul,nbits);
  den = p_mul_binf(invD0,pmul); % den = invD0 / mul;

 end % function

end % function p_binf_inv_Newton


