x;
t;
windowradius=5;

predictions=zeros(windowradius*2+1,1);
windowsize=2*windowradius+1;
for predIndex=(windowsize+1):length(t)
    predIndex
    tuse = t( (predIndex-windowsize) : (predIndex-1) );
    avg = mean(tuse);
    %%x( (predIndex-windowsize):(predIndex-1) )
    [opt,param] = learncov( (-windowradius:windowradius)', tuse-avg);
    predValue = makePrediction((-windowradius:windowradius)',tuse-avg,windowradius+1,opt,param);
    predictions=[predictions; predValue+avg];
end


sum((      predictions((windowsize+1):end) - t((windowsize+1):end)     ).^2 ) %our predictions SSE
sum((      t((windowsize):(end-1)) - t((windowsize+1):end)     ).^2 ) %dumb predictions SSE