function [shape,size_pixel_x,size_pixel_y] = cone(pixel_x,pixel_y,height,name_scan)
%cone.m
%Creates the ideal TGT1 surface s with a cone peaking at the center of the 
%sample. Cone with an angle of 50 degrees and height equal to the scan
%height.

height_cone=height;
angle_cone=50;

%Ask the user for the size of the scan
prompt = {['What is the scanning range in micrometer for  ' name_scan '.ibw ?']};
dlg_title = 'Scan size';
num_lines= 1;
def     = {'1.5'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
size_scan= (str2num(cell2mat(answer(1,1))))*1e-6; 

radius_cone=tand(angle_cone/2)*height_cone; %calculate the cone radius
shape=zeros(pixel_x,pixel_y); %initiates a flat surface of size equal to scan
size_pixel_x=size_scan/pixel_x;
size_pixel_y=size_scan/pixel_y;
shape(floor(pixel_x/2), floor(pixel_y/2))=height_cone; % position the cone
max_pixel_movement_x=floor(radius_cone/size_pixel_x); %radius of cone divided  
%by size of a pixel to find the maximal number of pixels in line in the
%cone radius.
 max_pixel_movement_y=floor(radius_cone/size_pixel_y);
 
%determine the limits of the cone whether it fits completely in the image
%or not. Done for each dimension and limit
if pixel_x/2-max_pixel_movement_x>=1 
    limit_x_1=pixel_x/2-max_pixel_movement_x;
else limit_x_1=1;
end

if pixel_x/2+max_pixel_movement_x<=pixel_x
    limit_x_2=pixel_x/2+max_pixel_movement_x;
else limit_x_2=pixel_x;
end

if pixel_y/2-max_pixel_movement_y>=1
    limit_y_1=pixel_y/2-max_pixel_movement_y;
else limit_y_1=1;
end

if pixel_y/2+max_pixel_movement_y<=pixel_y
    limit_y_2=pixel_y/2+max_pixel_movement_y;
else limit_y_2=pixel_y;
end

%Form the curved peak on the cone
peak_radius = 80*1e-9;
%peak_point = sqrt(((pixel_x/2)*size_pixel_x)^2+((pixel_y/2)*size_pixel_y)^2);
curve_start_height = height_cone - ((peak_radius*cosd(25))/(tand(25)));


%Generates the cone
for i=limit_x_1:limit_x_2
    for j=limit_y_1:limit_y_2
        distance=sqrt(((pixel_x/2-i)*size_pixel_x)^2+((pixel_y/2-j)*size_pixel_y)^2);

        curve_height=sqrt(((peak_radius)^2)-(distance^2))-(peak_radius*sind(25));
        
        if distance<=radius_cone;
           shape(i,j)=(radius_cone-distance)*height_cone/radius_cone;
           %shape(pixel_x/2, pixel_y/2)=height_cone;
        end
                
        if distance<=peak_radius*cosd(angle_cone/2);
           shape(i,j) = curve_height + curve_start_height;       
        end
        
    end
end