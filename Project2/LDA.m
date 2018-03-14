%% Get the data
temp = load('wine.txt');
Labels = temp(:,1);
Data = temp(:,2:end);

Data1 = find(Labels==1);
n1=size(Data1,1);
Data2 = find(Labels==2);
n2=size(Data2,1);
Data3 = find(Labels==3);
n3=size(Data3,1);

%% Get features
N1 = Data(Data1,:);
N2 = Data(Data2,:);
N3 = Data(Data3,:);

%% Calculate the mean points for each class
m1 = mean(N1)';
m2 = mean(N2)';
m3 = mean(N3)';
muu = mean(Data)';

%% Calculate the within-class scatter matrix
sn1=[];
sn2=[];
sn3=[];
for i=1:n1
    sn1(i,:) = N1(i,:)-m1';
end
for i=1:n2
    sn2(i,:) = N2(i,:)-m2';
end
for i=1:n3
    sn3(i,:) = N3(i,:)-m3';
end

s1=sn1'*sn1;
s2=sn2'*sn2;
s3=sn3'*sn3;

sw = s1+s2+s3;

%% Way 1 Between-class scatter
sb = n1 * (m1-muu) * (m1-muu)' + n2 * (m2-muu) * (m2-muu)' + n3 * (m3-muu) * (m3-muu)';

% Fine the eigenvalue and eigenvectors
invsw = inv(sw);
invsw_by_sb = invsw * sb;
[EIGVEC,EIGVAL] = eig(invsw_by_sb);

% Project the original data points
w1 = EIGVEC(:,1);
w2 = EIGVEC(:,2);
w3 = EIGVEC(:,3);

y11 = N1*w1;
y12 = N2*w1;
y13 = N3*w1;

y21 = N1*w2;
y22 = N2*w2;
y23 = N3*w2;

y31 = N1*w3;
y32 = N2*w3;
y33 = N3*w3;

% Plot those data points
figure; % 1D
histogram(y11,50);
hold on;
histogram(y12,50);
hold on;
histogram(y13,50);

figure; % 2D
plot(y11,y21,'or');
hold on;
plot(y12,y22,'ob');
hold on;
plot(y13,y23,'og');

figure; % 3D
plot3(y11,y21,y31,'or');
hold on;
plot3(y12,y22,y32,'og');
hold on;
plot3(y13,y23,y33,'ob');

%% Way 2 Between-class scatter

sb1 = (m1-m2-m3) * (m1-m2-m3)';

% Fine the eigenvalue and eigenvectors
invsw = inv(sw);
invsw_by_sb = invsw * sb1;
[EIGVEC,EIGVAL] = eig(invsw_by_sb);

% Project the original data points
w1 = EIGVEC(:,1);
w2 = EIGVEC(:,2);
w3 = EIGVEC(:,3);

y11 = N1*w1;
y12 = N2*w1;
y13 = N3*w1;

y21 = N1*w2;
y22 = N2*w2;
y23 = N3*w2;

y31 = N1*w3;
y32 = N2*w3;
y33 = N3*w3;

% Plot those data points
figure; % 1D
histogram(y11,50);
hold on;
histogram(y12,50);
hold on;
histogram(y13,50);

figure; % 2D
plot(y11,y21,'or');
hold on;
plot(y12,y22,'ob');
hold on;
plot(y13,y23,'og');

figure; % 3D
plot3(y11,y21,y31,'or');
hold on;
plot3(y12,y22,y32,'og');
hold on;
plot3(y13,y23,y33,'ob');