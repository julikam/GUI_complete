function tip=minimiseW(z,s,pixelz_x,pixelz_y,pixels_x,pixels_y,max_x,max_y)
%minimiseW.m
%Minimises the w function w(x,y,x',y')=z(x',y')-s(x-x',y-y') to erode the
%image. Returns the real image of the sample or the tip shape depending on
%the input s. To obtain the tip shape, s must be the sample. To
%obtain the eroded image, s must be the tip upside down.

tip=ones(pixelz_x,pixelz_y); %creates the empty image array

h = waitbar(0,'Please wait, Processing...');

%loops over all the elements and find the minimum value of w and allocate it
for j=1:pixelz_y %loops over points in image output
    waitbar(j/pixelz_y);
    s_ymin=max(-j,-max_y); %determines the allowed range for tip scanning
    s_ymax=min(pixels_y-max_y,pixelz_y-j)-1; %idem
    for i=1:pixelz_x %loops over points in other direction in image output
        s_xmin=max(-max_x,-i); %determines allowed range for tip scanning
        s_xmax=min(pixels_x-max_x,pixelz_x-i)-1; %idem
        %need to add 1 for matrix starts on row 1 and not 0
        minimum=z(i+s_xmin+1,j+s_ymin+1)-s(s_xmin+max_x+1,s_ymin+max_y+1);
        for k=s_xmin:s_xmax %loop over points in tip
            for l=s_ymin:s_ymax %idem
                %need to add 1 for matrix starts on row 1 and not 0
                temp=z(i+k+1,j+l+1)-s(k+max_x+1,l+max_y+1); %calculate w.
                minimum=min(temp,minimum); %checks if w is minimum
            end
        end
        tip(i,j)=minimum; %allocates the minimum value
    end
end
close(h);