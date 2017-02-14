%getinfo.m
%reads header info and extracts wave data from ibw file
function wdata = getinfo(filename)
fid = fopen(filename);
fseek(fid,80,'bof');
type = fread(fid,1,'int16');%read type
fseek(fid,50,'cof');
x = fread(fid,1,'int32');%read width
y = fread(fid,1,'int32');%read height
n = fread(fid,1,'int32');%read no of images
if type == 2
    d = 'float32';%32 bit float
elseif type == 3
    d = 'float64';%64 bit float
elseif type == 4
    d = 'int8';%8 bit signed integer
else disp('type unknown');
end
fseek(fid,384,'bof');%start of wave data
wdata = zeros(x,y,n);%preallocate wdata array for speed
for i = 1:n
    wdata(:,:,i) = fread(fid,[x,y],d);%read wave data into 3d array
end
fclose(fid);