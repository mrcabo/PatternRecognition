close all

filename = './Data/Cameraman.tiff';
c = imread(filename);
edges = edge(c,'canny');
hc = hough(edges);
[H,T,R] = hough(edges);

% f1 = figure;
% % Example hough
% [H,T,R] = hough(edges,'RhoResolution',0.5,'Theta',-90:0.5:89);
% % subplot(2,1,1);
% % imshow(c);
% % title(filename);
% % subplot(2,1,2);
% imshow(imadjust(rescale(H)),'XData',T,'YData',R,'InitialMagnification','fit');
% title('Hough transform of Cameraman.tiff');
% xlabel('\theta'), ylabel('\rho');
% axis on, axis normal, hold on;
% colormap(gca,hot);

f1 = figure;
imagesc(imadjust(rescale(H)),'XData',T,'YData',R)
title('S3736555');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;


hcTh = hc;
hcTh(hcTh < 0.999 * max(hc(:))) = 0;

[H,T,R] = hough(edges);
Npeaks = 5;
P  = houghpeaks(H,Npeaks);
plot(T(P(:,2)),R(P(:,1)),'s','color','red');

f2 = figure;
figure(f2)
imshow(c)
title('S3736555');
rho = R(P(:,1));
theta = T(P(:,2));
for i = 1:1
    hold on;
    r = rho(i);
    angle = theta(i);
    [x,y] = size(c);
    angle = deg2rad(angle);
    if sin(angle)==0
        line([r r], [0,y],'Color','red')
    else
        line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
    end
end
hold on;

