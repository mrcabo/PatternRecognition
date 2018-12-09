clear all;
load lab3_2.mat;
% load KNN.m;

K=7;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
Kmax = 21;
err_count = zeros(Kmax,1);
j = 1;
for K = 1:2:Kmax
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
    err_count(j)
    K
    j = j+1;
    title([K 'Number of Ks, ' err_count(j) ' errors']);
    plot (err_count(j),K,'go');
end

[min_err, idx] = min(err_count(1:11));
% plot (err_count,k,'go');
% % Show the results in a figure
% imshow(err_count,[0 nr_of_classes-1],'InitialMagnification','fit')
% hold on;
% title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);
% 
% % this is only correct for the first question
% scaled_data=samples*data;
% plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
% plot(scaled_data(101:200,1),scaled_data(101:200,2),'go');

% count = 0
% for
%     if class_labels != result
%         count = count+1
%     end
% end
% 
% err = count / size(data,1)
