%parameters for user to change
%global stack;

%data is assumed to have an x and a y variable, both of which are nX1 vectors(you need to change your data
%accordingly)
syntheticdata=['synthetic data/hard1.mat '; 'synthetic data/hard2.mat ';'synthetic data/hard3.mat ';'synthetic data/1.mat     ';'synthetic data/2.mat     ';'synthetic data/3.mat     ';'synthetic data/psSTAR.mat';]; %path to your file
realdata=['data sources/facebook.mat';'data sources/ibm.mat     ';'data sources/intel.mat   ';'data sources/yahoo.mat   '];
from=1; %beginning indice in your data
to=50; %end indice in your data
windowradius=20; %window radius for runPreds function
p=10;
%parameters for user to change

%run on synthetic data
resultsdir='synthetic results/';
celldata=cellstr(syntheticdata);
for i=1:length(celldata)
    %run our prediction function
    %also get actual and really dumb predictions t1,t2
    [predictions, ARPpredictions, xs, actual, dumb, SSEal, SSEARP, SSEdumb]=runPreds(celldata{i}, from, to, windowradius, p);

    disp(strcat('at i = ', num2str(i)));
    h=figure;
    plot(xs, predictions,'-g',xs,actual,'--b',xs,dumb,'-y', xs, ARPpredictions, '-r');
    hleg1=legend('Our predictions','actual','dumb predictions', 'ARP predictions');
    title(strcat('Predictions plot with windowradius= ', num2str(windowradius)));

    %display our results
    disp(sprintf('%s%s', 'actual = ', mat2str(actual)));
    disp(sprintf('%s%s', 'dumb predictions = ', mat2str(dumb)));
    disp(sprintf('%s%s', 'ARPpredictions = ', mat2str(ARPpredictions)));
    disp(sprintf('%s%s', 'predictions = ', mat2str(predictions)));
    disp(sprintf('%s%s', 'SSEal = ', num2str(SSEal)));
    disp(sprintf('%s%s', 'SSEdumb = ', num2str(SSEdumb)));
    disp(sprintf('%s%s', 'SSEARP = ', num2str(SSEARP)));
    save(strcat(resultsdir,num2str(i),'.mat'), 'predictions', 'actual', 'dumb', 'ARPpredictions', 'predictions', 'SSEal', 'SSEdumb', 'SSEARP');
    saveas(h,strcat(resultsdir,num2str(i),'.jpg'), 'jpg');

end

%run on real data
celldata=cellstr(realdata);
resultsdir='real data results/';
to=100;
windowradius=40;
p=20;
for i=1:length(celldata)
    disp(strcat('at i = ', num2str(i)));
    %run our prediction function
    %also get actual and really dumb predictions t1,t2
    [predictions, ARPpredictions, xs, actual, dumb, SSEal, SSEARP, SSEdumb]=runPreds(celldata{i}, from, to, windowradius, p);
    
    h=figure;
    plot(xs, predictions,'-g',xs,actual,'--b',xs,dumb,'-y', xs, ARPpredictions, '-r');
    hleg1=legend('Our predictions','actual','dumb predictions', 'ARP predictions');
    title(strcat('Predictions plot with windowradius= ', num2str(windowradius)));

    %display our results
    disp(sprintf('%s%s', 'actual = ', mat2str(actual)));
    disp(sprintf('%s%s', 'dumb predictions = ', mat2str(dumb)));
    disp(sprintf('%s%s', 'ARPpredictions = ', mat2str(ARPpredictions)));
    disp(sprintf('%s%s', 'predictions = ', mat2str(predictions)));
    disp(sprintf('%s%s', 'SSEal = ', num2str(SSEal)));
    disp(sprintf('%s%s', 'SSEdumb = ', num2str(SSEdumb)));
    disp(sprintf('%s%s', 'SSEARP = ', num2str(SSEARP)));
    save(strcat(resultsdir,num2str(i),'.mat'), 'predictions', 'actual', 'dumb', 'ARPpredictions', 'predictions', 'SSEal', 'SSEdumb', 'SSEARP');
    saveas(h,strcat(resultsdir,num2str(i),'.jpg'), 'jpg');

end