function [L,U,P,p] = f_d_lu(A);
%F_D_LU triangular factorization, floating point numbers

% [L,U,P] = f_d_lu(A) produces a unit lower triangular matrix L, an upper triangular matrix U, 
%  and a permutation vector p, so that L * U = P * A

% p is the permutation vector, P is the equivalent permutation matrix

% dependencies: f_d_floatp2dec, f_d_divms, f_d_minusm, f_d_mulo, f_d_eye, f_d_addm, f_d_triu

[n,n] = size(A);
p = (1:n)';

nbits = A.nbits;

for k = 1:n-1
 
 % find index of largest element below diagonal in k-th column
 [r,m] = max(abs(f_d_floatp2dec(A(k:n,k)))); 
 m = m + k - 1;
 
 % skip elimination if column is zero
 if f_d_floatp2dec(A(m,k)) ~= 0
  
  % swap pivot row
  if m ~= k
   A([k m],:) = A([m k],:);
   p([k m]) = p([m k]);
  end
  
  % compute multipliers
  i = k+1:n;
  A(i,k) = f_d_divms(A(i,k), A(k,k)); % division of a vector by a scalar
  
  % update the remainder of the matrix
  j = k+1:n;
  A(i,j) = f_d_minusm(A(i,j), f_d_mulo(A(i,k), A(k,j))); % subtraction of an outer product
 end % if
end % for k

% separate result
I = f_d_eye(nbits,n);
L = f_d_addm(tril(A,-1), I); 
U = f_d_triu(A);

% construct P 
P = I(:,p);


