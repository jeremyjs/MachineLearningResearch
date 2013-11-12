function [ a ] = plotSample(x, operation, parameter )
a=1;
    
X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
    
X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i

C = gramcov(X1,X2,operation,parameter); %set the covariance matrix

numSamples=1; %this is the number of functions graphed

figure; %plot the functions...
for i=1:numSamples
    t=mvnrnd(zeros(size(x)),C)';
    hold on;
    plot(x,t);
end

end