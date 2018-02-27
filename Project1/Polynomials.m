M = csvread('dota2Test.csv');
%=================================================================%
%   (Kernal function: Polynomials)
%   The program will use 900 samples from dota2Test.csv,
% and 600 samples will be used to train the model,and the   
% other 300 samples will be used to test the model.
%=================================================================%        

%=================================================================%        
% Fold 1
%=================================================================%        
%Data = M(1:600,2:117);
%temp = M(1:600,1);
%Labels = M(1:600,1);

%Data = M(601:900,2:117);
%temp = M(601:900,1);
%Labels = M(601:900,1);
%=================================================================%
% When Cval = 0; b = NaN; Test result:  Accuracy rate: 46%
% When Cval = 10; b = 3.039336087336221; Test result: Accuracy rate: 59.3% 
% When Cval = 50; b = 3.039339503491064; Test result: Accuracy rate: 59.3%
% When Cval = 100; b = 3.039339687450168; Test result: Accuracy rate: 59.3%
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
% When Cval = 10; b = 1.292208904051222; Test result: Accuracy rate: 50.3% 
% When Cval = 50; b = 1.292205382745403; Test result: Accuracy rate: 50.3%
% When Cval = 100; b = 1.292205457598126; Test result: Accuracy rate: 50.3%
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

Data = M(301:600,2:117);
temp = M(301:600,1);
Labels = M(301:600,1);
%=================================================================%
% When Cval = 0; b = NaN; Test result:  Accuracy rate: 44.6%
% When Cval = 10; b = -0.985859142422366; Test result: Accuracy rate: 67% 
% When Cval = 50; b = -0.985864941227871; Test result: Accuracy rate: 67%
% When Cval = 100; b = -0.985865296742413; Test result: Accuracy rate: 67%
%=================================================================%       

%=================================================================%
% Polynomials: 
% C = 0 ;The average accuracy rate: 47.63%
% C = 10 ;The average accuracy rate: 58.87%
% C = 50 ;The average accuracy rate: 58.87%
% C = 100 ;The average accuracy rate: 58.87%
%=================================================================%

[N,Dim] = size(Data);
%Polynomial
H = zeros(length(Data));
len = length(Data);

for i=1:len
    for j=1:len
        K=(Data(j,:)*Data(i,:)' + 1)^2;
        H(i,j) = Labels(i)*Labels(j)*K;
    end
end

ff = -ones(N,1);
Aeq = zeros(N,N);
Aeq(1,:) = Labels;
beq = zeros(N,1);
Cval = 50;
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
        K=(supportData(i,:)*supportData(j,:)' + 1)^2;
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
        K=(supportData(j,:) * Data(i,:)' + 1)^2;
        sumVal = sumVal + supportX(j)*supportLabels(j)*K;
    end
    Res(i) = sumVal + 3.039339687450168;
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
supportVectors_new = find(supportX < 9.9 & supportX > 0.001); 
SX = supportX(supportVectors_new,:);

supportLabels_new = supportLabels(supportVectors_new,:);

c1 = find(supportLabels_new == 1);
c2 = find(supportLabels_new == -1);

sv1 = supportVectors_new(c1,:);
sv2 = supportVectors_new(c2,:);

l1 = SX(c1,:);
l2 = SX(c2,:);

figure; hold on;
plot( sv1, l1, 'ko', 'MarkerFaceColor', 'r','MarkerEdgeColor','r', 'MarkerSize',10);
plot( sv2, l2, 'ko', 'MarkerFaceColor', 'g','MarkerEdgeColor','g', 'MarkerSize',10);
xlabel('SupportVectors');
ylabel('SupportX');

