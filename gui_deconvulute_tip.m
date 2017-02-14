function gui_deconvulute_tip( ImDir )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
gui_1_1_readjpk_single_file
%% planefit function aufgedröselt

image = varname{1,1};
 varname{1,1} = planefit_tgt1(varname{1,1});

 %image=varname{1,1};
leng = length(image);
width = length(image);

Igray = mat2gray(image); %convert to gray scale

% select ROI to mask

figure;
subplot(1,2,1)
hold on
title('median filter')
% imagesc(himage_filt2)
imagesc(Igray)
axis([0 width 0 leng])
axis square
% colorbar
caxis([0 1])
set(gca,'FontSize',8)
%create mask of interest
maskROI=roipoly;
% Invert mask
maskROI = (maskROI ==0);
%% plot the mask region of interest

subplot(1,2,2)
hold on

title('mask')
imagesc(flip(maskROI,1))
axis([0 width 0 leng])
axis square
caxis([0 1])
set(gca,'FontSize',8)



backgroundI=image.*maskROI;


%%
%prealocate matrices and vectors for planefit
%matrix for x-coordinate vector
A=zeros(leng,width);
%matrix for y-coordinate vector
B=zeros(leng,width);
%matrix including height data of background
C=backgroundI;
%matrices for creating vectors including x,y coordinates of original image
%size
%matrix including x positions
D=zeros(leng,width);
%matrix including y positions
E=zeros(leng,width);
%matrix including height values of the fitted plane
F=zeros(leng,width);
%filling matrix with the specific x and y values
for i=1:leng
      A(i,:)=1:width;
      B(i,:)=i*ones(1,width);
      D(i,:)=1:width;
      E(i,:)=1:width;
      F(i,:)=i*ones(1,width);
end

%apply mask on all the matrices
A=A.*maskROI;
B=B.*maskROI;

%creating vectors out of the matrices
xx=reshape(A',[numel(A),1]);
yy=reshape(B',[numel(B),1]);
zz=reshape(C',[numel(C),1]);
xo=reshape(E',[numel(E),1]);
yo=reshape(F',[numel(F),1]);
zo=zeros(leng*width,1);

%deleting all positions where height was set zero from masking
X=[xx,yy,zz];
X(~any(X,2),:)=[];  %rows where x,y,z are empty should be taken out
%rebuild xx,yy,zz vectors of Matrix X
xx=X(:,1);
yy=X(:,2);
zz=X(:,3);

%plnefitting by fit a linear function to each data line of background image
linefit=D; %this matrix should constist of flattened lines
for l=1:leng
   ins=find(yy==l,1,'first');
   inl=find(yy==l,1,'last');
   P=polyfit(xx(ins:inl,1),zz(ins:inl,1),1);
   linefit(l,:)=polyval(P,D(l,:));
end
image_pfit=image-linefit;

%%
figure;

subplot(1,2,1)
hold on
grid on
% plot original image
mesh(image,'facealpha',0.6);
axis tight
axis square
view([-32,20])
% plot original image
mesh(linefit,'FaceColor',[0.5 0.5 0.3],'FaceAlpha',0.3,'EdgeColor','none');
colormap jet
set(gca,'FontSize',8)
zlabel('Height (m)')

subplot(1,2,2)

hold on
grid on
% plot planefited image
mesh(image_pfit,'facealpha',0.8);
axis tight
axis square
colormap jet
view([-32,20])
set(gca,'FontSize',8)
zlabel('Height (m)')

waitforbuttonpress
close all


clear maskROI Igray backgroundI leng width



%% 


for i = 1:length(name_list) %loop through all the ibw files
   
%     if size(varname,3)<4
%         disp(['Error! Channel 4 is missing in ' name_list{i} '.ibw']);
%         disp('Please ensure that the Z Sensor data is recorded on channel 4');
%         disp('Proceeding to next file');
%     else
        [z, height]=scalescan(varname{i,1}); %put the ZSensor scan image in the positive range
        pixelz_x=size(z,1);
        pixelz_y=size(z,2);
        [s,size_pixel_x,size_pixel_y] = cone(pixelz_x, pixelz_y, height,filename); %generate the perfect cone of TGT1
        [max_x, max_y] = getpeak(s); %find location of the tip peak
        pixels_x=size(s,1);
        pixels_y=size(s,2);

        v = genvarname(['probe_tip']);
        g = strcat(name_list{i},'.jpk');
        eval([v ' = minimiseW(z,s,pixelz_x,pixelz_y,pixels_x,pixels_y,max_x, max_y);']); %calculate the tip geometry
%         writedata; %write the tip in a new ibw file
%     end
end



clear d fid g height i max_x max_y n name_list pixels pixelz probe_file...
    s tip type v varname wdata x y z pixels_x pixels_y pixelz_x pixelz_y
    %clear temporary variables
end