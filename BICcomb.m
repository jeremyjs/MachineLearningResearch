function [ bic, newpar ] = BICcomb( x,t,operation,parameters )
    
    paramIndices = find(~isnan(parameters));
    
    newpar = parameters;
    
    for iteration=1:3
        for j=(1:length(paramIndices))
            paramIndex = paramIndices(j);
            paramBase = zeros(size(newpar));
            paramBase(paramIndex)=1;
            
            top = 2*newpar(paramIndex);
            bottom = 0.001;
            
            while (top-bottom)>0.001
                tryX = (0:0.01:1)*(top-bottom) + bottom;
                tryT = zeros(size(tryX));
                for tryInd=1:length(tryX)
                    tryT(tryInd) = logmultigauss(t,gramcov(x,x,operation,newpar+paramBase*( tryX(tryInd)-newpar(paramIndex) )));
                end
                [~,maxInd] = max(tryT);
                if (maxInd==1)
                    maxInd = 2;
                end
                if maxInd==length(tryX)
                    maxInd = length(tryX)-1;
                end
                top=tryX(maxInd+1);
                bottom=tryX(maxInd-1);
            end
            
            newpar = newpar + paramBase*((top+bottom)/2 -newpar(paramIndex));
        end
    end
        
    logML = logmultigauss(t,gramcov(x,x,operation,newpar)); %maximum likelihood
    bic = -2* logML + sum(~isnan(parameters(:)))*log(length(x)); 
    

end

