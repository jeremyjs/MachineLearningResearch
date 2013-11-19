function [operation, parameter] = learncovwrapper(filename, from, to)

load(filename);
t=y(from:to);
x=x(from:to);
plot(t);
[operation, parameter]=learncov(x,t, '0', []);