clear all;
close all

load lab3_2.mat;
% load KNN.m;

K=7;
samples=64;
data = lab3_2;
nr_of_classes = 4;

% Class labels
class_labels = floor( (0:length(data)-1) * nr_of_classes / length(data) );

% Sample the parameter space
result=zeros(samples);
for i=1:samples
  X=(i-1/2)/samples;
  for j=1:samples
    Y=(j-1/2)/samples;
    result(j,i) = KNN([X Y],K,data,class_labels);
  end
end

% Show the results in a figure
imshow(result,[0 nr_of_classes-1],'InitialMagnification','fit')
hold on;
title([int2str(K) '-NN, ' int2str(nr_of_classes) ' classes']);

% this is only correct for the first question
scaled_data=samples*data;
plot(scaled_data(  1:100,1),scaled_data(  1:100,2),'go');
plot(scaled_data(101:200,1),scaled_data(101:200,2),'go');

% count = 0
% for
%     if class_labels != result
%         count = count+1
%     end
% end
% 
% err = count / size(data,1)

% function predicted_labels = KNN(data_points,k,data,labels) 
%     predicted_labels=zeros(size(data_points,1),1);
%     ind=zeros(size(data_points,1),size(data,1)); %corresponding indices (MxN)
%     distance=zeros(size(data_points,1),size(data,1));
%     k_nn=zeros(size(data_points,1),k);
%     for test_point=1:size(data_points,1)
%         for train_point=1:size(data,1)
%             ts_point = data_points(test_point,:);
%             tr_point = data(train_point,:);
%             sqroot = (ts_point-tr_point).^2;
%             distance(test_point,train_point)=sqrt(sum(sqroot));
%         end
%         [distance(test_point,:),ind(test_point,:)]=sort(distance(test_point,:));
%     end
%     k_nn=ind(:,1:k);
%     for i=1:size(k_nn,1)
%         majority_label = 0;
%         lbl_choices = unique(labels(k_nn(i,:)'));
%         label_count = 0;
%         for j=1:length(lbl_choices)
%             L=length(find(labels(k_nn(i,:)')==lbl_choices(j)));
%             if L>label_count
%                 majority_label=lbl_choices(j);
%                 label_count=L;
%             end
%         end
%         predicted_labels(i)=majority_label;
%     end
% end