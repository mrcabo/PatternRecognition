close all

data_lvq_A = load('X:\My Documents\PR\PatternRecognition\repo\Lab5/Data/data_lvq_A.mat');
data_lvq_B = load('X:\My Documents\PR\PatternRecognition\repo\Lab5/Data/data_lvq_B.mat');
data_lvq_A = data_lvq_A.matA;
data_lvq_B = data_lvq_B.matB;

n = size(data_lvq_A,1);
m = ceil(n/10);
k = 1:m:n
A_1 = data_lvq_A(k(1):k(1)+m-1,:);
A_2 = data_lvq_A(k(2):k(2)+m-1,:);
A_3 = data_lvq_A(k(3):k(3)+m-1,:);
A_4 = data_lvq_A(k(4):k(4)+m-1,:);
A_5 = data_lvq_A(k(5):k(5)+m-1,:);
A_6 = data_lvq_A(k(6):k(6)+m-1,:);
A_7 = data_lvq_A(k(7):k(7)+m-1,:);
A_8 = data_lvq_A(k(8):k(8)+m-1,:);
A_9 = data_lvq_A(k(9):k(9)+m-1,:);
A_10 = data_lvq_A(k(10):k(10)+m-1,:);

B_1 = data_lvq_B(k(1):k(1)+m-1,:);
B_2 = data_lvq_B(k(2):k(2)+m-1,:);
B_3 = data_lvq_B(k(3):k(3)+m-1,:);
B_4 = data_lvq_B(k(4):k(4)+m-1,:);
B_5 = data_lvq_B(k(5):k(5)+m-1,:);
B_6 = data_lvq_B(k(6):k(6)+m-1,:);
B_7 = data_lvq_B(k(7):k(7)+m-1,:);
B_8 = data_lvq_B(k(8):k(8)+m-1,:);
B_9 = data_lvq_B(k(9):k(9)+m-1,:);
B_10 = data_lvq_B(k(10):k(10)+m-1,:);

%train = [data_lvq_A(1:k-1,:); data_lvq_A(k+m:end,:)]
%adj=edge(train,data_lvq_A);

train = cat(1,A_2,A_3,A_4,A_5,A_6,A_7,A_8,A_9,A_10);
Test = A_1;

p = randperm(length(train));

labels = [zeros(length(data_lvq_A),1);ones(length(data_lvq_B),1)];
labels = labels(p);

sortedA = sortrows(data_lvq_A,1);
muA = mean(data_lvq_A);
muA1 = mean(data_lvq_A(1:(length(sortedA)/2),:));
muA2 = mean(data_lvq_A((length(sortedA)/2+1):length(sortedA),:));
muB = mean(data_lvq_B);
muB1 = muB+ [0,2];
muB2 = muB+ [0,-2];
w = [muA1;muA2;muB];
learning_rate = 0.01;
threshold = 1e-5;
prototype_class = [0;0;1];
[w, E] = lvq1(train, labels, w, learning_rate, threshold, prototype_class);

f1 = figure;
scatter(data_lvq_A(:,1),data_lvq_A(:,2),[],'r')
hold on;
scatter(data_lvq_B(:,1),data_lvq_B(:,2),[],'g')
title('S3559734')
xlabel('Feature 1')
ylabel('Feature 2')

hold on;
scatter(muA1(1),muA1(2),[],'b','filled')
hold on;
scatter(muA2(1),muA2(2),[],'b','filled')
hold on;
scatter(muB(1),muB(2),[],'b','filled')
hold on;
scatter(w(1,1),w(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(2,1),w(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(3,1),w(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')