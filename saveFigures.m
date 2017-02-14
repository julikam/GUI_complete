function saveFigures(figure,figname)
% SAVEFIGURES saves the current figure in postript, png and mat figure
% file.
%     f = fullfile(figname);
    print(figure,'-dpsc','-r300',figname );
    print(figure,'-dpng','-r300',figname );
    savefig(figname)
