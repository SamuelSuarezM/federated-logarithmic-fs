function binc = f_d_divm(bina,binb);
%F_D_DIVM componentwise division of two matrices of binary floating point numbers

% dependencies: f_d_div

%
% Author G. Meurant
% May 2020
%

[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);
if rowa ~= rowb || cola ~= colb
 error(' f_d_div: incompatible dimensions of inputs')
end % if

% create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:cola
  binc(i,j) = f_d_div(bina(i,j),binb(i,j));
 end % for j
end % for i

