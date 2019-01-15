close all;
% clear all;

dataset = load('E:\RUG\2-2\Pattern Recognition\PatternRecognition\Lab6/Data/kmeans1.mat');
dataset = dataset.kmeans1;

<<<<<<< HEAD
% k = [2,4,8];
=======
rng('default');
>>>>>>> 393c5587967636bfad0d842ef2ba71bde8b4367f
k = 4;

type = 'normal';

<<<<<<< HEAD
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
    
=======
[w,clustering, centroids] = kmeans(k, dataset, type);
f1 = figure;
maxNumClusters = max(clustering);
group = {};

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
        plot_arrow(centroids{j-1}(i,1), centroids{j-1}(i,2), centroids{j}(i,1), centroids{j}(i,2));
    end
>>>>>>> 393c5587967636bfad0d842ef2ba71bde8b4367f
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% kmax = 32;
% % type = '++';
% type = 'normal';
% Jk = zeros(kmax,1);
% Rk = zeros(kmax,1);
% for k = 1:kmax
%     [w,clustering, centroids] = kmeans(k, dataset, type);
%     % quantization error
%     Jk(k) = quantError(dataset, clustering, w);
%     Rk(k) = Jk(1) * k^(-2/2);
% end
% Dk = Rk./Jk;
% 
% [~, I] = max(Dk);
% kopt = I;
% 
% f2 = figure;
% plot(1:kmax, Dk)
% hold on;
% scatter(kopt, Dk(kopt), [], 'r')
% xlabel('k');
% ylabel('D(k)');
% legend('D(k)','D(kopt)');
% 
% f3 = figure;
% plot(1:kmax, Jk)
% hold on;
% plot(1:kmax, Rk)
% hold on;
% scatter([kopt;kopt], [Jk(kopt), Rk(kopt)], [], 'r')
% xlabel('k');
% legend('J(k)','R(k)', 'Kopt');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

<<<<<<< HEAD
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
           
        
=======
checkerboard = load('./data/checkerboard.mat');
dataset = checkerboard.checkerboard;
k = 100;
n_runs = 20;
n_series = 10;
J = zeros(n_runs, 2); % one for normal & one for ++
Jmin = zeros(n_series, 2);

for j = 1:n_series
    for i = 1:n_runs
        type = 'normal';
        [w,clustering, ~] = kmeans(k, dataset, type);
        J(i,1) = quantError(dataset, clustering, w);
        type = '++';
        [w,clustering, centroids] = kmeans(k, dataset, type);
        J(i,2) = quantError(dataset, clustering, w);
>>>>>>> 393c5587967636bfad0d842ef2ba71bde8b4367f
    end
    Jmin(j,:) = min(J,[],1);
end



