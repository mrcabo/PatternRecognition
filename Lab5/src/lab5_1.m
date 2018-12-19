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
muA1 = mean(data_lvq_A(1:(length(sortedA)/2),:));
muA2 = mean(data_lvq_A((length(sortedA)/2+1):length(sortedA),:));
muB = mean(data_lvq_B);

hold on;
scatter(muA1(1),muA1(2),[],'b','filled')
hold on;
scatter(muA2(1),muA2(2),[],'b','filled')
hold on;
scatter(muB(1),muB(2),[],'b','filled')

w = [muA1;muA2;muB];

niter = 10000;
learning_rate = 0.01;
E = [];
threshold = 0.01;
for i = 1:niter
    err = 0;
    for j = 1:length(dataset)
        xi = dataset(j,:);
        d1=0; d2=0; d3=0;
        for k = 1:size(dataset,2)
            d1 = d1 + (w(1,k)-xi(k))^2;
            d2 = d2 + (w(2,k)-xi(k))^2;
            d3 = d3 + (w(3,k)-xi(k))^2;
        end
        [M,I] = min([d1,d2,d3]);
        if I==3
            S = 1;
        else
            S = 0;
        end
        if S==labels(j)
            psi = 1;
        else
            psi = -1;
            err = err + 1;
        end
        w(I,:) = w(I,:) + learning_rate*psi*(xi-w(I,:));
    end
    E = [E;err/length(labels)];
end


hold on;
scatter(w(1,1),w(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(2,1),w(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
hold on;
scatter(w(3,1),w(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')
