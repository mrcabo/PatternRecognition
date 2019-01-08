close all

% data_lvq_A = load('E:\RUG\2-2\Pattern Recognition\Labs\Lab5/Data/data_lvq_A.mat');
% data_lvq_B = load('E:\RUG\2-2\Pattern Recognition\Labs\Lab5/Data/data_lvq_B.mat');
data_lvq_A = load('./Data/data_lvq_A.mat');
data_lvq_B = load('./Data/data_lvq_B.mat');
data_lvq_A = data_lvq_A.matA;
data_lvq_B = data_lvq_B.matB;

dataset = [data_lvq_A; data_lvq_B];
p = randperm(length(dataset));
dataset = [dataset(p,1), dataset(p,2)];
labels = [zeros(length(data_lvq_A),1);ones(length(data_lvq_B),1)];
labels = labels(p);

sortedA = sortrows(data_lvq_A,1);
muA = mean(data_lvq_A);
muA1 = mean(data_lvq_A(1:(length(sortedA)/2),:));
muA2 = mean(data_lvq_A((length(sortedA)/2+1):length(sortedA),:));
muB = mean(data_lvq_B);
muB1 = muB+ [0,2];
muB2 = muB+ [0,-2];

prototypes = [muA1;muA2;muB];

niter = 10000;
learning_rate = 0.01;
threshold = 1e-5;
prototype_class = [0;0;1];

n = size(dataset,1);
m = ceil(n/10);
k = 1:m:n;
testset = zeros(m,2);
trainset = zeros((length(dataset)-m),2);
trnE = zeros((length(dataset)-m),1);
meantstE = 0;
for i =1:size(k,2)
    testset = dataset(k(i):k(i)+m-1,:);
    trainset = setdiff (dataset, testset, 'rows');
    
    [prototypes, trainE] = cvtrainlvq1(trainset,labels, prototypes, learning_rate, threshold, prototype_class);
    [prototypes, tstE] = cvtestlvq1(testset,labels, prototypes, learning_rate, threshold, prototype_class);
    trnE = (mean(trainE)*100);
    
    bar(i,trnE)
    hold on
    title('S3559734');
    xlabel('folds'), ylabel('classification errors in percentage');
    text(i,trnE,num2str(trnE'),'vert','bottom','horiz','center'); 
    box off
    
    meantstE = meantstE + mean(tstE);
end
meantstE=(meantstE/10)*100;
xlim=get(gca,'xlim');
hold on
plot(xlim,[meantstE meantstE])
text(1,meantstE,num2str(meantstE'),'vert','bottom','horiz','center');
function [prototypes, trnE] = cvtrainlvq1(traininset,labels, prototypes, learning_rate, threshold, prototype_class)
trnE = [];
keep = 1;
limit = 10000;
count = 0;
while keep==1 && count<limit
    err = 0;
    for j = 1:length(traininset)
        xi = traininset(j,:);
        d = zeros(size(prototypes,1),1);
        for k = 1:size(traininset,2)
            for m = 1:length(d)
                d(m) = d(m) + (prototypes(m,k)-xi(k))^2;
            end
        end
        [M,I] = min(d);
        if prototype_class(I)==labels(j)
            psi = 1;
        else
            psi = -1;
            err = err + 1;
        end
        prototypes(I,:) = prototypes(I,:) + learning_rate*psi*(xi-prototypes(I,:));
    end
    trnE = [trnE;err/length(labels)];
    if length(trnE) > 100
        variance = var(trnE(length(trnE)-10:length(trnE)));
        if variance < threshold
            keep = 0;
        end
    end
    % Reshuffle data
    p = randperm(length(traininset));
    traininset = [traininset(p,1), traininset(p,2)];
    labels = labels(p);
    count = count +1;

end

end
function [prototypes, tstE] = cvtestlvq1(testset,labels, prototypes, learning_rate, threshold, prototype_class)
    tstE = [];
    keep = 1;
    limit = 10000;
    count = 0;
    while keep==1 && count<limit
        testerr = 0;
        for j = 1:length(testset)
            xi = testset(j,:);
            d = zeros(size(prototypes,1),1);
            for k = 1:size(testset,2)
                for m = 1:length(d)
                    d(m) = d(m) + (prototypes(m,k)-xi(k))^2;
                end
            end
            [M,I] = min(d);
            if prototype_class(I)==labels(j)
                psi = 1;
            else
                psi = -1;
                testerr = testerr + 1;
            end
            prototypes(I,:) = prototypes(I,:) + learning_rate*psi*(xi-prototypes(I,:));
        end
        tstE = [tstE;testerr/length(labels)];
        if length(tstE) > 100
            variance = var(tstE(length(tstE)-10:length(tstE)));
            if variance < threshold
                keep = 0;
            end
        end
        % Reshuffle data
        p = randperm(length(testset));
        testset = [testset(p,1), testset(p,2)];
        labels = labels(p);
        count = count +1;

    end
    
end
