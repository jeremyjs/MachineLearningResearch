function [ predictions, SSE ] = arppredictions( a, p, winsize )
%a is an Nx1 vector. These are our y values
%p is p in AR(p)
%set winsize so that you get N-winsize predictions
    a=a';
    N=length(a);
    predsize=N-winsize;
    amean=mean(a);
    a=a-amean;
    predictions=zeros(predsize, 1);
    for k=0:predsize-1
        x=zeros(winsize-p:p);
        disp(x);
        y=zeros(winsize-p,1);
        %disp(size(y));
        for i=p+k:winsize-1+k
            x(i-p+1-k,:)=a(i-p+1:i);
            y(i-p+1-k)=a(i+1);
        end
        %disp('y');
        %disp(y);
        %disp('x');
        %disp(x);
        xNew=a(winsize-p+1+k:winsize+k);
        coefficients=regress(y,x);
        pred=xNew*coefficients;  
        predictions(k+1)=pred+amean;
    end
    
    %subtract and add back the mean
    a=a+amean;
   SSE=sum((predictions-a(winsize+1:N)').^2);
end

