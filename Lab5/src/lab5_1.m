% Lab5_1
close all;
clear all;

data_lvq_A = load('./Data/data_lvq_A.mat');
data_lvq_B = load('./Data/data_lvq_B.mat');
data_lvq_A = data_lvq_A.matA;
data_lvq_B = data_lvq_B.matB;

dataset = [data_lvq_A; data_lvq_B];
p = randperm(length(dataset));
dataset = [dataset(p,1), dataset(p,2)];
labels = [zeros(length(data_lvq_A),1);ones(length(data_lvq_B),1)];
labels = labels(p);

f1 = figure;
scatter(data_lvq_A(:,1),data_lvq_A(:,2),[],'r')
hold on;
scatter(data_lvq_B(:,1),data_lvq_B(:,2),[],'g')
title('S3736555')
xlabel('Feature 1')
ylabel('Feature 2')

% A good point for initialize protoypes
sortedA = sortrows(data_lvq_A,1);
muA = mean(data_lvq_A);
muA1 = mean(data_lvq_A(1:(length(sortedA)/2),:));
muA2 = mean(data_lvq_A((length(sortedA)/2+1):length(sortedA),:));
muB = mean(data_lvq_B);
muB1 = muB+ [0,2];
muB2 = muB+ [0,-2];

hold on;
scatter(muA1(1),muA1(2),[],'b','filled')
hold on;
scatter(muA2(1),muA2(2),[],'b','filled')
hold on;
scatter(muB(1),muB(2),[],'b','filled')

w = [muA1;muA2;muB];

niter = 10000;
learning_rate = 0.01;
threshold = 1e-5;
prototype_class = [0;0;1];

[w, E] = lvq1(dataset, labels, w, learning_rate, threshold, prototype_class);
hold on;
scatter(w(1,1),w(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(2,1),w(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(3,1),w(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')



% Different n of prototypes
% n=1,1
f2 = figure;
scatter(data_lvq_A(:,1),data_lvq_A(:,2),[],'r')
hold on;
scatter(data_lvq_B(:,1),data_lvq_B(:,2),[],'g')
title('S3736555')
xlabel('Feature 1')
ylabel('Feature 2')

prototype_class = [0;1];
w = [mean(data_lvq_A); mean(data_lvq_B)];
hold on;
scatter(muA(1),muA(2),[],'b','filled')
hold on;
scatter(muB(1),muB(2),[],'b','filled')
[w, E] = lvq1(dataset, labels, w, learning_rate, threshold, prototype_class);
hold on;
scatter(w(1,1),w(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(2,1),w(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')

%n=1,2
f3 = figure;
scatter(data_lvq_A(:,1),data_lvq_A(:,2),[],'r')
hold on;
scatter(data_lvq_B(:,1),data_lvq_B(:,2),[],'g')
title('S3736555')
xlabel('Feature 1')
ylabel('Feature 2')

prototype_class = [0;1;1];
w = [muA;muB1;muB2];
hold on;
scatter(muA(1),muA(2),[],'b','filled')
hold on;
scatter(muB1(1),muB1(2),[],'b','filled')
hold on;
scatter(muB2(1),muB2(2),[],'b','filled')
[w, E] = lvq1(dataset, labels, w, learning_rate, threshold, prototype_class);
hold on;
scatter(w(1,1),w(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(2,1),w(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')
hold on;
scatter(w(3,1),w(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')

% n=2,2
f4 = figure;
scatter(data_lvq_A(:,1),data_lvq_A(:,2),[],'r')
hold on;
scatter(data_lvq_B(:,1),data_lvq_B(:,2),[],'g')
title('S3736555')
xlabel('Feature 1')
ylabel('Feature 2')

prototype_class = [0;0;1;1];
w = [muA1;muA2;muB1;muB2];

hold on;
scatter(muA1(1),muA1(2),[],'b','filled')
hold on;
scatter(muA2(1),muA2(2),[],'b','filled')
hold on;
scatter(muB1(1),muB2(2),[],'b','filled')
hold on;
scatter(muB2(1),muB2(2),[],'b','filled')

% threshold = 1e-7;
[w, E] = lvq1(dataset, labels, w, learning_rate, threshold, prototype_class);
hold on;
scatter(w(1,1),w(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(2,1),w(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(3,1),w(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')
hold on;
scatter(w(4,1),w(4,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')
