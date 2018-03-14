%% Get the data
M = load('wine.txt');
M = M(:,2:end);
[m,n] = size(M);


%% Optional part (Mean normalization)

% Get the mean of each column
f_mean = mean(M)';
for i=1:n
    M(:,i) = M(:,i) - f_mean(i,:);
end
f_std = std(M)';
f_mean_new = mean(M)';

for i=1:n
    M(:,i) = (M(:,i) - f_mean_new(i,:))/f_std(i,:);
end


%% Fine the eigenvalue and eigenvectors
[EIGVEC,EIGVAL] = eig(cov(M));

%% Project the original data points
%1D
XT1 = [];
for i=1:m
    XT1(i,1) = M(i,:) * EIGVEC(:,13);
end

%2D
XT2 = [];
for i=1:m
    XT2(i,1) = M(i,:) * EIGVEC(:,13);
    XT2(i,2) = M(i,:) * EIGVEC(:,12);
end

%3D
XT3 = [];
for i=1:m
    XT3(i,1) = M(i,:) * EIGVEC(:,13);
    XT3(i,2) = M(i,:) * EIGVEC(:,12);
    XT3(i,3) = M(i,:) * EIGVEC(:,11);
end

%% Plot those data points
figure;
plot3(XT3(1:59,1),XT3(1:59,2),XT3(1:59,3),'or');
hold on;
plot3(XT3(60:130,1),XT3(60:130,2),XT3(60:130,3),'og');
hold on;
plot3(XT3(131:178,1),XT3(131:178,2),XT3(131:178,3),'ob');
xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');

figure;
plot(XT2(1:59,1),XT2(1:59,2),'or');
hold on;
plot(XT2(60:130,1),XT2(60:130,2),'og');
hold on;
plot(XT2(131:178,1),XT2(131:178,2),'ob');
xlabel('First Principal Component');
ylabel('Second Principal Component');


figure;
h1 = histogram(XT1(1:59,1),50);
hold on;
h2 = histogram(XT1(60:130,1),50);
hold on;
h3 = histogram(XT1(131:178,1),50);
xlabel('First Principal Component');
