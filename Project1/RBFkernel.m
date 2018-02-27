M = csvread('dota2Test.csv');

%=================================================================%
%   (Kernal function: RBF)
%   The program will use 900 samples from dota2Test.csv,
% and the first 600 samples will be used to train the model,and the   
% other 300 samples will be used to test the model.
%=================================================================%        

%=================================================================%        
% Fold 1
%=================================================================%        
%Data = M(1:600,2:117);
%temp = M(1:600,1);
%Labels = M(1:600,1);

Data = M(601:900,2:117);
temp = M(601:900,1);
Labels = M(601:900,1);
%=================================================================%
% When Cval = 0; b = NaN; Test result:  Accuracy rate: 46%
% When Cval = 10; b = 0.127861867198121; Test result: Accuracy rate: 83% 
% When Cval = 50; b = 0.046846318936093; Test result: Accuracy rate:  96%
% When Cval = 100; b = 0.170427079452457; Test result: Accuracy rate: 99%
%=================================================================%   

%=================================================================%        
% Fold 2
%=================================================================%        
%Data = M(301:900,2:117);
%temp = M(301:900,1);
%Labels = M(301:900,1);

%Data = M(1:300,2:117);
%temp = M(1:300,1);
%Labels = M(1:300,1);
%=================================================================%
% When Cval = 0; b = NaN; Test result:  Accuracy rate: 52.3%
% When Cval = 10; b = -0.200159289808129; Test result: Accuracy rate: 98.6% 
% When Cval = 50; b = 0.261868032357953; Test result: Accuracy rate: 99%
% When Cval = 100; b = 0.300522967602285; Test result: Accuracy rate: 99%
%=================================================================%      

%=================================================================%        
% Fold 3
%=================================================================%        
%Data1 = M(1:300,2:117);
%Data2 = M(601:900,2:117);
%Data = [Data1;Data2];
%Data1 = M(1:300,1);
%Data2 = M(601:900,1);
%Labels = [Data1; Data2];

%Data = M(301:600,2:117);
%temp = M(301:600,1);
%Labels = M(301:600,1);
%=================================================================%
% When Cval = 0; b = NaN; Test result:  Accuracy rate: 44.667%
% When Cval = 10; b = 0.023980197327936; Test result: Accuracy rate: 96.3% 
% When Cval = 50; b = 0.326834159848469; Test result: Accuracy rate: 96%
% When Cval = 100; b = 0.426165209137314; Test result: Accuracy rate: 95%
%=================================================================%

%=================================================================%
% RBF kernel: 
% C = 0 ;The average accuracy rate: 47.66%
% C = 10 ;The average accuracy rate: 92.63%
% C = 50 ;The average accuracy rate: 97%
% C = 100 ;The average accuracy rate: 97.67%
%=================================================================%

[N,Dim] = size(Data);
%Polynomial
H = zeros(length(Data));
len = length(Data);

var_mean = 0;
for i=1:116
    var1 = var(Data(i,:));
    var_mean = var1 + var_mean;
end
var_mean = var_mean / 116;
disp(var_mean);

for i=1:len
    for j=1:len
        kval = Data(i,:) - Data(j,:);
        K = exp( -(kval * kval')/ var_mean );
        H(i,j) = Labels(i)*Labels(j)*K;
    end
end

ff = -ones(N,1);
Aeq = zeros(N,N);
Aeq(1,:) = Labels;
beq = zeros(N,1);
Cval = 0;
[x,fval,exitflag,output,lambda] = quadprog(H+eye(N)*0.0001,ff,[],[],Aeq,beq,zeros(1,N),Cval*ones(1,N));

supportVectors = find(x > eps);
supportX = x(supportVectors);
supportData = Data(supportVectors,:);
supportLabels = Labels(supportVectors);
supportLength = length(supportLabels);

%Now, solve for b
%Create a set of b's and average them
Bset = [];
for i=1:supportLength
    Bval = 0;
    for j=1:supportLength
        kval = supportData(i,:) - supportData(j,:);
        K = exp( -(kval * kval')/ var_mean);
        Bval = Bval + ( supportX(j) * supportLabels(j) * K );
    end
    Bval = supportLabels(i) * Bval;
    Bval = (1 - Bval)/supportLabels(i);
    Bset = [ Bset Bval];
end
b = mean(Bset);

Res = zeros(1,N);
for i=1:N
    sumVal = 0;
    for j=1:supportLength
        kval = Data(i,:) - supportData(j,:);
        K = exp( -(kval * kval')/ var_mean);
        sumVal = sumVal + supportX(j)*supportLabels(j)*K;
    end
    Res(i) = sumVal + 0.023980197327936;
end

for i=1:N
    if Res(1,i) >= 0
        Res(1,i) = 1;
    else
        Res(1,i) = -1;
    end
end

diff = Res' == Labels;
acc = sum(diff);
disp(acc);


class1 = find(supportLabels == 1);
class2 = find(supportLabels == -1);

Label_class1 = supportX(class1,:);
Label_class2 = supportX(class2,:);

supportVectors_class1 = supportVectors(class1,:);
supportVectors_class2 = supportVectors(class2,:); 

supportVectors_new = find(supportX < 9.9 & supportX > 0.001); 
SX = supportX(supportVectors_new,:);

supportLabels_new = supportLabels(supportVectors_new,:);

c1 = find(supportLabels_new == 1);
c2 = find(supportLabels_new == -1);

sv1 = supportVectors_new(c1,:);
sv2 = supportVectors_new(c2,:);

l1 = SX(c1,:);
l2 = SX(c2,:);

%figure; hold on;
plot( sv1, l1, 'ko', 'MarkerFaceColor', 'r','MarkerEdgeColor','r', 'MarkerSize',10);
plot( sv2, l2, 'ko', 'MarkerFaceColor', 'g','MarkerEdgeColor','g', 'MarkerSize',10);
xlabel('SupportVectors');
ylabel('SupportX');


