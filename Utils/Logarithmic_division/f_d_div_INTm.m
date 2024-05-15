function binc = f_d_div_INTm(bina,binb)
%DIV_INT logarithmic division of binary integer fixed point numbers matrix diva / divb
% 
% 
[rowa,cola] = size(bina); % number of rows and columns
[rowb,colb] = size(binb);
if rowb ~= 1 || colb ~= 1
 error(' div_binfms: binb must be a scalar')
end % if

% Create a binary element and set its parameters
binc = bina;

for i = 1:rowa
 for j = 1:cola
  [binc(i,j),~] = f_d_div_INT(bina(i,j),binb);
 end % for j
end % for i