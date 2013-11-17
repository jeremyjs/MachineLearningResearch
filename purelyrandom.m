function [ predictions, SSE ] = purelyrandom( a, winsize )
%a is an Nx1 vector. These are our y values
%set winsize so that you get N-winsize predictions
    a=a';
    N=length(a);
    predsize=N-winsize;
    amean=mean(a);
    %a=a-amean;
    predictions=zeros(predsize, 1);
    for k=0:predsize-1
       
        predictions(k+1)=a(winsize+k);
    end
    SSE=sum((predictions-a(winsize+1:N)').^2);
end

