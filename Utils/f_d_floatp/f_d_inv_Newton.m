function [x,flag]=f_d_inv_Newton(d);
%F_D_INV_NEWTON computation of binary floating point 1/d by Newton iteration with normalization

% dependencies: f_d_dec2floatp, f_d_floatp2dec, f_d_minus, f_d_mul, f_d_add

%
% Author G. Meurant
% May 2020
%

flag = 0;
if (sum(d.I) + sum(d.F)) == 0
 % division by zero
 fprintf(' f_d_inv_Newton: division by zero \n')
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
nitermax = 20;
epsi = 10 * max(2^(-nbits),1e-30);
method = 1;

one = f_d_dec2floatp(1,nbits);

% initial approx: 48/17 - 32/17 * d0
c1 = f_d_dec2floatp(48/17,nbits);
c2 = f_d_dec2floatp(32/17,nbits);
x0 = f_d_minus(c1,f_d_mul(c2,d0)); % x0 = c1 - c2 * d0;

nit = 0;
while nit <= nitermax % Newton iterations
 nit = nit + 1;
 %  x1 = x0 * (2 - d0 * x0);
 h = f_d_minus(one,f_d_mul(d0,x0)); % h = 1 - d0 * x0
 
 switch method
  case 1
   x1  = f_d_add(x0,f_d_mul(x0,h)); % x1 = x0 + x0 * h;
   
  case 2
   x1 = f_d_add(x0,f_d_mul(x0,f_d_add(h,f_d_mul(h,h)))); % x1 = x0 + x0 * (h + h^2);
   
  case 3
   h2 = f_d_mul(h,h);
   x1 = f_d_add(x0,f_d_mul(x0,f_d_add(h,f_d_add(h,h2)))); % x1 = x0 + x0 * (h + h^2 + h^3);
   
  case 4
   h2 = f_d_mul(h,h);
   x1 = f_d_add(x0,f_d_mul(x0,f_d_mul(f_d_add(one,h2),f_d_add(h,h2)))); % x1 = x0 + x0 * (1 + h^2 ) * (h + h^2);
   
  otherwise
   error('f_d_inv_Newton: method must be <= 4')
 end % switch
 
 if abs(f_d_floatp2dec(f_d_minusm(x1,x0))) / abs(f_d_floatp2dec(x0)) < epsi
  break;
 end % if
 
 x0 = x1;
 
end % while

if nit > nitermax
 fprintf('\n f_d_inv_Newton: no convergence after %d iterations, eps = %g \n',nitermax+1,epsi)
 
else
 %   fprintf('f_d_inv_Newton: number of iterations = %d \n',nit)
end % if

% fprintf(' final approx = %24.10e, true inverse = %24.10e, relative difference = %24.10e \n\n',f_d_floatp2dec(x1),...
%   1/f_d_floatp2dec(d0),abs(1/f_d_floatp2dec(d0)-f_d_floatp2dec(x1))/abs(1/f_d_floatp2dec(d0)))

x = denormalized(x1,mul);

if nit > nitermax
 %  fprintf(' final inverse = %24.10e, true inverse = %24.10e, relative difference = %24.10e \n\n',f_d_floatp2dec(x),...
 %   1/f_d_floatp2dec(d),abs(1/f_d_floatp2dec(d)-f_d_floatp2dec(x))/abs(1/f_d_floatp2dec(d)))
end % if

% put the sign back
x.sign = sig;
if sig == 1
 x.float = -x.float;
end % if


 function [d0,mul] = normalized(d)
  
  % normalize to 0.5 <= d <= 1
  
  inv2 = f_d_dec2floatp(1/2,nbits);
  two = f_d_dec2floatp(2,nbits);
  
  % divide d by power of 2
  mul = 1; % power of 2
  d0 = d;
  decd0 = f_d_floatp2dec(d0);
  
  while decd0 > 1
   % divide by 2, will later divide by 2 again
   d0 = f_d_mul(d0,inv2); % d0 = d0 / 2;
   mul = mul * 2;
   decd0 = f_d_floatp2dec(d0);
  end % while
  
  while decd0 < 0.5
   d0 = f_d_mul(d0,two); % d0 = d0 * 2;
   mul = mul / 2;
   decd0 = f_d_floatp2dec(d0);
  end % while
  
 end % function

 function den = denormalized(invD0,mul)
  
  % reverse the normalization
  %   if mul >= 2
  %    type = 0; % positive power
  %
  %   else
  %    type = 1;
  %   end % if
  
  %   powm = pow2(mul,type); % mul is a power of 2
  %   pmul = f_d_dec2floatp(2^(-powm),nbits); % inverse of mul
  pmul = f_d_dec2floatp(1/mul,nbits);
  den = f_d_mul(invD0,pmul); % den = invD0 / mul;
  
 end % function

end % function binf_d_inv_Newton


