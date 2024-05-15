function f_d_init_round(rounding);
%F_D_INIT_ROUND initializes the rounding mode

% rounding   = 1, round to nearest
%            = 2, round to + infty
%            = 3, round to - intfy
%            = 4, round to zero
%            = 5, stochastic rounding with probability proportional to the distance
%            = 6, stochastic rounding with equal probability

% no dependencies

%
% Author G. Meurant
% May 2020
%

global round_mode

if isempty(rounding)
 round_mode = [];
 return
end % if

if rounding > 6 || ~isfloat(rounding)
 error(' f_d_init_round: the rounding mode must be an integer <= 6')
end % if

round_mode = rounding;

