%remember to edit below functions to get different synthetic data
%<EDIT HERE>, parameters for user to change
opt='p';
x=(-5:0.1:5)';
fileName='sample.mat';
%<EDIT HERE/>, parameters for user to change


X1 = repmat(x,[1 length(x)]); %make a matrix where the ij entry is x1_j
X2 = repmat(x',[length(x) 1]); %make a matrix where the ij entry is x2_i


%<EDIT HERE>, edit parameters to get different synthetic data
%add functions and name them appropriately
if opt=='c' %constant with noise
    C = ones(size(X1));
end

if opt=='l' %linear with noise
    C = 10*X1.*X2 + 10 + (X1==X2);
end

if opt=='g' %gaussian
    C = exp( - abs(X1-X2).^2);
end

if opt=='j' %exponential of different
    C = exp( - abs(X1-X2)/1000)+0.01*(X1==X2);
end

if opt =='p' %periodic
    C = exp( - (sin( pi.*(X1-X2) / 3.0)).^2 );
end
%<EDIT HERE/>, edit parameters to get different synthetic data
%add functions and name them appropriately


%plot the functions...
figure; 
hold on;
y=mvnrnd(zeros(size(x)),C);
plot(x,y);
y=y';

%save synthetic data to file
save(fileName,'x', 'y', 'opt');