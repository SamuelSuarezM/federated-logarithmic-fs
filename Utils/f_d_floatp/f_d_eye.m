function binc = f_d_eye(nbits,n,m);
%F_D_EYE identity matrix of binary floating point numbers

% dependencies: f_d_dec2floatp, f_d_diag

%
% Author G. Meurant
% May 2020
%

if nargin == 2
 one = f_d_dec2floatp(ones(n,1),nbits);
 binc = f_d_diag(one);
 return
end % if

if n == m
 one = f_d_dec2floatp(ones(n,1),nbits);
 binc = f_d_diag(one);
 return
end % if

if n > m
 one = f_d_dec2floatp(ones(m,1),nbits);
 binc = f_d_diag(one);
 zero = f_d_dec2floatp(zeros(n-m,m),nbits);
 binc = [binc; zero];
 return
 
else
 one = f_d_dec2floatp(ones(n,1),nbits);
 binc = f_d_diag(one);
 zero = f_d_dec2floatp(zeros(n,m-n),nbits);
 binc = [binc zero];
end % if

