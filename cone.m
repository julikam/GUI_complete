%cone.m, version 1.1
%The file creates a TGT1 grating surface with a cone peaking at the centre
%of the sample. The angle of the is assumed to be 50 degrees and the height
%is taken to be equal to the scan height. The radius of the cone tip can be
%changed so that different levels of accuracy may be achieved.

function [shape,size_pixel_x,size_pixel_y] = cone(pixel_x,pixel_y,height,name_scan)
%Ask the user for the size of the scan.
prompt = {['What is the scanning range in micrometres for  ' name_scan '.ibw ?']};
dlg_title = 'Scan Size';
num_lines= 1;
def     = {'1.5'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
size_scan= (str2num(cell2mat(answer(1,1))))*1e-6; 

%Asks the user for the radius of the grating peak.
prompt = {'What is the radius of the grating tip in nanometres?'};
dlg_title = 'Grating Tip Radius';
num_lines= 1;
def     = {'5'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
peak_radius= (str2num(cell2mat(answer(1,1))))*1e-9; 

%Variables
height_cone=height;
angle_cone=50;
height_loss=(peak_radius*cosd(angle_cone/2))/(tand(angle_cone/2))+(peak_radius*sind(angle_cone/2))-peak_radius;
%Calculates the height that is lost from a perfect tip when a rounded tip 
%is used instead.
height_tip=height_cone+height_loss;%The ideal tip is derived from the required
%height of the cone (from the scan height) and the amount of height loss 
%experienced for the desired grating radius. This value is then used to
%generate the ideal cone with a perfect tip such that when the curved tip
%is added the height of the cone is equal to the scan height.

radius_cone=tand(angle_cone/2)*height_tip; %Calculates the cone radius.
shape=zeros(pixel_x,pixel_y); %initiates a flat surface of size equal to scan.
size_pixel_x=size_scan/pixel_x;
size_pixel_y=size_scan/pixel_y;
shape(floor(pixel_x/2), floor(pixel_y/2))=height_tip; % Positions the cone.
max_pixel_movement_x=floor(radius_cone/size_pixel_x); %Radius of cone divided  
%by size of a pixel to find the maximal number of pixels in line in the
%cone radius.
 max_pixel_movement_y=floor(radius_cone/size_pixel_y);
 
%Determine the limits of the cone whether it fits completely in the image
%or not. Done for each dimension and limit using the centre of the image as
%a reference.
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


curve_start_height = height_tip - ((peak_radius*cosd(angle_cone/2))/(tand(angle_cone/2)));
%Calculates the hieght at which the cone leaves from a constant gradient
%into the curved profile.

%Generates the cone
for i=limit_x_1:limit_x_2
    for j=limit_y_1:limit_y_2
        distance=sqrt(((pixel_x/2-i)*size_pixel_x)^2+((pixel_y/2-j)*size_pixel_y)^2);
        %Distance of point i,j with reference from the centre of the image.
        
        curve_height=sqrt(((peak_radius)^2)-(distance^2))-(peak_radius*sind(angle_cone/2));
        %The absolute hieght of each point of the curved tip.
        
        if distance<=radius_cone;
           shape(i,j)=(radius_cone-distance)*height_tip/radius_cone;
           %If the dstance is smaller than than the radius then the
           %constant slope of the cone is generated.
        end
                
        if distance<=peak_radius*cosd(angle_cone/2);
           shape(i,j) = curve_height + curve_start_height;
           %If the distance is smaller than the radius of the curved peak
           %radius then the curved peak is assumed.
        end
        
    end
end