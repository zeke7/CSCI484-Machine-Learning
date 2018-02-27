function [theta] = LeastsquareEqu(X,y)
theta = zeros(size(X, 2), 1);
theta = pinv(X' * X) * X'* y;