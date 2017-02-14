%% read height data from ".force" file
%function [himage_filt2,width,height]=ReadHeightImage_v3 (fname,datadir)
% you need to have in the same folder all the files from imaging. Both the
% JPK image files and JPK QI image files.



% flistforce = dir('*.force'); % reads all files with "force" extension.
% flistmap = dir('*.jpk-force-map') ;% reads all files with "jpk-force-map" extension.



info = imfinfo(fullfile(datadir,fnameforce));

NumOfImages=length(info); % how many tif image files included in the force file.


%finding index of measured height data in UnknownTags region in info
for i=1:length(info)
    for j=1:length(info(i).UnknownTags)
        if strcmp(info(i).UnknownTags(j).Value,'Height (measured)')==1;
            index=i;
        end
    end  
end



heightdata=imread(fullfile(datadir,fnameforce),'Index',index); 
% The line above must unfortunatelly be automatized to select the height
% image that corresponds correctly to the correct pixel resolution!
%------DONE----- with line 19-25

% imhist(heightdata)
heightdata=double(heightdata);

% find the width and the height of the JPK image
width = info(2).Width;
leng = info(2).Height;


% --------Automatized in line 51-54
% % find the multiplier value and the offset
% mult=info(2).UnknownTags(28).Value;
% offset=info(2).UnknownTags(29).Value; 

% find the multiplier value and the offset
imult=find([info(index).UnknownTags.ID]==33028);
ioffset=find([info(index).UnknownTags.ID]==33029);
mult=info(index).UnknownTags(imult).Value;
offset=info(index).UnknownTags(ioffset).Value;

% find the size of x and y scale
ixscale = find([info(1).UnknownTags.ID]==32834);
iyscale = find([info(1).UnknownTags.ID]==32835);
xscale = info(1).UnknownTags(ixscale).Value.*10^6; % in micrometers
yscale = info(1).UnknownTags(iyscale).Value.*10^6; % in micrometers

% Apply the multiplier and the offset to convert image data in um
himage = (offset + heightdata.*mult).*10.^6; 

% length(himage(1,:)); % check if the number of width pixels correspond to the correct one.
% length(himage(:,1)); % check if the number of height pixels correspond to the correct one.

%% 
% prompt = {...
%     'Figure Width:',...
%     'Figure Width:',...
%     };
%     dlg_title = 'Figure Size';
%     num_lines = 1;
%     def = {...
%         '15',...
%         '10',...
%         };
%     answer = inputdlg(prompt,dlg_title,num_lines,def);  
%     W = str2double(cell2mat(answer(1,1))); %width size of figure in centimeters
%     H = str2double(cell2mat(answer(2,1)));%height size of figure in centimeters
% % Stores the reference slope, the radius
% clear prompt dlg_title num_lines def answer;


% fig=gcf;
% fig.Units='centimeters';
% fig.Position = [10 10 W H];

% height image in micrometers
 newfigure=figure('Units', 'normalized', 'Position', [0.66 0.44 0.3, 0.33]);
subplot(1,2,1)
hold on
title('original height image')
imagesc(himage)
plot([0 width],[leng/2 leng/2],'r')
axis([0 width 0 leng])
c=colorbar;
set(gca,'FontSize',8)

% line profile

subplot(1,2,2)
hold on
grid on
title('line profile')
plot(himage(round(leng/2),:),'r')
axis square
set(gca,'FontSize',8)


%% median filtering
% Construct a questdlg with three options
% if (get(handles.checkbox1,'Value')==get(handles.checkbox1,'Max'))
%       dessert = 1;
%     guidata(hObject, handles);
% else
%     dessert = 0;
%      guidata(hObject, handles);
% end

choice = questdlg('Would you like some filtering?', ...
	'Median filtering', ...
	'Yes','No','Yes');
% Handle response
switch choice
    case 'Yes'
        disp([choice ' coming right up.'])
        dessert = 1;
    case 'No'
        disp([choice ' as you like.'])
        dessert = 0;
end

if (dessert == 1) 
    himage_filt = medfilt2(himage); % apply a simple median filtering
    % filtering artefact
    % the median filtering results in 4 zero values in each of the 4 corners of
    % the image. Below we assign instead of zero the neighbouring value for
    % plotting purposes.

    himage_filt2=himage_filt;
    himage_filt2(1,1) = himage_filt(2,1);
    himage_filt2(1,width) = himage_filt(1,width-1);
    himage_filt2(leng,1) = himage_filt(leng,2);
    himage_filt2(leng,width) = himage_filt(leng,width-1);


%     subplot(1,2,1)
%     hold on
%     title('original')
%     imagesc(himage)
%     axis([0 width 0 leng])
%     caxis([3 4])
%     set(gca,'FontSize',8)
% 
%     subplot(1,2,2)
%     hold on
%     title('median filter')
%     imagesc(himage_filt)
%     axis([0 width 0 leng])
%     colorbar
%     caxis([3 4])
%     set(gca,'FontSize',8)

else
    himage_filt2=himage;
    
%     figure;
%     hold on 
%     title('original')
%     imagesc(himage)
%     axis([0 width 0 leng])
%     caxis([min(min(himage)) max(max(himage))])
%     set(gca,'FontSize',8)
end
close (newfigure)
gui_Planefit_v4_lbl




%% Hey what's up?!

% what do you say about looking through how the filtering was done by
% comparing every original line with the new filtered one.
% for i = 1 : 50; % iterate over all lines from bottom-up
% 
% figure;
% subplot(1,2,1)
% hold on
% grid on
% set(gca,'FontSize',8)
% axis square
% plot(himage(i,:))
% plot(himage_filt(i,:),'o')
% ylabel('height (um)')
% legend('original','median filtering')
% 
% subplot(1,2,2)
% hold on
% grid on
% set(gca,'FontSize',8)
% axis square
% plot(himage(i,:)-himage_filt(i,:),'o')
% ylabel('diff')
% 
% waitforbuttonpress
% close
% end


%% clear out some variables

%clear c H W i j
