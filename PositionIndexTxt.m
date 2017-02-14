%% saves the indices but with the "index/" text attached to it

% fid=fopen('positionIndex.txt','wt');
% for i=1:leng;
%     positionIndexDir=sprintf('index/%d',(indices(i,1)));
%     fprintf(fid,'%s\n',positionIndexDir);
%     %clear positionIndexDir
% end
% 
% fclose(fid);
% 

%% saves only numbers of indices in a txt file
fid=fopen('positionIndex.txt','wt');
for i=1:leng;
    positionIndexDir=sprintf('%d',indices(i,1));
    fprintf(fid,'%s\n',positionIndexDir);
    %clear positionIndexDir
end

fclose(fid);