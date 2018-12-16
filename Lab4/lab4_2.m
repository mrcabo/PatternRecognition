% clear all
close all
% Getting an image
im	=	imread('Cameraman.tiff');	
%FIND	EDGES	
BW	=	edge(im,'canny');	
%COMPUTE	THE	HOUGH	TRANSFORM	
[HS,T,R] = hough(BW);	

% Initializing parameters
%we  decided to -90 to 90 degree value for theta based on the slides 
theta_arr = (-90:89);
theta_min = min(theta_arr);
theta_max = max(theta_arr);
[y,x] = find(im);
% y = y - 1;
% x = x - 1;
%rho = cell(1,numel(x));
diag_img= diag(im);
rho_min = -length(diag_img);
rho_max = length(diag_img)-1;
% rho_array = (rho_min:rho_max);
rho_array = (-361:361);
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
%         for i = 1:
%             thetai = thetai + 1;
%             for j = rho_min:rho_max
%                 rhoj = rohj+1;
%                 H(thetai,rhoj) = H(thetai,rhoj)+1;
%             end
%         end
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
f2=figure
% imshow(HS)
imagesc(imadjust(rescale(H),'XData',theta_arr,'YData',rho_array))
xlabe('\theta'),ylable('\rho');
axis on, axis normal, hold on;