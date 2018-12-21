function [prototypes, trnE] = cvtrainlvq1(traininset,labels, prototypes, learning_rate, threshold, prototype_class)
trnE = [];
keep = 1;
limit = 10000;
count = 0;
while keep==1 && count<limit
    err = 0;
    for j = 1:length(traininset)
        xi = traininset(j,:);
        d = zeros(size(prototypes,1),1);
        for k = 1:size(traininset,2)
            for m = 1:length(d)
                d(m) = d(m) + (prototypes(m,k)-xi(k))^2;
            end
        end
        [M,I] = min(d);
        if prototype_class(I)==labels(j)
            psi = 1;
        else
            psi = -1;
            err = err + 1;
        end
        prototypes(I,:) = prototypes(I,:) + learning_rate*psi*(xi-prototypes(I,:));
    end
    trnE = [trnE;err/length(labels)];
    if length(trnE) > 100
        variance = var(trnE(length(trnE)-10:length(trnE)));
        if variance < threshold
            keep = 0;
        end
    end
    % Reshuffle data
    p = randperm(length(traininset));
    traininset = [traininset(p,1), traininset(p,2)];
    labels = labels(p);
    count = count +1;
    
%     hold on;
%     scatter(prototypes(1,1),prototypes(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
%     hold on;
%     scatter(prototypes(2,1),prototypes(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
%     hold on;
%     scatter(prototypes(3,1),prototypes(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')
end
err
end

