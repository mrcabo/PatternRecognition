close all;

filename = './Data/chess.jpg';
I = rgb2gray(imread(filename));
BW = edge(I,'canny');
f1 = figure;
imshow(BW)

f2 = figure;

[H,T,R] = hough(BW);
P = houghpeaks(H,15,'threshold',ceil(0.3*max(H(:))));
imagesc(imadjust(rescale(H)),'XData',T,'YData',R)
title('S3736555 & S3559734');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
x = T(P(:,2));
y = R(P(:,1));
plot(x,y,'s','color','red')

f3 = figure;
figure(f3)
imshow(I)
title('S3736555 & S3559734');
rho = R(P(:,1));
theta = T(P(:,2));
for i = 1:15
    hold on;
    r = rho(i);
    angle = theta(i);
    [x,y] = size(I);
    angle = deg2rad(angle);
    if sin(angle)==0
        line([r r], [0,y],'Color','red')
    else
        line([0,y],[r/sin(angle),(r-y*cos(angle))/sin(angle)],'Color','red')
    end
end
