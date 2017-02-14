f1 = fullfile(datadir,'Analysis');
mkdir(f1,'post_process_figures')  

folder = fullfile(f1,'post_process_figures');
legendString=cell(length(flistmap),1);

figure('Visible','on') 
    figure1=gcf;
    figure1.Units='centimeters';
    figure1.PaperOrientation = 'landscape';
    figure1.Position = [0.5 5 22 15];
    figure1.PaperPositionMode = 'auto';
    axes('Parent',figure1,'FontSize',9);

%% DZslope
subplot(2,3,1);
hold on

    
    plot(results_valid(fib).Index(:,1),results_valid(fib).DZslope(:,1),'o') 

    legendString{fib,1}=sprintf('Fibril %d',fib);

    plot([0;width],[0.2;0.2],'--k')
    plot([0;width],[0.85;0.85],'-k')
axis([0 width 0 1])  
ax=gca;
ax.TickLabelInterpreter='latex';
xlabel('Index','interpreter','latex')    
ylabel('DZlslope','interpreter','latex')    

% title('DZslope','Interpreter','latex')


%% Elastic modulus vs Index
subplot(2,3,2);
% title('Elastic modulus vs. Index','Interpreter','latex')
hold on

  
plot(results_valid(fib).Index(:,1),results_valid(fib).Elastic_modulus(:,1),'o')
    

EmodulData(:,1) = results_valid(fib).Elastic_modulus(:,1);

   

ax=gca;
ax.TickLabelInterpreter='latex';
legend(legendString{fib,1},'Interpreter','latex')
xlabel('Index','interpreter','latex')
ylabel('Elastic modulus (MPa)','interpreter','latex')  

%% BOXPLOT
subplot(2,3,3);
title('Boxplot','Interpreter','latex')

boxplot(EmodulData,'Color',[0 0 0],'symbol','k+')
ax=gca;
ax.TickLabelInterpreter='latex';
hold on
plot(1,mean(EmodulData),'ok')
    annot = annotation('textbox');
    annot.Position = [0.83,0.9,0.15,0.09];
    annot.Interpreter = 'latex';
    annot.EdgeColor = 'none';
    annot.BackgroundColor = 'w';
    annot.FontSize = 8;
    annot.FitBoxToText = 'on';
    str = {sprintf('Median = %.2f MPa',median(EmodulData)),...
           sprintf('Mean = %.2f MPa',mean(EmodulData)),...
           sprintf('STD = %.2f MPa',std(EmodulData)),...
           sprintf('SE = %.2f MPa',std(EmodulData)/sqrt(length(EmodulData)))};
    annot.String = str;

ylabel('Elastic modulus (MPa)','interpreter','latex')


%% Elastic modulus vs. Hc
subplot(2,2,4);
% title('Elastic modulus vs. Contact depth','Interpreter','latex')
hold on
  
    plot(results_valid(fib).Hc(:,1).*1000,...
        results_valid(fib).Elastic_modulus(:,1),'o')
    

   

ax=gca;
ax.TickLabelInterpreter='latex';
legend(legendString{fib,1},'Interpreter','latex')

xlabel('Contact depth (nm)','interpreter','latex')
ylabel('Elastic modulus (MPa)','interpreter','latex')  

%% Stiffness
subplot(2,2,3);
% title('Stiffness','Interpreter','latex')

    
    plot(results_valid(fib).Hc(:,1).*1000,results_valid(fib).Stiffness(:,1),'Ok')
    hold on

ax=gca;
ax.TickLabelInterpreter='latex';
% legend(legendString,'Interpreter','latex')
xlabel('Contact depth ($\mu$m)','interpreter','latex')
ylabel('Stiffness (N/m)','interpreter','latex')  


f = fullfile(folder,sprintf('%s_review_plots_fibril%d.ps',sample_name,fib));
f2 = fullfile(folder,sprintf('%s_review_plots_fibril%d.png',sample_name,fib));

print(gcf,'-dpsc','-r600',f );
print(gcf,'-dpng','-r600',f2 );
% set(handles.text16, 'String', ['Save figures to ',f2,char(10), ' and to ',f])
clear f f2;
% close all;
%%
figure('Visible','on') 
    figure1=gcf;
    figure1.Units='centimeters';
    figure1.Position = [0.5 11 8 8];

    figure1.PaperPositionMode = 'auto';
    axes('Parent',figure1,'FontSize',9);

    
    plot(results_valid(fib).DZslope(:,1),results_valid(fib).Stiffness(:,1),'Ok')
    hold on

ax=gca;
ax.TickLabelInterpreter='latex';
% legend(legendString,'Interpreter','latex','Location','best')
xlabel('DZ slope','interpreter','latex')
ylabel('Stiffness (N/m)','interpreter','latex')  

% hold on
% x=[0:0.01:0.9];
% n=0.035;
% CalibrationFun=(n./(1-x))- n;
% plot(x,CalibrationFun)

f = fullfile(folder,sprintf('%s_review_stiffnessVSdzSlope_fibril%d.png',sample_name,fib));
print(gcf,'-dpng','-r600',f );
% set(handles.text17,'String',['Save figure to ',f])
%%
figure('Visible','on') 
    figure1=gcf;
    figure1.Units='centimeters';
    figure1.Position = [0.5 11 8 8];
    figure1.PaperPositionMode = 'auto';
    axes('Parent',figure1,'FontSize',9);


    plot(results_valid(fib).DZslope(:,1),results_valid(fib).Elastic_modulus(:,1),'Ok')
    hold on

% legend(legendString,'Interpreter','latex','Location','best')
xlabel('DZ slope','interpreter','latex')
ylabel('Elastic modulus (MPa)','interpreter','latex')  
axis([0 1 0 inf])   
ax=gca;
ax.TickLabelInterpreter='latex';
f = fullfile(folder,sprintf('%s_review_EmodVSdzSlope_fibril%d.png',sample_name,fib));
print(gcf,'-dpng','-r600',f );
% set(handles.text18,'String',['Save figure to ',f])
% hold on
% x=[0:0.01:0.9];
% n=8;
% CalibrationFun=(n./(1-x))- n;
% plot(x,CalibrationFun)

clear EmodulData