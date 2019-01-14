close all;
clear all;

dataset = load('data/kmeans1.mat');
dataset = dataset.kmeans1;

% k = [2,4,8];
k = 2

type = 'normal';
% type = '++';

[w,clustering, centroids] = kmeans(k, dataset, type);

maxNumClusters = max(clustering);
group = {}

for i = 1:maxNumClusters
    idx = find(clustering==i);
    group{end+1} = dataset(idx,:);
end
Markers = ['+','o','*','x','v','d','^','s','>','<'];
Colors = {'r', 'g', 'b', 'y', 'm', 'c', [0.5 0.5 0.5], 'k'};
% Colors = ['k', 'k', 'k', 'k', 'k', 'k', 'k', 'k'];
for i = 1:maxNumClusters
    scatter(group{i}(:,1), group{i}(:,2),[],Colors{i},Markers(i))
    hold on;
end
for i = 1:k
    hold on;
    scatter(w(i,1),w(i,2),150,Colors{i},'filled','MarkerEdgeColor','k','LineWidth',1)
end

for i = 1:k
    for j = 2:length(centroids)
        hold on;
        plot_arrow(centroids{j-1}(i,1), centroids{j-1}(i,2), centroids{j}(i,1), centroids{j}(i,2))
    end
end


function [w, clustering, centroids] = kmeans(k, dataset, type)
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

centroids = {w};

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
    % store
    centroids{end+1} = w;
    if clustering == old_clustering
        no_change = 0;
    end    
end

end