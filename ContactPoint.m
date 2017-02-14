function [f_loadS_OFF ,data_unload] = ContactPoint(smoothed_load, smoothed_unloadS)
%%%%%%%%%%% CONTACTPOINT: performs offset and tilt. Smoothing is also
%%%%%%%%%%% perfomed to the data by applied a moving_average.
% ++++++++++++++++++++++++++++++
% uncomment this to chect the function on a set of data.
% smoothed_load = fdata_load{j,1}*scaling
% smoothed_load(:,2) = mapsData(1).SmoothedLoad_data{1,1}(:,2);
% smoothed_unloadS = fdata_unload{j,1}*scaling
% smoothed_unloadS(:,2) = mapsData(1).SmoothedUnload_data{1,1}(:,2);
% smoothed_load = fdata_load{j,1}*scaling
% smoothed_unloadS = fdata_unload{j,1}*scaling
% ++++++++++++++++++++++++++++++

% Prealocate the offset data to a cell.

%% Store 60% of Z-length data into x and y variables.

    xmin=min(smoothed_load(:,1));% mininum height
    [xmax ,row]=max(smoothed_load(:,1));% maximum height

    difference1=xmax-xmin; % the absolute height distance covered (Z length)
    n=(0.5*difference1)+xmin; 
    % n is height value that corresponds to the upper 60% of the approach
    % data.
    
%     nload=length(fdata_loadS{i,1}(:,1));

    % the while loop below stores 60% of the approach data is the x and y
    % variables.
    index = 1;
    while (smoothed_load(row,1) >= n)
%          x(index,1) = fdata_loadS{i,1}(row,1);
%          y(index,1) = fdata_loadS{i,1}(row,2); 
        row=row+1;
        index = index+1;
    end
    clear row
    index = index-1;
    x=zeros(index,1);
    y=zeros(index,1);
    x(:,1) = smoothed_load(1:index,1);
    y(:,1) = smoothed_load(1:index,2); 

% ucomment the 4 lines above to solve the warning regarding the increasing
% size of 'x' and 'y' lists
    
    
    
%% 1. Linear fit and subtract data
%%%%%%%&&&&&&& 1st Y-OFFSET &&&&&&&%%%%%%%

%%%%%%% LINEAR FIT OF APPROACH NON CONTACT DATA %%%%%%%
    p1 = polyfit(x(:,1),y(:,1),1);
    ytemp(:,1) = polyval(p1,smoothed_load(:,1));    
    ytemp_unload(:,1) = polyval(p1,smoothed_unloadS(:,1));
%  Uncomment below to view plot
%     setfigureoptions(10,10)
%     
%     plot(x(:,1),y(:,1),'o','LineStyle','none','Color',[0.8 0.8 0.8])
%     plot(smoothed_load(:,1),smoothed_load(:,2))
%     plot(x(:,1),polyval(p1,x(:,1)),'-r')
%     hold off

%%%%%%% SUBTRACT LINEAR FIT FROM DEFLECTION DATA %%%%%%%
sub1(:,1) = smoothed_load(:,2) - ytemp(:,1); % LOAD
sub1_unload(:,1) = smoothed_unloadS(:,2) - ytemp_unload(:,1); % UNLOAD
data_unload(:,2) = sub1_unload(:,1);
data_unload(:,1) = smoothed_unloadS(:,1);
%     figure;
%     grid on
%     hold on
%     plot(smoothed_load(:,1),sub1(:,1),'-r','LineWidth',1.5)
%     plot(smoothed_unloadS(:,1),sub1_unload(:,1),'-r','LineWidth',1.5)
%     plot([2.5e-6 6.5e-6],[0 0],'-b','LineWidth',1.5)
%     hold off  

%     clear ytemp 
%% 2. Fit 7th order polynomial to flatten approach curve
%%%%%%%&&&&&&& 2nd Y-OFFSET &&&&&&&%%%%%%%

%%%%%%% 7th ORDER POLYNOMIAL - Second subtraction %%%%%%%
% Polynomial fit of approach section of data which are already subtracted
% once in the above section.

%     p2 = polyfit(x(:,1),sub1(1:index,1),5);

%     figure;
%     grid on
%     hold on
%     plot(smoothed_load(:,1),sub1(:,1),'-r','LineWidth',1.5)
%     plot(x(:,1),polyval(p2,x(:,1)),'-','Color',[0 0 0])   
%     plot([2.5e-6 6.5e-6],[0 0],'-b','LineWidth',1.5)
%     hold off 

