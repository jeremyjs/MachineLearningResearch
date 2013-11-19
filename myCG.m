function [ minX, minF ] = myCG( vector, f )
    delta = 0.0001;


    counts = [0, 0.01*2.^(0:9)];

    minF=Inf;

    
    for randtry=1:10
        
        
        newpar = vector + (2*rand(size(vector))-1);
        while f(newpar)==realmax;
            newpar = vector + (2*rand(size(vector))-1);
           
           
        end
    %newpar=parameters;
    iteration=1;
    while iteration<1000 %absolute cutoff on number of iterations of 1000
        gradient=computeGradient(f,newpar,delta);
        
        if sum( gradient.^2)==0 %if gradient is zero, break
            break
        end

        if iteration~=1
            beta = sum( gradient.^2) / sum( prevgrad.^2);
            S = gradient + beta*prevS; %defined in wikipedia article on conjugate gradients
        else
            S = gradient;
        end
        %S=gradient;

        
        %search for positive derivative
        Smag = sqrt(sum( S.^2 ));
        if Smag==0
            break
        end
        Sunit = S / Smag; %normalize S to make optimization less complicated

        Sunit;
        value=zeros(size(counts));
        %%counts=(0:0.01:3);
        for c=1:length(counts)
            value(c) = f(newpar+counts(c)*Sunit);
        end
        [~,minInd] = min(value);
        
        if minInd==1
            break
        else
            newpar = newpar + counts(minInd)*Sunit;
        end
        
        prevgrad = gradient;
        prevS = S;
        iteration=iteration+1;
        
    end
    fVal = f(newpar);
    if (fVal<minF)
        minF=fVal;
        minX=newpar;
    end

    
    end

end

