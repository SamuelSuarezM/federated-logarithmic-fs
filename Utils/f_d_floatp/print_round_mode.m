function print_round_mode
%PRINT_ROUND_MODE prints the rounding mode

%
% Author G. Meurant
% May 2020
%

global round_mode

if ~isempty(round_mode)
 switch round_mode
  case 1
   smode = '1, round to nearest';
  case 2
   smode = '2, round to +infinity';
  case 3
   smode = '3, round to -infinity';
  case 4
   smode = '4, round towards zero';
  case 5
   smode = '5, stochastic rounding (distance)';
  case 6
   smode = '6, stochastic rounding (equal probability)';
  otherwise
   smode = 'not valid';
 end % switch
 
 fprintf('    The rounding mode is %s \n',smode)
 
else
 fprintf('    The rounding mode is undefined, use f_d_init_round to define it \n')
 
end % if

