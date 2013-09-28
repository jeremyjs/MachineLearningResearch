%input an a set of x's and gcov option
%output synthetic y's based off of gcov opt
function [ x,y ] = gensyndata(x, opt)

C = gcovexp(x,x,opt); %set the covariance matrix

y=mvnrnd(zeros(size(x)),C);
