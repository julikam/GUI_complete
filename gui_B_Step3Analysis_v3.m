%% Define directory where data is stored and create analysis directory





% %% READ and perform MEDIAN filter if needed 
% % for k=1:length(flistforce);% iterate over the number of force maps
% fnameforce=flistforce(fib).name;
% fnamemap=flistmap(fib).name;
%     
% ReadHeightImage_v3 %gives back himage_filt2 needed for Planefit_v3
% close all
% % OUTPUT: HIMAGE_FILT
% %% planefit
% Planefit_v4_lbl
% 
% close all
% %% pos of max points
% MaxPixelIndeces_v3
% 
% close all

%% Plot the line profile with max position indication

lineprofileIndex = round(width/4);
% For example curves plot the fibril height image and a cross section
% indicating the maximum point and each location.
% Save the current figure in the FIBRIL_0X subfolder of the RESULTS folder.
    PlotFibrilMaxPos
    

    figname=fullfile(resultsFolder,(sprintf('EGMaxFl_0%d_line%d',fib,lineprofileIndex)));
    f = fullfile(figname);
    gui_saveFigures(gcf,f,handles.text14); % save these figures for post process analysis.

 close (filtred_fibril_3d)
 close (fibril_max_1)
 close (figure_max_index)
%     close


%% clearing up the workspace a bit

clear C A B backgroundI choise D dessert E F i Igray imult index ioffset...
      ixscale iyscale j K lineNumMax Linepos lineprofileIndex maskROI...
      Max mult O offset plane step x xo xx y yo yy zo zz choise f...
      filename P
  
save(fullfile(datadir,'steps1to3_analysis.mat')) 
%% step 4 analysis
%Unzipping the indices of the map file consisting corresponding to the
%highest points
% Create a temp folder.
% tempFiledirectory=sprintf('%s%sAnalysis%stemp',datadir,'\','\');

% mkdir(tempFiledirectory);

zipContents = listzipcontents(fullfile(datadir, fnamemap));



% mkdir(datadir,sprintf('temp_f%d',fib)); %create a temporary folder to store the dat files for analysis.

% tempdir = uigetdir(datadir,'Where to unzip the contents for the fibril?');
UnzipForceIndices_v3(datadir,system_chosen,indices,fnamemap,tempdir{fib,1});



%% Analyze every force curves and then remove the index folder completely.

    headerDir = findheaderDirectory_FVM(zipContents);
    MaiheaderDir = findMainHeader_FVM(zipContents);

    Fibril(fib).FibrilName=flistmap(fib).name;
    Fibril(fib).HeightData=heightdata;
    Fibril(fib).HeightMicrons=himage;
    Fibril(fib).HeightFiltered=himage_filt2;
    Fibril(fib).HeightPlanefit=himage_pfit;
    Fibril(fib).Xaxis = xscale;
    Fibril(fib).Yaxis = yscale;
    
  
% end
