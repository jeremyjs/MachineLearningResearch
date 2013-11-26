%parameters for user to change
%global stack;

%data is assumed to have an x and a y variable, both of which are nX1 vectors(you need to change your data
%accordingly)
fileName='synthetic data/psSTAR.mat'; %path to your file
from=1; %beginning indice in your data
to=10; %end indice in your data
windowradius=3; %window radius for runPreds function
datades='synthetic test';

p=2;
%parameters for user to change


%run our prediction function
%also get actual and really dumb predictions t1,t2
[predictions, ARPpredictions, xs, actual, dumb, SSEal, SSEARP, SSEdumb]=runPreds(fileName, from, to, windowradius, p);


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
save('test.mat', 'predictions', 'actual', 'dumb', 'ARPpredictions', 'predictions', 'SSEal', 'SSEdumb', 'SSEARP');
saveas(h,'test.jpg', 'jpg');
clear;