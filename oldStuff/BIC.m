function [ bestBIC, bestParameters ] = BIC( x,t,operation,parameters )
    delta = 0.0001;

    parameters;
    stack = zeros(length(x),length(x),10);
    
    counts = [0, 0.01*2.^(0:9)];
    X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

    %X1=x;
    %X2=x;
    %bestParameters;
    bestBIC=Inf;
    bestIteration=Inf;
    for randtry=1:10
        
        
        newpar = parameters + (2*rand(size(parameters))-1);
        while logmultigauss(t,gramcov(X1,X2,operation,newpar))==-Inf
            newpar = parameters + (2*rand(size(parameters))-1);
           
           
        end
    %newpar=parameters;
    iteration=1;
    maxIndList=[];
    while iteration<1000 %absolute cutoff on number of iterations of 1000
        gradient=zeros(size(newpar));
        baseline = logmultigauss(t,gramcov(X1,X2,operation,newpar));    
        for i=1:numel(newpar)
            if isnan(newpar(i))
                gradient(i)=0;
            else
                newpar(i)=newpar(i)+delta;
                gradient(i) = (logmultigauss(t,gramcov(X1,X2,operation,newpar)) - baseline)/delta;
                newpar(i)=newpar(i)-delta;
            end
        end
        
        if sum( gradient(~isnan(gradient)).^2)==0 %if gradient is zero, break
            1
            break
        end

        if iteration~=1
            beta = sum( gradient(~isnan(gradient)).^2) / sum( prevgrad(~isnan(prevgrad)).^2);
            S = gradient + beta*prevS; %defined in wikipedia article on conjugate gradients
        else
            S = gradient;
        end
        %S=gradient;

        
        %search for positive derivative
        Smag = sqrt(sum( S(~isnan(S)).^2 ));
        if Smag==0
            break
        end
        Sunit = S / Smag; %normalize S to make optimization less complicated

        Sunit;
        value=zeros(size(counts));
        %%counts=(0:0.01:3);
        for c=1:length(counts)
            value(c) = logmultigauss(t,gramcov(X1,X2,operation,newpar+counts(c)*Sunit));
        end
        [~,maxInd] = max(value);
        
        if maxInd==1
            break
        else
            maxInd;
            newpar = newpar + counts(maxInd)*Sunit;
            maxIndList=[maxIndList, maxInd];
        end
        
        %{

        upper=10*delta;
        lower=0;
        
        %increase upper exponentially until derivative is negative
        while logmultigauss(t,gramcov(x,x,operation,newpar+(upper+delta)*Sunit))-logmultigauss(t,gramcov(x,x,operation,newpar+upper*Sunit))>0
            upper=upper*10;
        end
        
        %use bisection method to find when derivative is 0
        med = upper/2;
        while upper-lower>delta            
            if logmultigauss(t,gramcov(x,x,operation,newpar+(med+delta)*Sunit))-logmultigauss(t,gramcov(x,x,operation,newpar+med*Sunit))>0
                lower = med;
            else
                upper = med;
            end
            
            med = (upper + lower)/2;
        end
        
        newpar = newpar + med*Sunit;
        
        %stop iterating if change in newpar is sufficiently small
        if sqrt(sum( (med*Sunit).^2 ))<delta*2
            break
        end
        %}
        prevgrad = gradient;
        prevS = S;
        iteration=iteration+1;
        
    end
    logML = logmultigauss(t,gramcov(X1,X2,operation,newpar)); %maximum likelihood
    bic = -2* logML + sum(~isnan(parameters(:)))*log(length(x)); 
    iteration;
    if (bic<bestBIC)
        bestBIC=bic;
        bestParameters=newpar;
    end
    %if iteration>50
    %    operation
    %    newpar
    %end
    
    end
    operation;

end

