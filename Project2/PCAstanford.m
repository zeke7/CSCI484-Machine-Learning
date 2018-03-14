M = load('wine.txt');
M = M(:,2:end);
[m,n] = size(M);

mu=zeros(n,1);
for j=1:n
    for i=1:m
        mu(j,:) = mu(j,:) + M(i,j);
    end
    mu(j,:)=mu(j,:)/m;
end

for j=1:n
    M(:,j) = M(:,j) - mu(j,:);
end

sigma = (1/m) * M' * M;

[U,S,V] = svd(sigma);

%1D
Ureduce1 = U(:,1:1);
z1 = [];
for i=1;m
    z1 =  Ureduce1' * M';
end
z1=z1';

%2D
Ureduce2 = U(:,1:2);
z2 = [];
for i=1;m
    z2 =  Ureduce2' * M';
end
z2=z2';


%3D
Ureduce3 = U(:,1:3);
z3= [];
for i=1;m
    z3 =  Ureduce3' * M';
end
z3=z3';


plot3(z3(:,1),z3(:,2),z3(:,3),'og');
hold on;
plot(z2(:,1),z2(:,2),'or');
hold off;

figure;
plot(z2(:,1),z2(:,2),'or');
hold on;
hist(z1,100);


figure;
plot(z2(1:59,1),z2(1:59,2),'or');
hold on;
plot(z2(60:130,1),z2(60:130,2),'og');
hold on;
plot(z2(131:178,1),z2(131:178,2),'ob');


