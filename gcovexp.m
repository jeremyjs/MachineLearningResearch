function [ C ] = gcovexp( x1 ,x2, opt)
%THIS IS THE EXPERIMENTS FILE TO EXPERIMENT DIFFERENT COMBINATIONS
%COVARIANCE FUNCTIONS

%x1 and x2 are two vectors. this function returns a matrix C where the ij
%entry is the covariance between x1_j and x2_i



X1 = repmat(x1,[1 length(x2)]); %make a matrix where the ij entry is x1_j
X2 = repmat(x2',[length(x1) 1]); %make a matrix where the ij entry is x2_i

size(X1)
size(X2)

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

if strcmp(opt, 'pg') %periodic with gaussian on top
    C = exp( - (sin( pi.*(X1-X2) / 3.0)).^2 ) + 0.1*exp( - abs(X1-X2).^2);
end

if strcmp(opt, 'jl') %gaussian +exponential of different
    C = exp( - abs(X1-X2).^2) + (1/10)*X1.*X2 + 10 + (X1==X2);
end

if strcmp(opt, 'pj') %periodic with exponential of different
    C = exp( - (sin( pi.*(X1-X2) / 3.0)).^2 )+exp( - abs(X1-X2)/1000)+0.01*(X1==X2);
end


