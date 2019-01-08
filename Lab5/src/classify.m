function labels = classify(weights,prototype_class,dataset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
w = weights;
n_prototypes = length(w);
n_datapoints = length(dataset);
d = zeros(1, n_prototypes);
labels = zeros(n_datapoints,1);

for i = 1:n_datapoints
    for j = 1:n_prototypes
       d(j) = (w(j,1)-dataset(i,1))^2 + (w(j,2)-dataset(i,2))^2;
    end
    [M,I] = min(d);
    labels(i) = prototype_class(I);
end
end

