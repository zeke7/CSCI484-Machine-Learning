%============================================%
% This is the first part of the project
% Linear regression model 
%============================================%

%============================================%
% This is the graph of the relation of each variables
% Linear regression model (Graphs)
%============================================%

fprintf('Plotting data of DeliveryTimes.txt...\n')
data = load('DeliveryTimes.txt');
X = data(:,2:3);
x1 = X(:,1);
x2 = X(:,2);
y = data(:,1);
m = length(y);% Number of training examples


% Empty "Time" graph...
time = subplot(3, 3, 1);
text(0.4,0.5,'Time');
set(time,'visible', 'off')

% The relation of Time(y-axis) and Cases(x-axis)
subplot(3,3,2);
scatter(x1,y);

% The relation of Time(y-axis) and Distance(x-axis)
subplot(3,3,3);
scatter(x2,y);

% The relatio of Cases(y-axis) and Time(x-axis)
subplot(3,3,4);
scatter(y,x1);

% Empty "Case" graph...
cases = subplot(3,3,5);
text(0.4,0.5,'Cases');
set(cases,'visible', 'off')

%The relatio of Cases(y-axis) and Distance(x-axis)
subplot(3,3,6);
scatter(x2,x1);

%The relatio of Distance(y-axis) and Time(x-axis)
subplot(3,3,7);
scatter(y,x2);

%The relatio of Distance(y-axis) and Cases(x-axis)
subplot(3,3,8);
scatter(x1,x2);

% Empty "Distance" graph...
distance = subplot(3,3,9);
text(0.4,0.5,'Distance');
set(distance ,'visible', 'off');

fprintf('The program is pausing, press "enter" to next step\n');
pause;

%============================================%
% This is the graph of the relation of each variables
% Linear regression model (Least square Equation)
%============================================%

% Add the feature0(A column of 1's)
 fprintf('Linear regression model (Least square Equation)...\n');
 X = [ones(m,1) X];
 theta = LeastsquareEqu(X, y);

 fprintf('Theta computed from the Least square Equation equations: \n');
 fprintf(' %f \n', theta);
 fprintf('\n');
 
 predictVal = X * theta;
 mse = sqrt(sum((predictVal - y).^2) / size(y,1));
 fprintf('The mean square error (MSE): %f \n', mse);
 
 
