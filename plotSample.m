

x=(-5:0.1:5)'; %this will be the range of x-values on the plot

C = gcov(x,x,'c'); %set the covariance matrix

numSamples=1; %this is the number of functions graphed

figure; %plot the functions...
for i=1:numSamples
    hold on;
    plot(x,mvnrnd(zeros(size(x)),C))
end