function [predictions, resid, SSEours, SSEbad] = runPreds(filename, from, to, windowradius)
load(filename);
t=y(from:to);
x=x(from:to);
predictions=zeros(windowradius*2+1,1);
windowsize=2*windowradius+1;
for predIndex=(windowsize+1):length(t)
    predIndex
    tuse = t( (predIndex-windowsize) : (predIndex-1) );
    avg = mean(tuse);
    %%x( (predIndex-windowsize):(predIndex-1) )
    [opt,param,variance] = learncov( (-windowradius:windowradius)', tuse-avg);
    predValue = makePrediction((-windowradius:windowradius)',tuse-avg,windowradius+1,opt,param,variance);
    predictions=[predictions; predValue+avg];
end
resid=0;
preds=predictions((windowsize+1):end) - t((windowsize+1):end);
xs=x((windowsize+1):end);
plot(xs, predictions((windowsize+1):end),'-',xs,t((windowsize+1):end),'--',xs,t((windowsize):(end-1)),':');
hleg1=legend('predictions','actual','dumb predictions');
title(strcat('Predictions plot with windowradius= ', num2str(windowradius)));
SSEours=sum((      preds     ).^2 ); %our predictions SSE
SSEbad=sum((      t((windowsize):(end-1)) - t((windowsize+1):end)     ).^2 ); %dumb predictions SSE
