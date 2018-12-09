clear all;
load lab3_2.mat;
% load KNN.m;

K=1;
data = lab3_2;
nr_of_classes = 2;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
Kmax = 21;
err_count = zeros(11,1);
j = 1;
for K = 1:2:Kmax
    K
    for i = 1:size(data)
        sub_data = data(1:i-1,:);
        sub_data = [sub_data; data(i+1:size(data,1),:)];
        sub_labels = class_labels(1:i-1);
        sub_labels = [sub_labels class_labels(i+1:size(class_labels,2))];
        result = KNN(data(i,:),K,sub_data,sub_labels);
        
        if result ~= class_labels(i)
                err_count(j) = err_count(j)+1;
        end
    end
    j = j+1;
 
end
err_count(1:11);
[min_err, idx] = min(err_count(1:11));
plot (err_count);
labels = sprintf('d=%1.3f',err_count);
xlabel('Ks')
ylabel('Classification error')

