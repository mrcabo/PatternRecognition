function predicted_labels = KNN(data_points,k,data,labels) 
    predicted_labels=zeros(size(data_points,1),1);
    ind=zeros(size(data_points,1),size(data,1)); %corresponding indices (MxN)
    distance=zeros(size(data_points,1),size(data,1));
    k_nn=zeros(size(data_points,1),k);
    for test_point=1:size(data_points,1)
        for train_point=1:size(data,1)
            ts_point = data_points(test_point,:);
            tr_point = data(train_point,:);
            sqroot = (ts_point-tr_point).^2;
            distance(test_point,train_point)=sqrt(sum(sqroot));
        end
        [distance(test_point,:),ind(test_point,:)]=sort(distance(test_point,:));
    end
    k_nn=ind(:,1:k);
    for i=1:size(k_nn,1)
        majority_label = 0;
        lbl_choices = unique(labels(k_nn(i,:)'));
        label_count = 0;
        for j=1:length(lbl_choices)
            L=length(find(labels(k_nn(i,:)')==lbl_choices(j)));
            if L>label_count
                majority_label=lbl_choices(j);
                label_count=L;
            end
        end
        predicted_labels(i)=majority_label;
    end
end