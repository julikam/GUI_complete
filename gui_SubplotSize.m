function [rows, columns,num_of_figures,indent] = SubplotSize(num_of_files,sample_name)
%  num_of_files=length(indices)
%  sample_name=sample_name
% Construct a questdlg with three options
choice = questdlg('Are these more than 16 graphs to review?', ...
	'Review force curves', ...
	'Yes','No','Yes');
% choice='Yes'
% Handle response
switch choice
    case 'Yes'
        
        rows = 4;
        columns = 4;
        % preallocate the variable indent    
        indent(:,1) = zeros(16,1);
        % total number of curves
        indent(:,1) = 1:16;        
        num_of_figures=HowManyFiguresToPlot(num_of_files);
    case 'No'
        prompt = {...
            'Enter number of rows (integer):',...
            'Enter number of columns (integer):'};
            dlg_title = sprintf('%d Curves to review',num_of_files);
            num_lines = [1 50];
            def = {...
                '4',...
                '4'};
            answer = inputdlg(prompt,dlg_title,num_lines,def);  
            rows = str2double(cell2mat(answer(1,1)));
            columns = str2double(cell2mat(answer(2,1)));  
        % preallocate the variable indent    
        indent(:,1) = zeros(num_of_files,1);
        % total number of curves
        indent(:,1) = 1:num_of_files; 
        % Set figure properties
        set(groot, 'defaultAxesTickLabelInterpreter','latex');
        set(groot, 'defaultLegendInterpreter','latex');
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
        annot.String = sprintf('%s',sample_name);    
        
clear prompt dlg_title num_lines def answer choise;
    
end