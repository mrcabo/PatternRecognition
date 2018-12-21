function [prototypes, tstE] = cvtestlvq1(testset,labels, prototypes, learning_rate, threshold, prototype_class)
    tstE = [];
    keep = 1;
    limit = 10000;
    count = 0;
    while keep==1 && count<limit
        testerr = 0;
        for j = 1:length(testset)
            xi = testset(j,:);
            d = zeros(size(prototypes,1),1);
            for k = 1:size(testset,2)
                for m = 1:length(d)
                    d(m) = d(m) + (prototypes(m,k)-xi(k))^2;
                end
            end
            [M,I] = min(d);
            if prototype_class(I)==labels(j)
                psi = 1;
            else
                psi = -1;
                testerr = testerr + 1;
            end
            prototypes(I,:) = prototypes(I,:) + learning_rate*psi*(xi-prototypes(I,:));
        end
        tstE = [tstE;testerr/length(labels)];
        if length(tstE) > 100
            variance = var(tstE(length(tstE)-10:length(tstE)));
            if variance < threshold
                keep = 0;
            end
        end
        % Reshuffle data
        p = randperm(length(testset));
        testset = [testset(p,1), testset(p,2)];
        labels = labels(p);
        count = count +1;
        
    %     hold on;
    %     scatter(prototypes(1,1),prototypes(1,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
    %     hold on;
    %     scatter(prototypes(2,1),prototypes(2,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','r')
    %     hold on;
    %     scatter(prototypes(3,1),prototypes(3,2),150,'MarkerEdgeColor',[.5 .5 .5],'MarkerFaceColor','g')
    end
    testerr
end

