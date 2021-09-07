function [betas] = fallossupuestos(beta,n,iter,sup)

%--------------------------------------------------------------
% Proposito : Mostrar los efectos que tienen los fallos de los
%             supuestos sobre la distribucion del estimador OLS
%             de beta.
%--------------------------------------------------------------
% Insumos   : beta  : 2x1 vector de parametros poblacionales
%                n  : 1x1 tamaño de la muestra
%              iter : 1x1 numero de iteraciones a mostrar
%               sup : 1x1 supuesto que se viola donde:
%                         0 = No falla ningun supuesto
%                         1 = Linealidad
%                         2 = Exogeneidad estricta (error con
%                             media diferente de cero)
%                         3 = Exogeneidad estricta (regresores
%                             y error no ortogonales)
%                         4 = Errores esfericos (heteroscedesticidad)
%--------------------------------------------------------------
% Output    : betas : iterxK vector de parametros en toas las
%                     iteraciones.
%--------------------------------------------------------------

K = size(beta,1)-1;
X = 100*randn(n,K);
X = [ones(n,1), X];

% Estableciendo valores

sigma   = 10;
mu      = 2;
gamma1  = 0.75;

if sup == 0
    betas = zeros(iter,K+1);
    for i=1:iter
        epsilon    = randn(n,1);
        y          = X*beta + epsilon;
        beta_hat   = (X'*X)^(-1)*X'*y;
        betas(i,:) = beta_hat';
    end


elseif sup == 1
    betas = zeros(iter,K+1);
    for i=1:iter
        epsilon    = randn(n,1);
        y          = (X(:,1).*beta(1,1)).*(X(:,2).*beta(2,1)) + epsilon;
        beta_hat   = (X'*X)^(-1)*X'*y;
        betas(i,:) = beta_hat';
    end
    
elseif sup == 2
    betas = zeros(iter,K+1);
    for i=1:iter
        epsilon    = mu + sigma*randn(N,1);    
        y          = X*beta + epsilon;
        beta_hat   = (X'*X)^(-1)*X'*y;
        betas(i,:) = beta_hat';
    end
elseif supuesto == 3
    betas = zeros(iter,K+1);
    for i=1:iter
        M       = mu + sigma*randn(N,2);
        R       = [1 gamma1; gamma1 1];
        L       = chol(R);
        M       = M*L;
        X(:,2)  = M(:,1); 
        epsilon = M(:,2);
        y          = X*beta + epsilon;
        beta_hat   = (X'*X)^(-1)*X'*y;
        betas(i,:) = beta_hat';
    end
elseif supuesto == 4
    betas = zeros(iter,K+1);
    MU = zeros(N,1);
    V  = eye(N);
    for j=1:N
        V(j,j) = j;
    end 
    for i=1:iter
        epsilon    =mvnrnd(MU,V,1)'; 
        y          = X*beta + epsilon;
        beta_hat   = (X'*X)^(-1)*X'*y;
        betas(i,:) = beta_hat';
    end
else
     error('supuesto solo puedo tomar los valores {0,1,2,3,4}')
end 


figure(1)
subplot(2,2,1)
hist(betas(:,1),80), hold on
plot(beta(1), betas(:,1),'r'), ylim([0 0.05*iter]), title({'Distribución \beta_0'}), hold off


subplot(2,2,2)
hist(betas(:,2),80), hold on
plot(beta(2), betas(:,2),'r'), ylim([0 0.05*iter]),  title({'Distribución \beta_1'}),  hold off
suptitle('Distribución de los Parámetros Estimados por MCO') 


end 

