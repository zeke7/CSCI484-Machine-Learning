M = load('wine.txt');
[m,n] = size(M);
in1 = 0;
in2 = 0;
in3 = 0;
for i=1:m
    if M(i,1)==1
        in1 = in1 +1;
    end
    if M(i,1)==2
        in2 = in2 +1;
    end
    if M(i,1)==3
        in3 = in3 +1;
    end
end
w1=M(1:in1,1:n);   %Wine 1
w2=M((in1+1):(in1+in2),1:n);   %Wine 2
w3=M((in1+in2+1):m,1:n);   %Wine 3

f1=w1(:,2:end);     %Wine 1 (features)
f2=w2(:,2:end);     %Wine 2 (features)
f3=w3(:,2:end);     %Wine 3 (features)

[EIGVEC1,EIGVAL1] = eig(cov(f1));
[EIGVEC2,EIGVAL2] = eig(cov(f2));
[EIGVEC3,EIGVAL3] = eig(cov(f3));

%% 1D
%=============================================%
% Reduce class 1 from 13D to 1D
%=============================================%
XT11 = [];
for i=1:in1
    XT11(i,1) = f1(i,:) * EIGVEC1(:,13);
end
%=============================================%
% Reduce class 2 from 13D to 1D
%=============================================%
XT12 = [];
for i=1:in2
    XT12(i,1) = f2(i,:) * EIGVEC2(:,13);
end
%=============================================%
% Reduce class 3 from 13D to 1D
%=============================================%
XT13 = [];
for i=3:in3
    XT13(i,1) = f3(i,:) * EIGVEC3(:,13);
end
%=============================================%
% Plot the 2D results
%=============================================%
histogram(XT11,50);
hold on;
histogram(XT12,50);
hold on;
histogram(XT13,50);
xlabel('First Principal Component');

%% 2D
%=============================================%
% Reduce class 1 from 13D to 2D
%=============================================%
XT21 = [];
for i=1:in1
    XT21(i,1) = f1(i,:) * EIGVEC1(:,13);
    XT21(i,2) = f1(i,:) * EIGVEC1(:,12);
end
%=============================================%
% Reduce class 2 from 13D to 2D
%=============================================%
XT22 = [];
for i=1:in2
    XT22(i,1) = f2(i,:) * EIGVEC2(:,13);
    XT22(i,2) = f2(i,:) * EIGVEC2(:,12);
end
%=============================================%
% Reduce class 3 from 13D to 2D
%=============================================%
XT23 = [];
for i=1:in3
    XT23(i,1) = f3(i,:) * EIGVEC3(:,13);
    XT23(i,2) = f3(i,:) * EIGVEC3(:,12);
end

%=============================================%
% Plot the 2D results
%=============================================%
figure;
plot(XT21(:,1),XT21(:,2),'or');
hold on;
plot(XT22(:,1),XT22(:,2),'ob');
hold on;
plot(XT23(:,1),XT23(:,2),'og');
xlabel('First Principal Component');
ylabel('Second Principal Component');

%% 3D

%=============================================%
% Reduce class 1 from 13D to 3D
%=============================================%
XT31 = [];
for i=1:in1
    XT31(i,1) = f1(i,:) * EIGVEC1(:,13);
    XT31(i,2) = f1(i,:) * EIGVEC1(:,12);
    XT31(i,3) = f1(i,:) * EIGVEC1(:,11);
end
%=============================================%
% Reduce class 2 from 13D to 3D
%=============================================%
XT32 = [];
for i=1:in2
    XT32(i,1) = f2(i,:) * EIGVEC2(:,13);
    XT32(i,2) = f2(i,:) * EIGVEC2(:,12);
    XT32(i,3) = f2(i,:) * EIGVEC2(:,11);
end
%=============================================%
% Reduce class 3 from 13D to 3D
%=============================================%
XT33 = [];
for i=1:in3
    XT33(i,1) = f3(i,:) * EIGVEC3(:,13);
    XT33(i,2) = f3(i,:) * EIGVEC3(:,12);
    XT33(i,3) = f3(i,:) * EIGVEC3(:,11);
end

figure;
plot3(XT31(:,1),XT31(:,2),XT31(:,3),'or');
hold on;
plot3(XT32(:,1),XT32(:,2),XT32(:,3),'ob');
hold on;
plot3(XT33(:,1),XT33(:,2),XT33(:,3),'og');

xlabel('First Principal Component');
ylabel('Second Principal Component');
zlabel('Third Principal Component');