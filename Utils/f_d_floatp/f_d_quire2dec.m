function dec=f_d_quire2dec(q);
%F_D_QUIRE2DEC converts a quire to decimal

% dependencies: f_d_bin2dec,f_d_bin2frac

%
% Author G. Meurant
% May 2020
%

I = q.I;
C = q.C;
F = q.F;
sig = q.sign;

I = [C I];
ind = find(I);
if ~isempty(ind)
 integ = f_d_bin2dec(I(ind(1):end));
else
 integ = 0;
end % if

FF = fliplr(F);
ind = find(FF);
if ~isempty(ind)
 F = fliplr(FF(ind(1):end));
 frac = f_d_bin2frac(F);
else
 frac = 0;
end % if

dec = integ + frac;

if sig == 1
 dec = -dec;
end % if

