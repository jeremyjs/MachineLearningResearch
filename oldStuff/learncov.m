function [operation, parameter] = learncov(x,t)

%%INPUTS
%%=========================
%x is a column vector of length n of data points
%t is a column vector of length n of target values
    period=periodic(t);


    operation='0';
    parameter=[];
    currentBIC=Inf;

    MaxLevel=10;
    level=0;
    while level<MaxLevel

        [operationCell,parameterCell] = genvars(operation,parameter,period); %generate variations

        bestParameters=[];
        bestIndex=0;
        minBIC = Inf;

        for i=1:length(operationCell)%find optimal operation
            [bic,newParameters] = BIC(x,t,operationCell{i},parameterCell{i}); %optimize parameters for operation and compute bic
            if bic<minBIC
                minBIC=bic;
                bestIndex=i;
                bestParameters=newParameters;
            end
        end

        if minBIC < currentBIC %if we are still improving the bic
            operation = operationCell{bestIndex};
            parameter = bestParameters;
            currentBIC=minBIC;
        else
            break
        end
        operation
        bestParameters
        minBIC
        X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
        X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

        logML = logmultigauss(t,gramcov(X1,X2,operation,bestParameters)); %maximum likelihood
        -2* logML
        sum(~isnan(bestParameters(:)))*log(length(x)) 

        level=level+1;
    end
    operation
    
   

end
