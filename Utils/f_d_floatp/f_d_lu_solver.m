function binx=f_d_lu_solver(binb,L,U,p);
%F_D_LU_SOLVER linear solver for binary floating point

% L U binx = binb(p)

% binb is a vector

% dependencies: f_dec2floatp, f_d_div, f_d_dot, f_d_minus

%
% Author G. Meurant
% April 2020
%

nbits = binb(1).nbits;

binb = binb(p);

% solve L y = binb
n = size(L,1);

y = f_d_dec2floatp(zeros(n,1),nbits);
y(1) = f_d_div(binb(1), L(1,1));

for k = 2:n
 s = f_d_dot(L(k,1:k-1), y(1:k-1));
 y(k) = f_d_minus(binb(k), s); % L(k,k) = 1
end % for k

% solve of U binx = y
binx = f_d_dec2floatp(zeros(n,1),nbits);
binx(n) = f_d_div(y(n), U(n,n));

for k = n-1:-1:1
 s = f_d_dot(U(k,k+1:n), binx(k+1:n));
 binx(k) = f_d_div(f_d_minus(y(k), s), U(k,k));
end % for k

