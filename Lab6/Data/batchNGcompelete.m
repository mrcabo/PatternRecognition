function [prototypes] = batchNG(Data, n, epochs, xdim, ydim)

% Batch Neural Gas
%   Data contains data,
Data = load ('data/checkerboard.mat');
%portotypes = load ('clusterCentroids.mat')
%   n is the number of clusters,
%   epoch the number of iterations,
%   xdim and ydim are the dimensions to be plotted, default xdim=1,ydim=2

error(nargchk(3, 5, nargin));  % check the number of input arguments
if (nargin<4)
  xdim=1; ydim=2;   % default plot values
end

[dlen,dim] = size(Data);

%prototypes =  % small initial values
% % or
sbrace = @(x,y)(x{y});
fromfile = @(x)(sbrace(struct2cell(load(x)),1));
prototypes=fromfile('clusterCentroids.mat');

lambda0 = n/2; %initial neighborhood value
% lambda
lambda = lambda0 * (0.01/lambda0).^(0:(epochs-1)/epochs);
% note: the lecture slides refer to this parameter as sigma^2
%       instead of lambda

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Action

for i=1:epochs
  D_prototypes = zeros(n,dim);   % difference for vectors is initially zero
  D_prototypes_av = zeros(n,1);       % the same holds for the quotients
  
  for j=1:dlen  % consider all points at once for the batch update
    
    % sample vector
    x = Data(j,:); % sample vector
    X = x(ones(n,1),:);  % we'll need this
    
    % neighborhood ranking
    no_change = 1;
    while no_change
        old_clustering = clustering;
        d = zeros(n_points,k);
        for j = 1:k
            d(:,j) = pdist2(dataset, prototypes(j,:), 'squaredeuclidean');
        end
        [M,I] = min(d,[],2);
        [B, idx] = sort(M,2);
        %3closest = idx(
        
        clustering = I;
        % recalculate centroids
        for h = 1:k
           prototypes(h,:) = mean(dataset(clustering==h,:));
        end
        % store
        centroids{end+1} = prototypes;
        if clustering == old_clustering
            no_change = 0;
        end    
    end
    % DISTANCE!!!
    % 1-BMU, 2-BMU, etc. (hint:sort)
    %find ranking,h,H
    
    % accumulate update
    D_prototypes = ...
    D_prototypes_av = ...
  end
  D_prototypes = D_prototypes/D_prototypes_av
      
  % update
  prototypes = D_prototypes ;
  
  % track
  if 1,   %plot each epoch
    fprintf(1,'%d / %d \r',i,epochs);
    hold off
    plot(Data(:,xdim),Data(:,ydim),'bo','markersize',3)
    hold on
    plot(prototypes(:,xdim),prototypes(:,ydim),'r.','markersize',10,'linewidth',3)
    % write code to plot decision boundaries
    ... 
    plot decision boundaries here
    ...
    %pause
    %or
    drawnow
  end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
