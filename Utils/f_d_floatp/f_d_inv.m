function binc=f_d_inv(bina);
%F_D_INV inverse of a binary floating point matrix

% dependencies: f_d_dec2floatp, f_d_div, f_d_lu_, f_d_lu_solver

%
% Author G. Meurant
% April 2020
%

[na,ma] = size(bina);

nbits = bina(1,1).nbits;

if na == 1 && ma == 1 % scallar, binc = 1 / bina
 one = f_d_dec2floatp(1,nbits);
 binc = f_d_div(one, bina);
 return
end % if

if na ~= ma
 error(' f_d_inv: the matrix must be square')
end % if

binb = f_d_eye(nbits,na,na);

binc = bina;

% L U factorization
[L,U,~,p] = f_d_lu(bina);

% L U solver
for k = 1:na
 binc(:,k) = f_d_lu_solver(binb(:,k),L,U,p);
end % for k

