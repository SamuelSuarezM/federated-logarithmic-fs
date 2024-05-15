function binc=f_d_diag(bina,k);
%F_D_DIAG diagonal function for a binary floating point matrix or vector

% dependencies: f_d_dec2floatp
%
% Author G. Meurant
% May 2020
%

nbits = bina.nbits;

[na,ma] = size(bina);

if nargin == 1
 k = 0;
end % if

if na ~= 1 && ma ~= 1
 % extract a diagonal
 B = diag(diag(ones(na,ma),k),k) == 1;
 binc = bina(B);
 return
end % if

% if bina is a vector construct a matrix from it
if na == 1
 bina = bina';
end % if

lbina = length(bina);
n = lbina + abs(k); % order of the (square) matrix
binc  = f_d_dec2floatp(zeros(n,n),nbits); % create a zero matrix of order n
B = diag(diag(ones(n,n),k),k) == 1;
binc(B) = bina;