% Subtract the new fit from the data of previous section.
%     sub2(:,1) = sub1(1:index,1) - polyval(p2,x(:,1));
%     
%     figure('Visible','on');
%     grid on
%     hold on
%     plot(smoothed_load(:,1),sub1(:,1),'-','LineWidth',1.5)
%     plot(x(:,1),sub2(:,1),'o','Color',[0.8 0.8 0.8])
%     plot(x(:,1),polyval(p2,x(:,1)),'-','Color',[0 0 0],'LineWidth',1.5)
%     legend('Approach data','Polynomial fit subtracted from data',...
%         'Polynomial fit')
%     saveas(gcf,'2ndSubtractionPolyfit','pdf');

%     
%     plot([2.5e-6 6.5e-6],[0 0],'-b','LineWidth',1.5)
%     hold off     
    
%% 3. Delete the set of data that were subtracted from the 7order poly fit.
%%%%%%%&&&&&&& 3rd Y-OFFSET &&&&&&&%%%%%%%   

%     temp = sub1(:,1);
%     temp(1:length(sub2),1) = 1; 
%     plot(fdata_loadS{i,1}(length(sub2)+1:end,1),temp(length(sub2)+1:end,1))
%     difference = sub1(length(sub2),1)-sub2(end,1);
%    j=1;
%    while temp(j,1) == 1;
%        temp(j,1) = sub2(j,1)+difference;
%        j=j+1;
%    end
%    clear difference;
   
%    figure;
%    hold on
%    grid on
%    plot([2.5e-6 6.5e-6],[0 0],'--','Color',[0 0 0],'LineWidth',1.5)
%    plot(x(:,1),sub2(:,1),'-','LineWidth',2,'Color',[0.2 0.6 0.5])
%    plot(smoothed_load(:,1),temp(:,1),'-','LineWidth',2)
%    plot(smoothed_load(:,1),sub1(:,1),'-r','LineWidth',1)

%  At this point we have tilted our data and performed a Y-OFFSET close to
%  0.
%% 4. Linear fit and subtract data
%%%%%%%&&&&&&& 4th Y-OFFSET &&&&&&&%%%%%%%

%     x1 = smoothed_load(1:index,1);
%     y1 = temp(1:index,1);
%     p3=polyfit(x1,y1,1);
    
%     figure;
%     hold on
%     plot(smoothed_load(:,1),temp(:,1),'-','LineWidth',1.5) 
%     plot(x1,polyval(p3,x1),'-','Color',[1,0.2,0.6],'LineWidth',1.5)
%     legend('Approach data','Linear fit')
%     saveas(gcf,'LinearFit tilt','pdf');
%     
    
%     sub3(:,1) = temp(:,1) - polyval(p3,smoothed_load(:,1));
%     figure;
%     hold on
%     plot([2.5e-6 6.5e-6],[0 0],'-b','LineWidth',1.5) %line at Y=0
%     plot(smoothed_load(:,1),sub3(:,1),'-b')
%     grid on
%     


%% find contact point based on the 1st derivative of the smoothed data.

% smooth with RLOWESS and set the degree of smoothing to 0.015. This number
% was selected to be the most approapriate as it gives more representative
% smoothed data of the original data. 
% rlowessSM=smooth(sub3(:,1),0.015,'rlowess'); 
% rloess=smooth(sub3(:,1),'rloess'); 
moving_average(:,1)=smooth(sub1(:,1),'moving');
% rloess(:,1)=smooth(sub1(:,1),0.02,'rloess');
% span(:,1) = [0.05 0.04 0.03 0.02];
% for i = 1 : length(span);
% rloess{i,1}(:,1)=smooth(sub3(:,1),span(i,1),'rloess'); 
% end
% % Plot the XOFFSET determined by the percentage noise method
% 
% figure
% hold on
% grid on
% plot(smoothed_load(:,1),sub1(:,1),'-r','LineWidth',1.5)
% plot(smoothed_load(:,1),sort(moving_average(:,1)),'-','LineWidth',1.5)
% plot(smoothed_load(:,1),rloess(:,1),'-','LineWidth',1.5)
% for i = 1 : 4
% plot(smoothed_load(:,1),rloess{i,1}(:,1),'-','LineWidth',1.5)
% line_name{i,1}=sprintf('rloess span=%d',span(i,1));


% end
% legend('data','Moving average',line_name{1,1},line_name{2,1},line_name{3,1},line_name{4,1})

%%  First derivative calculation to find contact point.
dy = diff(moving_average(:,1));
dx = diff(smoothed_load(:,1));
deriv1 = dy./dx; 

% flip the deriv1 list

% smooths the derivative.

