function [ BIC ] = computeBIC( X1, X2, y, kernel, vector )
    [param,variance] = fromVector(vector,kernel);    

    C = gramcov(X1,X2,kernel,param,variance);
    if (isnan(C))
        BIC=realmax;
        return;
    end
    logML = logmultigauss(y,C); %maximum likelihood
    BIC = -2* logML + length(vector)*log(size(X1,1));

end