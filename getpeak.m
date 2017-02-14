function [max_x, max_y] = getpeak(scan)
%getpeak.m
%Returns the coordinates of the peak of the image

[c,i]=max(scan);
[c,max_y]=max(c);
max_x=i(max_y);