flippedDeriv=flipud(deriv1(:,1));
% plot(fdata_loadS{j,1}(1:length(deriv1),1),flippedDeriv,'.g','LineWidth',1.5)
% DATA ARE FLIPPED TO START ITERATING TO SEARCH FOR THE FIRST TIME THE 0
% POINT APPEARS. THIS IS THE POSITION OF THE CONTACT POINT. DATA THEN
% SHOULD AGAIN BE FLIPPED AND ALSO FIND A WAY TO DETERMINE THE POSITION OF
% THE 0 POINT IN THE LIST. THIS POSITION IS THE ELEMENT OF THE X-YOFFSET.
% 
% for k = [length(deriv1),7000,5000,4000,3000,2000,1000,500,200,100];   
%     figure;
%     plot(fdata_loadS{i,1}(1:k,1),deriv1(1:k,1)*10^-6,'-m','LineWidth',1.5) 
%     hold on
%     plot(fdata_loadS{i,1}(:,1),sub3(:,1),'-r','LineWidth',1.5)
%     title(['data range 1 to',int2str(k)])
% end

ii=1;
    while flippedDeriv(ii,1)<0
        ii=ii+1;
    end
    
    position = length(deriv1(:,1))-ii+4;   
    
%  figure;
%  hold on
%  grid on
%  plot([smoothed_load(position,1) smoothed_load(position,1)],...
%        [max(sub1(:,1)) min(moving_average(:,1))*10^-7],'k','Linewidth',1.5)
%  plot([min(smoothed_load(:,1)) max(smoothed_load(:,1))],[0 0],'k','Linewidth',1.5)
%  plot(smoothed_load(1:end-1,1),deriv1(:,1)*10^-7,'Linewidth',1.5)
%  
%  plot(smoothed_load(:,1),sub1(:,1),'Linewidth',1.5)
%  
%  legend('-','-','1st derivative','smoothed derivative','original y-offset data')

 xoffset = smoothed_load(position,1);
 yoffset = moving_average(position,1);
    
    
%     
%     figure;
%     hold on
%     grid on
%     plot(smoothed_load(:,1),rloess,'o','LineWidth',1) 
%     plot([xoffset xoffset],[-0.5e-8 4e-8],'--','LineWidth',1) %line at X
%     plot([2.5e-6 6.5e-6],[0 0],'--','LineWidth',1) %line at Y=0
%     
%     figure;
%     hold on
%     grid on
%     plot([0 0],[-0.5e-8 5e-8],'-k','LineWidth',1.5) %line at X
%     plot([-1e-6 3.5e-6],[0 0],'-k','LineWidth',1.5) %line at Y=0
%     plot(fdata_loadS{i,1}(:,1)-xoffset,sub3(:,1)-yoffset,'ob','LineWidth',1.5)     
%     plot(fdata_loadS{i,1}(:,1)-xoffset,rlowessSM-yoffset,'-m','LineWidth',1.5)

    
% plot data with offset and 1st derivative.
% figure;
% hold on
% grid on
% 
% plot(fdata_loadS{i,1}(:,1),rlowessSM,'-','LineWidth',1.5)
% plot([fdata_loadS{i,1}(position,1) fdata_loadS{i,1}(position,1)],[-0.5e-8 4.5e-8],'-k','LineWidth',1.5) %line at X
% plot([2.5e-6 6.5e-6],[0 0],'-k','LineWidth',1.5) %line at Y=0
% plot(fdata_loadS{i,1}(1:length(deriv1),1),deriv1*10^-6,'om','LineWidth',1.5) 

%% store offset data


% Apply x-y offset on original data and store them.
f_loadS_OFF(:,1) = smoothed_load(:,1)-xoffset;
f_loadS_OFF(:,2) = sub1(:,1);% - yoffset; IF use the y-offset it will perfo 
data_unload(:,1) = data_unload(:,1)-xoffset;
% data_unload(:,2) = data_unload(:,2)-yoffset;

%     figure;
%     hold on
%     grid on
%     plot(f_loadS_OFF(:,1),f_loadS_OFF(:,2),'o','LineWidth',1)
%     xlim1=min(f_loadS_OFF(:,1));
%     xlim2=max(f_loadS_OFF(:,1));
%     plot([xlim1 xlim2],[0 0],'--','Color',[0 0 0],'LineWidth',1) %line at Y=0
%     ylim1=min(f_loadS_OFF(:,2));
%     ylim2=max(f_loadS_OFF(:,2));
%     plot([0 0],[ylim1+0.2*ylim1 ylim2+0.1*ylim1],'--','Color',[0 0 0],'LineWidth',1) %line at x=0
%     legend('Approad at contact point')




clear moving_average dy dx deriv1 sub1 sub2 sub3 xmin xmax temp x y p1...
      p2 p3 row j x1 y1 flippedDeriv index ytemp xoffset yoffset position...
      ii n unloadtemp loadtemp sub1_unload ytemp_unload
  




