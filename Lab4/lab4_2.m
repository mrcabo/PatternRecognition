% clear all
close all
% Getting an image
filename = './Data/Cameraman.tiff';
im = imread(filename);
%FIND	EDGES	
BW = edge(im,'canny');
f1 = figure;
imshow(BW)
%COMPUTE	THE	HOUGH	TRANSFORM	
[HS,T,R] = hough(BW);	

% Initializing parameters
%we  decided to -90 to 90 degree value for theta based on the slides 
theta_arr = (-90:89);
theta_min = min(theta_arr);
theta_max = max(theta_arr);
[y,x] = find(BW);

diag_img= diag(BW);
rho_min = -length(diag_img);
rho_max = length(diag_img);
rho_array = (rho_min:rho_max);
% rho_array = (-361:361);
H = zeros(length(theta_arr),length(rho_array));

% Calculating the Hough Transform
for i = 1: numel(x)
    thetai= 0;
    for theta = theta_arr
        thetai = thetai + 1;
        rho = x(i)*cos(deg2rad(theta)) + y(i)*sin(deg2rad(theta));
        rho = round(rho);
        rho_index = find(rho_array==rho,1);
        H(thetai,rho_index) = H(thetai,rho_index)+1;
    end
end


H = transpose(H);

% Creating the Hough Space as an Image
% for i = 1:numel(x)
%     rho{i} = rho{i} + D; % mapping rho from 0 to 2*sqrt(2)
%     rho{i} = floor(rho{i}) + 1;
%     for j = 1:numel(rho{i})
%         HS(rho{i}(j),j) = HS(rho{i}(j),j) + 1; 
%     end
% end
f2 = figure
% imshow(HS)
imagesc(imadjust(rescale(H)),'XData',theta_arr,'YData',rho_array)
xlabel('\theta'),ylabel('\rho');
axis on, axis normal, hold on;

f3 = figure;
imagesc(imadjust(rescale(HS)),'XData',T,'YData',R)
xlabel('\theta'),ylabel('\rho');
axis on, axis normal, hold on;