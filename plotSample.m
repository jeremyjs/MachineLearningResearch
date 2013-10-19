function [ a ] = plotSample(x, operation, parameter )
a=1;

C = gramcov(x,x,operation,parameter); %set the covariance matrix

numSamples=1; %this is the number of functions graphed

figure; %plot the functions...
for i=1:numSamples
    t=mvnrnd(zeros(size(x)),C);
    hold on;
    plot(x,t);
end

end