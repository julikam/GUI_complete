 function [input_answer] = overview_data2fun(rows,columns,...
                            approach_x,approach_y,...
                            retract_x,retract_y,...
                            indent)
% OVERVIEW_DATA2FUN
% INPUTS: rows and columns which are used to define the position of the
% subplots. Approach and retract data as well as the number of the indent.
% OUTPUT: Asks the user to whether the ploted graph is to be used for
% analysis or not. 
%% plotting all curves in one figure and save as pdf in A4 Landscape.

subplot(rows,columns,indent);

% plot loading: in micrometers by scaling 10^6
plot(approach_x,approach_y)
% to plot the unloading curve in same subplot
hold on;
grid on;
% plot unloading: in micrometers by scaling 10^6
plot(retract_x,retract_y)
scatter(0,0,'Filled')

ax=gca;

% prompt = 'Do you want this graph? [y/n]';
% input_answer =  input(prompt,'s');
% 
input_answer=questdlg('Do you want this graph?','Graph review','Yes','No','Yes')


% number above subplot to identify index of indent 

if isequal(input_answer,'Yes');
    % Set the remaining axes properties  
    ax.XColor = 'b';
    ax.YColor = 'b';
        
elseif isequal(input_answer,'No');
    % Set the remaining axes properties  
    ax.XColor = 'r';
    ax.YColor = 'r';
        
    
else 
    
    mode = struct('WindowStyle','nonmodal',... 
       'Interpreter','latex');
    errordlg('Give only "y" or "n" as an answer',...
    'Answer Error', mode);
    
%     prompt = 'Do you want this graph? [y/n]';
%     input_answer =  input(prompt,'s');

    input_answer=questdlg('Do you want this graph?','Graph review','Yes','No','Yes')

    
    if isequal(input_answer,'Yes');
        % Set the remaining axes properties  
        ax.XColor = 'b';
        ax.YColor = 'b';
        
    elseif isequal(input_answer,'No');
        % Set the remaining axes properties  
        ax.XColor = 'r';
        ax.YColor = 'r';
    end
    
end

title(sprintf('%d',indent))



