function binc=f_d_triu(bina,k);
%F_D_TRIU upper triangular part of a binary floating point matrix

% dependencies: f_d_dec2floatp

%
% Author G. Meurant
% April 2020
%

if nargin == 1
 k = 0;
end % if

binc = bina;

nbits = bina.nbits;

[na,ma] = size(bina);

B = triu(ones(na,ma),k) == 0;

binc(B) = f_d_dec2floatp(0,nbits);

