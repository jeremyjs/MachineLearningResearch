function [ bic, newpar ] = BIC( x,t,op,par ) %bic,  newpar 
    delta = 0.0001;
    variance=0.05;
    
    op
    newpar=par;
    iteration=1;
    while iteration<1000
        grad=zeros(size(newpar));
        baseline = multigauss(t,gramcov(x,x,op,newpar,variance));    
        for i=1:numel(newpar)
            if isnan(newpar(i))
                grad(i)=0;
            else
                newpar(i)=newpar(i)+delta;
                grad(i) = (multigauss(t,gramcov(x,x,op,newpar,variance)) - baseline)/delta;
                newpar(i)=newpar(i)-delta;
            end
        end
        %grad = grad

        if iteration~=1
            beta = sum( grad(~isnan(grad)).^2 ) / sum( prevgrad(~isnan(prevgrad)).^2 );
            S = grad + beta*prevS;
        else
            S = grad;
        end

        
        %search for positive derivative
        Sunit = S / sqrt(sum( S(~isnan(S)).^2 ));
        upper=10*delta;
        lower=0;
        
        while multigauss(t,gramcov(x,x,op,newpar+(upper+delta)*Sunit,variance))-multigauss(t,gramcov(x,x,op,newpar+upper*Sunit,variance))>0
            upper=upper*10;
        end
        
        med = upper/2;
        while upper-lower>delta            
            if multigauss(t,gramcov(x,x,op,newpar+(med+delta)*Sunit,variance))-multigauss(t,gramcov(x,x,op,newpar+med*Sunit,variance))>0
                lower = med;
            else
                upper = med;
            end
            
            med = (upper + lower)/2;
        end
        
        newpar = newpar + med*Sunit;
        
        if sqrt(sum( (med*Sunit).^2 ))<delta*10
            break
        end
        
        prevgrad = grad;
       
        prevS = S;
        iteration=iteration+1;
        %%parameters = [parameters newpar];
        
    end
    ML = multigauss(t,gramcov(x,x,op,newpar,variance));
    bic = -2* log( ML ) + sum(~isnan(par(:)))*log(length(x));
    
    

end

