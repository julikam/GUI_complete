%readjpk.m
%creates variable 'filename' for each jpk file in current directory
%containing the height data
% -------------------------- FOR MULTIPLE FILES ---------------------------
% !!!!!!!!!!!!UNCOMMENT LINE BELOW TO ANALYZE ALL AFM TIPS IN ONE GO!!!!!!!!!!!!
% flist = dir('*.jpk');%get file list ******** % FOR MULTIPLE FILES ********
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% varname=cell(length(flist),1); ********  FOR MULTIPLE FILES ********
% ---------------------------- FOR SINGLE FILE ----------------------------
varname=cell(1,1);
i=1;    
    info=imfinfo(ImDir);
    k=1;
    for j = 2:size(info,1);
        istring(k,1)=find([info(j).UnknownTags.ID]==32851);     
        s_name=info(j).UnknownTags(istring(k,1)).Value;
%% ONLY THE MEASURED HEIGHT RETRACE IMAGES ARE STORED FOR ANALYSIS
% OLD version 
% s1: is a character of the tagged image which specifies the image channel
% and the image direction i.e. trace or retrace.
s1={['channel.name : capacitiveSensorHeight' char(10) 'channel.type : channel' char(10) 'retrace : true' char(10) 'type : channel-retrace' char(10) '']};
% NEW version
% By NEW version we mean the JPK Software Version 5.0.72 which was updated
% after the hard drive replacement. With this version the tags are changed.
% The measurd height and image is located in a different position of the
% UnkwownTag.
% s2: is a character as is in the newer version that speficies the image
% channel and the imaging direction, i.e. trace or retrace.
s2={['channel.name : measuredHeight' char(10) 'channel.type : channel' char(10) 'retrace : true' char(10) 'type : channel-retrace' char(10) '']};
% You will probably need this line for a further updated version!     

        if isequal(s_name,s1{1,1})==1;
            pos(i,1)=j;  
        
        elseif isequal(s_name,s2{1,1})==1;
            pos(i,1)=j;
    
        end
        k=k+1;
    end
% end ********  FOR MULTIPLE FILES ********

%%
% i=3
% for i = 1:length(flist);********  FOR MULTIPLE FILES ********

      data=double(imread(ImDir,pos(i,1)));  %read height data from each file
      

      
      
      %finding the scansize and the image pixelsize
      %scansize
       iscansizex=find([info(1).UnknownTags.ID]==32834); % location of the scan size in um
       iscansizey=find([info(1).UnknownTags.ID]==32835); % location of the scan size in um
       Scansizex=info(1).UnknownTags(iscansizex).Value*10^6; %in um 
       Scansizey=info(1).UnknownTags(iscansizey).Value*10^6; %in um
      %pixelsize
%        pixels_x = info(2).Width; 
%        pixels_yt = info(2).Height;     
      
      %finding the multiplier and the offset value
      imult=find([info(pos(i,1)).UnknownTags.ID]==33028); 
      ioffset=find([info(pos(i,1)).UnknownTags.ID]==33029);    
      
      
      mult=info(pos(i,1)).UnknownTags(imult).Value; %calls multiplier of the jpk file
      offset=info(pos(i,1)).UnknownTags(ioffset).Value;   %calls offset of the jpk file 
      himage = (offset + data.*mult); %Calculate real height data by applying offset and mult to the var data
            
     
            
    s = strrep(ImDir,'.jpk','');%define variable 'filename'
    name_list(i,1)=cellstr(s);
    varname{i,1}=himage;
% end;********  FOR MULTIPLE FILES ********
clear flist i himage s  imult ioffset iscansizex iscansizey ...
data offset mult info s1 s2 pos ans istring j k s_name ext
%clears temporary variables

