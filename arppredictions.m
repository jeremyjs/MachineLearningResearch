function [ predictions, SSE ] = arppredictions( a, p, winsize )
%still working on function
%   Detailed explanation goes here
    predictions=zeros(winsize-p, 1);
    amean=mean(a);
    a=a-amean;
    %alen=len(a);
    x=zeros(winsize-p:p);
    disp(x);
    y=zeros(winsize-p,1);
    disp(size(y));
    for i=p:winsize-1
        x(i-p+1,:)=a(i-p+1:i);
        y(i-p+1)=a(i+1);
    end
    disp(y);
    disp(x);
   xNew=a(winsize-p+1:winsize);
   disp('xnew');
   disp(xNew);
   coefficients=regress(y,x);
   pred=xNew*coefficients;
   
   predictions(1)=pred;
   
   
end

