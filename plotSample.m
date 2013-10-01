

x=(-5:0.1:5)'; %this will be the range of x-values on the plot

C = gramcov(x,x,'p',[1 1 3]'); %set the covariance matrix

numSamples=1; %this is the number of functions graphed

figure; %plot the functions...
for i=1:numSamples
    t=mvnrnd(zeros(size(x)),C);
    hold on;
    plot(x,t);
end