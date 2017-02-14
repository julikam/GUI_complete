function [figure2]=setfigureoptions(width,height)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%% SWELLING 
figure2=figure('Visible','on');
% Sets size of figure in centimeters
figure2 = gcf;
set(figure2, 'NextPlot', 'replace');
figure2.Units='centimeters';
figure2.Position = [10 10 width height];
figure2.PaperUnits='centimeters';
figure2.PaperPosition = [10 10 width height];
% Automatically places figure in center of an A4 paper
figure2.PaperPositionMode = 'auto';
% Sets the size of the paper to the same size of the figure.
figure2.PaperSize = [width height];
% scrsz = get(0,'ScreenSize');
% set(figure1, 'Position',[scrsz(3)-1000 scrsz(4)-800 scrsz(3)/3 scrsz(4)/2]);
% set(figure2, 'units', 'centimeters', 'pos', [32 10 8 8])

% axes1 = axes('Parent',figure2,'FontSize',9,'FontName','Times');
% 
axes1 = axes('Parent',figure2,'FontSize',9);

ax=gca;
ax.GridLineStyle = '--';
grid 'on';

hold(axes1,'all');
box(axes1,'on');

end

