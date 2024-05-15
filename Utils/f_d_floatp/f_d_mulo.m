function binc = f_d_mulo(bina,binb);
%F_D_MULO outer product of two vectors of binary floating point numbers

% Both inputs must have the same parameters (nbits and es). The result will also have
% the same parameters

% dependencies: f_d_mul

%
% Author G. Meurant
% May 2020
%

[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);

if cola ~= 1
 bina = bina';
end % if

if rowb ~= 1
 binb = binb';
end % if

% Create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:colb
  binc(i,j) = f_d_mul(bina(i),binb(j));
 end % for j
end % for i