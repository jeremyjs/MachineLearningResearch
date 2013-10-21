function [operation, parameter] = learncovwrapper(filename, from, to)

operation=1;
parameter=2;
load(filename);
t=y(from:to);
x=x(from:to);
%[operation, parameter]=learncov(x,t);