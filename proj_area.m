function [depth_num, projected_area] = proj_area(shape,image_x_axis)
% shape=probe_tip_tgt1_run12_0002;
% image_x_axis = 1.5e-6
% close all
% figure;
% meshc(shape)

% % shape=probe_tip;
% % image_x_axis=Scansizex*10^-6;

% % convert to gray scale
I_gray=mat2gray(shape);
% 
% % mask
% % At what threshold of the maximum height do you want to mask the data

y=0.1;
I_mask = (I_gray > y); 
boundary=bwboundaries((I_gray > y));



figure;
subplot(1,2,2)
imshow(I_mask)
title('Binary mask')
subplot(1,2,1)
imshow(I_gray)
title('Image & Masked area')

hold on
p=patch(boundary{1}(:,2),boundary{1}(:,1),'g','EdgeColor', [0.8 1 0.4]);
set(p,'FaceAlpha',0.2)
hold off


%% steps

hmax = max(max(shape)).*10^9; % NANOMETERS
hmin = min(min(shape)).*10^9; % NANOMETERS

h_abs = hmax-hmin; % absolute height NANOMETERS

prompt = {...
    'Step size (in nanometer):'};
    dlg_title = 'Input data';
    num_lines = 1;
    def = {'1'};
    answer = inputdlg(prompt,dlg_title,num_lines,def);  
    step = str2double(cell2mat(answer(1,1)));
% Stores the reference slope, the radius
clear prompt dlg_title num_lines def answer;
% step = 1; % 1 nanometer step
% I_tip_bin=(I_gray > y);
% I_tip = I_gray.*I_tip_bin;





pixel_step = step./h_abs;
clear depth_points

depth_points(:,1) = 1:-pixel_step:y;

%% estimate area with BWAREA matlab function.
% clear area_bin
k=1;
for i=1:-pixel_step:y;
 
    area_bin(k,1) = bwarea((I_gray > i));
 
    k=k+1;
end


size_pixel_x=image_x_axis/length(shape); % in METERS
area_per_pixel=size_pixel_x.^2; % in SQUARE METERS

depth_num(:,1)= 0:step:(1-y)*h_abs; % in NANOMETERS

projected_area=area_per_pixel.*area_bin; % in SQUARE METERS

clear steps k pixel_step depth_points y area_bin
