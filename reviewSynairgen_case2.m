

%% review all graphs that can create a full 4x4 grid of subplots.
k=0;
l=0;
m=1;
for j = 1 : num_of_figures;
    % Set figure properties
        
        locationBeg=num2str(1+4*k);
        locationEnd=num2str(4+4*k);
        figure('Visible','on') 
        figure1=gcf;
        figure1.Units='centimeters';
        figure1.PaperOrientation = 'landscape';
        figure1.Position = [5 1.5 29 19];
        figure1.PaperPositionMode = 'auto';
        axes('Parent',figure1,'FontSize',9);
        % add annotation to figure
        annot = annotation('textbox');
        annot.Position = [0.45,0.95,0.3,0.03];
        annot.Interpreter = 'latex';
        annot.EdgeColor = 'none';
        annot.FitBoxToText = 'on';
        annot.String = sprintf('%s, Locations: %s to %s',sample_name,locationBeg,locationEnd);
        k=k+1;
    
    for i = (1 : 16)+16*l;
    if isempty(FibrilData(fib).Retract{i,1})
        continue
    end
    
    % The function OVERVIEW_DATA2FUN is ploting the force curves of a force map
    % in a seperate figure and ASKS from the user to wirte "y" or "n" if the
    % graph is to be taken into account for analysis or not, respectively.
    
    str{i,1} =  overview_data2fun(rows,...
                                   columns,...
                                      -FibrilData(fib).Approach{i,1}(:,1),...
                                       FibrilData(fib).Approach{i,1}(:,2),...
                                      -FibrilData(fib).Retract{i,1}(:,1),...
                                       FibrilData(fib).Retract{i,1}(:,2),...
                                       indent(m,1)...
                                       );
    
    m=m+1;

    end
    l=l+1; %to iterate within the mapsData from 1 to number of files.
    m=1; %to iterate within the mapsData from 1 to number of files.
    
    legend('Load','Unload','Location','best')
    xlabel('Height ($\mu$m)','FontSize',11,'Interpreter','latex');
    ylabel('Deflection ($\mu$m)','FontSize',11,'Interpreter','latex');
    f2=fullfile(resultsFolder,'overview',sprintf('%s_Loc%sto%s.pdf',sample_name,locationBeg,locationEnd));
    print(figure1,'-dpdf','-r300',f2 );
    close
    
end