function [ predictions, SSE ] = arwrapper(filename, from, to, windowradius, p)
load(filename);
t=y(from:to);
x=x(from:to);
winsize=2*windowradius+1;
[predictions, SSE]=arppredictions( t, p, winsize );

end