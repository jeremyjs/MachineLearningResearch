function [ tpred ] = makePrediction( x,t,xpred,opt,param)

%x is the set the training data independent values in a column vector
%t is the set the training data dependent values in a column vector
%xpred is the set the testing data independent values in a column vector

%%this is k*C^-1*t but where k is expanded
tpred = gramcov(xpred,x,opt,param) * gramcov(x,x,opt,param)^-1 * t; %calculate the predicted t values