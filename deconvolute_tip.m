%deconvolute_tip.m
%Deconvolutes an image of TGT1 grating to obtain the AFM tip using an
%envelope algorithm. Goes through all the ibw files in the folder and
%calculates the tip shape. The tip shape is then saved in a new ibw file
%called "probe_tip_NAME OF THE SCAN.ibw"
%The ibw files used to find the tip is required to have a ZSensor record as
%channel 4
%! ! !ONLY THE ZSENSOR IMAGE IN THE NEW FILE REPRESENTS THE TIP ! ! !

%requires readibw.m, getinfo.m, scalescan.m, cone.m, getpeak.m,
%minimiseW.m, writedata.m

% readibw;%scan the folder for ibw files, creates the corresponding variables and the name_list 
clear


readjpk_single_file; % create a double variable of the height measured.

varname{1,1} = planefit_tgt1(varname{1,1});


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