function [X,y] = histline(x,y)
%% prepares output from histogram for plotting
% MATLAB's histogram returns two arrays with different lengths
X=ones(length(x)-1,1);
for i=1:length(x)-1
    X(i) = (x(i)+x(i+1))/2;
end