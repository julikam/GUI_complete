function NumberOfFigures = HowManyFiguresToPlot(num_of_files)

x = num_of_files/16;

if isequal(fix(x),x) 
% if the num_of_files devided by 16, wihch is the number of subplots in a
% figure, is integer, then the images can be ploted in x figures.
    NumberOfFigures=x;
    
else

    i=1;
    while num_of_files > i*16
        i=i+1;
    end
    NumberOfFigures=i; 
end




    