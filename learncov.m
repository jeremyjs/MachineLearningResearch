function [operation, parameter] = learncov(x,t)
    exit;
%%INPUTS
%%=========================
%x is a column vector of length n of data points
%t is a column vector of length n of target values

    operation='0';
    parameter=[];
    currentBIC=Inf;

    while 1

        [operationCell,parameterCell] = genvars(operation,parameter); %generate variations

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
    end
    operation
   
exit;
end
