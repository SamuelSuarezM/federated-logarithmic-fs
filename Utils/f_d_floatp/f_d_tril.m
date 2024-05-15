function binc=f_d_tril(bina,k);
%F_D_TRIL lower triangular part of a binary floating point matrix

% dependencies: f_d_dec2floatp

%
% Author G. Meurant
% May 2020
%

if nargin == 1
 k = 0;
end % if

binc = bina;

nbits = bina.nbits;

[na,ma] = size(bina);

B = tril(ones(na,ma),k) == 0;

binc(B) = f_d_dec2floatp(0,nbits);

