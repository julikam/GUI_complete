%% find directory of header properties
function [vDefldir ,segHeaderDir ,heightdir] = findloaddir_FVM(zipContents,index,n)
% n=length(zipContents);
% index=indices(j,1);
% vDeflection.dat directory

string = sprintf('index/%d/segments/0/channels/vDeflection.dat',index);
for cell = 1 : n;   
   isequal=strcmp(zipContents{cell,1},string);
   if (isequal == 1);
        vDefldir = zipContents{cell,1};
   elseif isequal == 0;
        continue
   end

end

% segment-header.properties directory
string = sprintf('index/%d/segments/0/segment-header.properties',index);
for cell = 1 : n;   
   isequal=strcmp(zipContents{cell,1},string);
   if (isequal == 1);
        segHeaderDir = zipContents{cell,1};
   else 
        continue
   end

end


% capacitiveSensorHeight.dat directory
string = sprintf('index/%d/segments/0/channels/capacitiveSensorHeight.dat',index);
for cell = 1 : n;   
   isequal=strcmp(zipContents{cell,1},string);
   if (isequal == 1);
        heightdir = zipContents{cell,1};
   else 
        continue
   end

end