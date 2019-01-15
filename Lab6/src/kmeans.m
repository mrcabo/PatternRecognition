function [w, clustering, centroids] = kmeans(k, dataset, type)
n_points = length(dataset);
% which cluster does the datapoint belongs to
clustering = zeros(n_points,1);

if strcmp(type,'++') % k-means++ algorithm
    idx = randsample(n_points,1);
    w = dataset(idx,:);
    % For each data point x, compute D(x), the distance between x and the nearest prototype
    for h = 1:k-1
        n_prot = size(w,1);
        d = zeros(n_points,n_prot);
        Dx = zeros(n_points,1);
        for j = 1:n_prot
           d(:,j) = pdist2(dataset, w(j,:), 'squaredeuclidean');
        end
        Dx = min(d,[],2);
        idx = (1:n_points)';
        new_weight = randsample(idx,1,true,Dx.^2);
        w = [w; dataset(new_weight, :)];
    end
else
    % Randomly initialize K prototypes
    idx = randperm(n_points,k);
    w = dataset(idx,:); 
end

centroids = {w};
no_change = 1;
while no_change
    old_clustering = clustering;
    d = zeros(n_points,k);
    for j = 1:k
        d(:,j) = pdist2(dataset, w(j,:), 'squaredeuclidean');
    end
    [~,I] = min(d,[],2);
    clustering = I;
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