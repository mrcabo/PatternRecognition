% Lab6_1
close all
clear all
dataset = load ('E:\RUG\2-2\Pattern Recognition\PatternRecognition\Lab6/Data/kmeans1.mat');
dataset = dataset.kmeans1;
K = 2;
max_iterations = 10;
centroids = initCentroids(dataset, K);

for i=1:max_iterations
  indices = getClosestCentroids(dataset, centroids);
  centroids = computeCentroids(dataset, indices, K);
end

%return K random indices from X as centroids
 function centroids = initCentroids(dataset, K)
    centroids = zeros(K,size(dataset,2)); 
    randidx = randperm(size(dataset,1));%randomly reorder the indices of the dataset
    centroids = dataset(randidx(1:K), :);
 end
 
 %compute euclidean distance and assign datapoints to the closest ones
 function indices = getClosestCentroids(dataset, centroids)
  K = size(centroids, 1);
  indices = zeros(size(dataset,1), 1);
  m = size(dataset,1);

  for i=1:m
    k = 1;
    min_dist = sum((dataset(i,:) - centroids(1,:)) .^ 2);
    for j=2:K
        dist = sum((dataset(i,:) - centroids(j,:)) .^ 2);
        if(dist < min_dist)
          min_dist = dist;
          k = j;
        end
    end
    indices(i) = k;
  end
 end
function centroids = computeCentroids(dataset, idx, K)

  [m n] = size(dataset);
  centroids = zeros(K, n);
  
  for i=1:K
    xi = dataset(idx==i,:);
    ck = size(xi,1);
    centroids(i, :) = (1/ck) * sum(xi);
  end
end