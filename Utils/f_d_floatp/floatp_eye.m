function binc = floatp_eye(nbits,n,m);
%FLOATP_EYE identity matrix of binary floating point numbers

% this is used in @floatp

% dependencies: floatp, diag

%
% Author G. Meurant
% May 2020
%

if nargin == 2
 one = floatp(ones(n,1),nbits);
 binc = diag(one);
 return
end % if

if n == m
 one = floatp(ones(n,1),nbits);
 binc = diag(one);
 return
end % if

if n > m
 one = floatp(ones(m,1),nbits);
 binc = diag(one);
 zero = floatp(zeros(n-m,m),nbits);
 binc = [binc; zero];
 return
 
else
 one = floatp(ones(n,1),nbits);
 binc = diag(one);
 zero = floatp(zeros(n,m-n),nbits);
 binc = [binc zero];
end % if

