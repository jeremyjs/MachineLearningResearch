function [predictions, ARpredictions, xs, t1,t2, SSEours, ARSSE, SSEbad, opt, param, variance] = runPredstrainonce(filename, from, to, windowradius, p)
load(filename);
t=y(from:to);
x=x(from:to);
predictions=zeros(windowradius*2+1,1);
windowsize=2*windowradius+1;

    predIndex=(windowsize+1);
    tuse = t( (predIndex-windowsize) : (predIndex-1) );
    disp('tuselen');
    disp(length(tuse));
    avg = mean(tuse);
    %%x( (predIndex-windowsize):(predIndex-1) )
    tic;
    [opt,param,variance] = learncov( (-windowradius:windowradius)', tuse-avg, '0', []);
    toc;

    
    for predIndex=(windowsize+1):length(t)
        %predIndex
        tuse = t( (predIndex-windowsize) : (predIndex-1) );
        avg = mean(tuse);
        %%x( (predIndex-windowsize):(predIndex-1) )
        %[opt,param,variance] = learncov( (-windowradius:windowradius)', tuse-avg, '0', []);
        predValue = makePrediction((-windowradius:windowradius)',tuse-avg,windowradius+1,opt,param,variance);
        predictions=[predictions; predValue+avg];
    end
    

preds=predictions((windowsize+1):end) - t((windowsize+1):end);
predictions=predictions((windowsize+1):end);

xs=x((windowsize+1):end);
t1=t((windowsize+1):end);
t2=t((windowsize):(end-1));

SSEours=sum((      preds     ).^2 ); %our predictions SSE
SSEbad=sum((      t((windowsize):(end-1)) - t((windowsize+1):end)     ).^2 ); %dumb predictions SSE

%now run ARP model
[ARpredictions, ARSSE]=arppredictions( t, p, windowsize );