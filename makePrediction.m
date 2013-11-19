function [ tpred ] = makePrediction( x,t,xpred,opt,param)

%x is the set the training data independent values in a column vector
%t is the set the training data dependent values in a column vector
%xpred is the set the testing data independent values in a column vector
    
X1 = repmat(x,[1 length(x)]);
X2 = repmat(x',[length(x) 1]);

X3 = repmat(x',[length(xpred) 1]);
X4 = repmat(xpred,[1 length(x)]);

%%this is k*C^-1*t but where k is expanded
tpred = gramcov(X4,X3,opt,param) * gramcov(X1,X2,opt,param)^-1 * t; %calculate the predicted t values