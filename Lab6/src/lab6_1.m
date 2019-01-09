close all;
clear all;

dataset = load('data/kmeans1.mat');
dataset = dataset.kmeans1;

% k = [2,4,8];
k = 2

type = 'normal';
% type = '++';

[w,clustering] = kmeans(k, dataset, type);
scatter(dataset(:,1), dataset(:,2),[],clustering)

for i = 1:k
    hold on;
    scatter(w(i,1),w(i,2),150,i,'filled','MarkerEdgeColor','k','LineWidth',1)
end


function [w, clustering] = kmeans(k, dataset, type)
n_points = length(dataset);
% which cluster does the datapoint belongs to
clustering = zeros(n_points,1);

if strcmp(type,'++') % k-means++ algorithm
    %kmeans++
else
    % Randomly initialize K prototypes
    idx = randperm(n_points,k);
    w = dataset(idx,:); 
end

no_change = 1;
while no_change
    old_clustering = clustering;
    for i = 1:n_points
        % calculate distances to all the prototypes
        d = zeros(k,1);
        for j = 1:length(d)
            d(j) = sum((dataset(i,:) - w(j,:)).^2);
        end
        % Assign to closest prototype
        [~,I] = min(d);
        clustering(i) = I;      
    end
    
    % recalculate centroids
    for h = 1:k
       w(h,:) = mean(dataset(clustering==h,:));
    end
    
    if clustering == old_clustering
        no_change = 0;
    end    
end

end