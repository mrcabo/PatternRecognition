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

% w = [muA1;muA2;muB];
% If we initialize the weights around the means, it generates convergenec
% too quickly, and the Error graph doesn't mean much..
w = [[0.8334,1.0517];[9.5197, 7.6786];[5,5]];

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


f2 = figure;
% n=1,1
prototype_class = [0;1];
w_11 = [max(data_lvq_A); max(data_lvq_B)];
[w_11, E] = lvq1(dataset, labels, w_11, learning_rate, threshold, prototype_class);
plot(E)
% n=1,2
prototype_class = [0;1;1];
w_12 = [max(data_lvq_A); max(data_lvq_B); min(data_lvq_B)];
[w_12, E] = lvq1(dataset, labels, w_12, learning_rate, threshold, prototype_class);
hold on
plot(E)
% n=2,1
prototype_class = [0;0;1];
w_21 = [max(data_lvq_A); min(data_lvq_A); max(data_lvq_B)];
[w_21, E] = lvq1(dataset, labels, w_21, learning_rate, threshold, prototype_class);
hold on
plot(E)
% n=2,2
prototype_class = [0;0;1;1];
w_22 = [max(data_lvq_A); min(data_lvq_A) ; max(data_lvq_B); min(data_lvq_B)];
[w_22, E] = lvq1(dataset, labels, w_22, learning_rate, threshold, prototype_class);
hold on
plot(E)

xlabel('epochs')
ylabel('Error')
legend('1,1', '1,2', '2,1', '2,2')

f3 = figure;
dataset = [data_lvq_A; data_lvq_B];
% n_11
prototype_class = [0;1];
classified_labels = classify(w_11, prototype_class, dataset);
subplot(2,2,1)
scatter(dataset(:,1),dataset(:,2),[],classified_labels)
title('1-1')
% n_12
prototype_class = [0;1;1];
classified_labels = classify(w_12, prototype_class, dataset);
subplot(2,2,2)
scatter(dataset(:,1),dataset(:,2),[],classified_labels)
title('1-2')
% n_21
prototype_class = [0;0;1];
classified_labels = classify(w_21, prototype_class, dataset);
subplot(2,2,3)
scatter(dataset(:,1),dataset(:,2),[],classified_labels)
title('2-1')
% n_22
prototype_class = [0;0;1;1];
classified_labels = classify(w_22, prototype_class, dataset);
subplot(2,2,4)
scatter(dataset(:,1),dataset(:,2),[],classified_labels)
title('2-2')

