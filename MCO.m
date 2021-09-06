function [b] = MCO(X,y)
%---------------------------------------------------------------
% Proposito : Estimación de parámetros por MCO
%---------------------------------------------------------------
% Imputs    : X  : Kx1 variable independiente
%             y  : Kx1 variable dependiente
%---------------------------------------------------------------
% Outputs   : b  : vector de parametros
%---------------------------------------------------------------

b = (X_'*X_)\X_'*y;

end