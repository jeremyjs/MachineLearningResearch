%input an a set of x's and gcov option
%output synthetic y's based off of gcov opt
function [ y ] = gensyndata(x, kernel, param,variance)
    
X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    
X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

C = gramcov(X1,X2,kernel,param,variance); %set the covariance matrix

y=mvnrnd(zeros(size(x)),C)';
