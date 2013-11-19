function [kernel, param,variance] = learncov(x,y,kernel,param)
    addpath('C:\Users\Steve\Documents\GitHub\MachineLearningResearch\gpml-matlab-v3.4-2013-11-11\util');

%%INPUTS
%%=========================
%x is a column vector of length n of data points
%t is a column vector of length n of target values
    var=0.1;
    len=2;
    center=0;
    period=periodic(y);
    %period=5;

    initials = [var,len,NaN; var,1,period; var,var,center; var,len,1]';
    initialVariance = var;
    
    X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

    %kernel='0';
    %param=[];
    currentBIC=Inf;
    variance=initialVariance;

    MaxLevel=10;
    level=0;
    while level<MaxLevel

        [kernelCell,paramCell] = genvars(kernel,param,initials); %generate variations

        bestParam=[];
        bestIndex=0;
        minBIC = Inf;

        for i=1:length(kernelCell)%find optimal operation
            initialVector = toVector( paramCell{i}, variance );
            kernelCell{i};
            
            f = @(vector)computeBIC(X1,X2,y,kernelCell{i},vector);
            [newVector,bic] = minimizeWrapper(initialVector,f); %optimize parameters for operation and compute bic

            
            
            if bic<minBIC
                minBIC=bic;
                bestIndex=i;
                [bestParam,bestVar]=fromVector(newVector,kernelCell{i});
                
            end
            
        end

        if minBIC < currentBIC %if we are still improving the bic
            kernel = kernelCell{bestIndex};
            param = bestParam;
            currentBIC=minBIC;
            variance = bestVar;
        else
            break
        end
        kernel;
        param;
        currentBIC;
        variance;

        level=level+1;
    end
        kernel;
        param;
        currentBIC;
        variance;
    'FINISHED';
    
   

end
