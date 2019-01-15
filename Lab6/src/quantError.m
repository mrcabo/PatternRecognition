function J = quantError(dataset, clustering, w)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

J = 0;
for j = 1:size(w,1)
    Cx = dataset(clustering==j,:);
    J = J + sum(pdist2(Cx, w(j,:), 'squaredeuclidean'));
end
J = 0.5*J;
end

