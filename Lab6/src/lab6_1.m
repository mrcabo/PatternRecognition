close all;
clear all;

dataset = load('data/kmeans1.mat');
dataset = dataset.kmeans1;

rng('default');
k = 4;

type = 'normal';

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

checkerboard = load('./data/checkerboard.mat');
dataset = checkerboard.checkerboard;
k = 100;
n_runs = 20;
J = zeros(n_runs, 2); % one for normal & one for ++
for i = 1:n_runs
    type = 'normal';
    [w,clustering, ~] = kmeans(k, dataset, type);
    J(i,1) = quantError(dataset, clustering, w);
    type = '++';
    [w,clustering, centroids] = kmeans(k, dataset, type);
    J(i,2) = quantError(dataset, clustering, w);
end

Jmean = mean(J,1);
