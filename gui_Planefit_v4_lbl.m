%% planefit
% Convert to grayscale
Igray = mat2gray(himage_filt2);



% plot the grayscale

% figure;

subplot(1,2,1)
hold on
title('median filter')
% imagesc(himage_filt2)
imagesc(Igray)
axis([0 width 0 leng])
% colorbar
caxis([0 1])
set(gca,'FontSize',8)

%create mask of interest
maskROI=roipoly;

% msgbox('Select the Polygon in a way that have the whole fibril in it')

% playMusic % just some fun to spirit up from the dull analysis!

% Invert mask
maskROI = (maskROI ==0);

%% plot the mask region of interest

subplot(1,2,2)
title('mask')
imagesc(flip(maskROI,1))
axis([0 width 0 leng])
caxis([0 1])
set(gca,'FontSize',8)


%%

backgroundI=himage_filt2.*maskROI;
% 
% figure;
% subplot(1,2,1)
% hold on
% title('background image')
% set(gca,'FontSize',8)
% imagesc(backgroundI)
% axis([0 width 0 leng])
% % colorbar
% caxis([min(min(backgroundI)) max(max(backgroundI))])
% 
% 
% subplot(1,2,2)
% hold on
% title('height image')
% imagesc(himage_filt2)
% axis([0 width 0 leng])
% % colorbar
% caxis([min(min(himage_filt2)) max(max(himage_filt2))])
% set(gca,'FontSize',8)

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
himage_pfit=himage_filt2-linefit;


%%
% %planefitting by solving the linear problem zz=[K(1) K(2) K(3)]*[xx yy O]
% O=ones(size(xx));
% K=[xx yy O]\zz;
% 
% %creating plane over whole image size by using K(1),K(2),K(3) on all xo,yo
% %points
% for i=1:numel(zo)
%     zo(i,1)=K(1)*xo(i)+K(2)*yo(i)+K(3);
% end
% %reshapeing vector to matrix
% plane=(reshape(zo,[width,leng]))';
% %This matrix can now be substracted from the original himage_filt matrix to
% %get planefitted fibril
% himage_pfit=himage_filt2-plane;
% 
% 

%% for plotting filtered fibril and plan in one 3d fig uncomment to show

filtred_fibril_3d=figure('Units', 'normalized', 'Position', [0.66 0.44 0.3, 0.33]);

subplot(1,2,1)
hold on
grid on
% plot original image
surf(himage_filt2,'EdgeColor',[0.5 0.5 0.5],'facealpha',0.6);
axis square
view([-32,20])
% plot original image
surf(linefit,'FaceColor',[0.5 0.5 0.3],'FaceAlpha',0.3,'EdgeColor','none');
set(gca,'FontSize',8)

subplot(1,2,2)

hold on
grid on
% plot planefited image
surf(himage_pfit,'EdgeColor',[0.5 0.5 0.5],'facealpha',0.8);
axis square
view([-32,20])
set(gca,'FontSize',8)




