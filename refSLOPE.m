function reference=refSLOPE(fib,num_of_fibrils)
msg=sprintf('Reference slope of fibril %d from %d:',fib,num_of_fibrils);
prompt = {msg};
    dlg_title = 'Input data';
    num_lines = 1;
    def = {'0.955'};
    
    answer = inputdlg(prompt,dlg_title,num_lines,def);  
    reference = str2double(cell2mat(answer(1,1)));
    
% Stores the reference slope, the radius
clear prompt dlg_title num_lines def answer;