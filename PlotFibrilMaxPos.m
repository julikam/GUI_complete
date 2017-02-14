% %% plot fibril with max position
% 
% prompt = {...
%     'Figure Width:',...
%     'Figure Width:',...
%     };
%     dlg_title = 'Figure Size';
%     num_lines = 1;
%     def = {...
%         '10',...
%         '15',...
%         };
%     answer = inputdlg(prompt,dlg_title,num_lines,def);  
%     W = str2double(cell2mat(answer(1,1))); %width size of figure in centimeters
%     H = str2double(cell2mat(answer(2,1)));%height size of figure in centimeters
% % Stores the reference slope, the radius
% clear prompt dlg_title num_lines def answer;

fibril_max_1=figure('Units', 'normalized', 'Position', [0.66 0.44 0.3, 0.33]);
% fig=gcf;
% fig.Units='centimeters';
% fig.Position = [10 10 W H];
subplot(1,2,1)
hold on
title('median filter & planefit')
imagesc(himage_pfit)
axis equal
axis([0 width 0 leng])
caxis([llimit ulimit])
c=colorbar;
ylabel(c,'Height (\mum)')
set(gca,'FontSize',8)


for i = 1:leng;
    h=plot(linepos(i,1),i,'.');
    h.MarkerSize = 10;
    h.Color = [153 0 76]./255;
    
end
clear h

plot([0 32],[lineprofileIndex lineprofileIndex],'-','linewidth',1.5,...
    'Color',[50 153 76]./255)

subplot(1,2,2)
title(sprintf('profile of line: %d',lineprofileIndex))
hold on
grid on
step = xscale/width;
% plot a red line to indicate the maximum position
% plot([linepos(lineprofileIndex,1) linepos(lineprofileIndex,1)],...
%     [himage_filt(lineprofileIndex,2) himage_filt(lineprofileIndex,linepos(i,1))],'r-')

% plot the profile with transverse axis in micrometers 
% h=plot(0+step:step:xscale,himage_filt2(lineprofileIndex,:),'.');
% xlabel('transverse axis (\mum)')

% plot the profile where transverse axis is the pixel 
h=plot(himage_pfit(lineprofileIndex,:),'.');
xlabel('pixel number')
axis square
h.MarkerSize = 15;
h.LineStyle = '-';
h.Color = [50 153 76]./255;
ylabel('height (\mum)')
set(gca,'FontSize',8)

plot(linepos(lineprofileIndex,1),...
    himage_pfit(lineprofileIndex,linepos(lineprofileIndex,1)),'.','MarkerSize',15,...
    'Color',[153 0 76]./255);



clear h c fig ans 
