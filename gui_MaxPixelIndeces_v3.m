% This script finds the pixel indices of the highest points of a specific
% fibril taking the himage_filt data of the readHeightImage script


%Finding maximum positions of each row of himage_filt
%the "2" is an Input to search each row and not column

Max=max(himage_pfit,[],2); 

%These values have to be 


%prealocate vector which should in the end include all indixes of maximum
%pixels each row

indices=zeros(leng,1);  %indeces for the highest point each row for jpk dat
linepos=zeros(leng,1);  %rowwise number of highest point for matlab image
lineNumMax=zeros(leng,1); %rowwise number of highest points are saved here

%going through each row and finding the pixel which has the max height as
%the JPK software indices the pixels starting from the very left bottom
%corner going to the right and in the second line back to the left and so
%on. So we have to differ between rows having even and the ones with not 
%even rownumbers to get the correct index.
figure_max_index=figure('Units', 'normalized', 'Position', [0.66 0.44 0.3, 0.33])
hold on
title('median filter & planefit')
imagesc(himage_pfit)
axis normal
axis([0 width 0 leng])
c=colorbar;
ylabel(c,'Height (\mum)')
llimit = 0;
ulimit = round...
    (max(max(himage_pfit)) + abs(min(min(himage_pfit)))...
    ,2);
caxis([llimit ulimit])
set(gca,'FontSize',8)

for j=1:leng; % line or row
    i=j-1;
    if mod(j,2)==1  %not even row numbers i.e. 1,3,5,7...
        Linepos =find(himage_pfit(j,:)==Max(j,1));
        lineNumMax(j,1)=length(Linepos);
        %if there is an even amount of highest points the first of the
        %two middle values should be taken if there is an uneven amount of
        %highest points the middle value should be taken as linepos ==>
        linepos(j,1)=Linepos(1,round(length(Linepos)/2));
        %The index for the JPK data is calculated in the following line
        indices(j,1)=i*width+linepos(j,1);
    
    elseif mod(j,2)==0  %even row numbers i.e. 0,2,4,6...
        Linepos =find(himage_pfit(j,:)==Max(j,1));
        lineNumMax(j,1)=length(Linepos);
        %if there is an even amount of highest points the first of the
        %two middle values should be taken if there is an uneven amount of
        %highest points the middle value should be taken as linepos ==>
        linepos(j,1)=Linepos(1,round(length(Linepos)/2));
        %The index for the JPK data is calculated in the following line
        indices(j,1)=i*width+(width+1-linepos(j,1));
    end
    plot(Linepos,j,'ro')
    plot(linepos(j,1),j,'bx')
end
legend('all maximum','the chosen ones','location','southeast');
%plotting height image to show if correct points were taken


resultsFolder=sprintf('%s_0%d',(fullfile(datadir,'Analysis','results','fibril')),fib);
mkdir(resultsFolder)
filename=fullfile(resultsFolder,(sprintf('MaxPoints_fibril_0%d',fib)))

f = fullfile(filename);
 print(gcf,'-dpsc','-r300',f );
 print(gcf,'-dpng','-r300',f );
savefig(f)

% resultsFolder=sprintf('%s%s_0%d',datadir,'\Analysis\results\fibril',fib);
% mkdir(resultsFolder)
% filename=sprintf('%s%sMaxPoints_fibril_0%d',resultsFolder,'\',fib);
% f = fullfile(filename);
% print(gcf,'-dpsc','-r300',f );
% print(gcf,'-dpng','-r300',f );
% savefig(f)

clear c



