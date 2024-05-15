function f_d_printfloatp(bin)
%F_D_PRINTFLOATP prints the fields of a binary floating point

% dependencies: f_d_bin2str, f_d_floapt2dec

%
% Author G. Meurant
% May 2020

[n,m] = size(bin);

if n == 1 && m == 1
 fprintf(' sign = %d \n',bin.sign)
 fprintf(' I = %s \n',f_d_bin2str(bin.I))
 fprintf(' F = %s \n',f_d_bin2str(bin.F))
 fprintf(' E = %g \n',bin.E)
 fprintf(' float = %12.5e \n',bin.float)
 fprintf(' nbits = %d \n\n',bin.nbits)

else
 fprintf('\n %d by %d array \n',n,m)
 f_d_floatp2dec(bin)
 
end % if
