

function [leveled_scan,height]= scalescan(scan)
%scalescan.m
%moves the image in the positive scale so that its minimum height is 0

leveled_scan=scan-min(scan(:)); %min(scan(:)) is faster than min(min(scan))
height=max(leveled_scan(:)); %idem