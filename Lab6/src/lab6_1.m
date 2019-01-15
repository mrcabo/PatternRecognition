close all;
clear all;

dataset = load('E:\RUG\2-2\Pattern Recognition\PatternRecognition\Lab6/Data/kmeans1.mat');
dataset = dataset.kmeans1;

% k = [2,4,8];
k = 4;

type = 'normal';
% type = '++';

[w,clustering] = kmeans(k, dataset, type);


% Markers = {'+','o','*','x','v','d','^','s','>','<'};
% markerarray = Markers(clustering);
% MaxClusteringValue = max(clustering);
% dataarray = [];
% for i = 1 : MaxClusteringValue
%     dataarray = [dataarray;dataset(clustering(i))];
% end

scatter(dataset(:,1), dataset(:,2),[],clustering)

% Marker_Counter=1;
% figure6=figure;
% Markers = {'+','o','*','x','v','d','^','s','>','<'};
% for i=1:10:size(dataset,1)
% for j = 1 :size(clustering)
%     if clustering(j) ==1 
%         scatter(clustering(j),clustering(j),[],'d')
%         hold on
%        
%     elseif clustering(j) ==2
%         scatter(clustering(j),clustering(j),[],'filled')
%         hold on
%     elseif clustering(j) ==3
%         scatter(clustering(j),clustering(j),[],'*')
%         hold on
%     elseif clustering(j) ==4
%         scatter(clustering(j),clustering(j),[],'o')
%         hold on
%         
%     end
%     hold on
% end
   
% end
   
   

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
    centroids = zeros(k,2);
    for h = 1:k
       w(h,:) = mean(dataset(clustering==h,:));
       if w(h,:) ~= centroids(h,:)
           plot_arrow(centroids(h,1),centroids(h,2),w(h,1),w(h,2));
           hold on
           for j = 1:size(w,1)
               centroids(j,:) = w(j,:);
           end
       end
           
        
    end
    
    if clustering == old_clustering
        no_change = 0;
    end    
end

end