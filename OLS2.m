function [b R2] = OLS2(X,y,c)

%----------------------------------------------------------
% Proposito : Hace la estimacion de los parametros por OLS
%----------------------------------------------------------
% Insumos   : X  : nxK matriz de variables independientes (sin constantes)
%             y  : nx1 vector de variable dependiente
%             c  : 1x1 : 1 si hay constante en el modelo
%                       0 si no hay constante en el modelo
%----------------------------------------------------------
% Output    : b  : Kx1 vector de parametros
%             R2 : 1x1 coeficiente de determinación
%----------------------------------------------------------

if nargin < 3
    % Asumo que en el X no hay constante (y que c = 1)
    % y se agrega una columna de unos.
    X = [ones(size(X,1),1) X];
    b = (X'*X)^(-1)*X'*y;
    % Coeficiente de determinacion
    n = size(y,1); % tamaño muestra (nº filas matriz y)
    Aux1 = X*b-((1/n)*sum(y));
    Aux2 = Aux1'*Aux1;
    Aux3 = y - ((1/n)*sum(y));
    Aux4 = Aux3'*Aux3;
    R2 = Aux2/Aux4;
else
    if c == 1
        X = [ones(size(X,1),1) X];
        b = (X'*X)^(-1)*X'*y;
        % Coeficiente de determinacion
        n = size(y,1); % tamaño muestra (nº filas matriz y)
        Aux1 = X*b-((1/n)*sum(y));
        Aux2 = Aux1'*Aux1;
        Aux3 = y - ((1/n)*sum(y));
        Aux4 = Aux3'*Aux3;
        R2 = Aux2/Aux4;
    elseif c == 0
        b = (X'*X)^(-1)*X'*y;
        % Coficiente de determinacion no centrado
        n = size(y,1);
        yhat = X*b;
        R2 = (yhat'*yhat)/(y'*y);
    else
        error('c solo puede tomar valores {0,1}')
    end
end

end

        