function [f_loadS_OFF ,data_unload,data_holding] = ContactPointSinusoidal(smoothed_load, smoothed_unloadS,smoothed_holding)
%%%%%%%%%%% CONTACTPOINT: performs offset and tilt. Smoothing is also
%%%%%%%%%%% perfomed to the data by applied a moving_average.

N=nargin;   %number of inputs
% smoothed_load=fdata_loadS{i,1}*scaling;
% smoothed_unloadS=fdata_unloadS{i,1}*scaling;
% smoothed_holding=fdata_holdingS{i,1}*scaling;
% ++++++++++++++++++++++++++++++
% uncomment this to chect the function on a set of data.
% smoothed_load(:,1) = mapsData(1).SmoothedLoad_data{1,1}(:,1);
% smoothed_load(:,2) = mapsData(1).SmoothedLoad_data{1,1}(:,2);
% smoothed_unloadS(:,1) = mapsData(1).SmoothedUnload_data{1,1}(:,1);
% smoothed_unloadS(:,2) = mapsData(1).SmoothedUnload_data{1,1}(:,2);
% ++++++++++++++++++++++++++++++

% Prealocate the offset data to a cell.

%% Store 60% of Z-length data into x and y variables.

    xmin=min(smoothed_load(:,1));% mininum height
    [xmax ,row]=max(smoothed_load(:,1));% maximum height

    difference1=xmax-xmin; % the absolute height distance covered (Z length)
    n=(0.4*difference1)+xmin; 
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
%LSFit of function f(x)=A+Bx+Csin(Dx-E)
[s]=recfun(x(:,1),y(:,1));    %[estimates,~] changed to [s]

A=s(4); B=s(5); C=s(1); D=2*pi/s(2); E=s(2)/(2*s(3));
% A=estimates(1,1); B=estimates(1,2); C=estimates(1,3); D=estimates(1,4); E=estimates(1,5);





% %%%%%%% LINEAR FIT OF APPROACH NON CONTACT DATA %%%%%%%
    p1 = [B,A]; %Parameter from regfit with sinusoidal function 
%     p1 = polyfit(x(:,1),y(:,1),1);  %from polyfit 1st order 
    ytemp(:,1) = polyval(p1,smoothed_load(:,1));    
    ytemp_unload(:,1) = polyval(p1,smoothed_unloadS(:,1));
    if N==3
       ytemp_holding(:,1)=polyval(p1,smoothed_holding(:,1)); 
    end
%  Uncomment below to view plot



    figure;
    hold on
    plot(x(:,1),y(:,1),'o','LineStyle','none','Color',[0.8 0.8 0.8])
    plot(smoothed_load(:,1),smoothed_load(:,2))
%     plot(x(:,1),polyval(p1,x(:,1)),'-r')
    plot(x(:,1),A+x(:,1)*B+C*sin(x(:,1)*D-E),'b')     %plot if LSfit from above was done
    plot(x(:,1),A+x(:,1)*B,':b')
    plot(x(:,1),A,'-k')
    hold off

%%%%%%% SUBTRACT LINEAR FIT FROM DEFLECTION DATA %%%%%%%
sub1(:,1) = smoothed_load(:,2) - ytemp(:,1); % LOAD
sub1_unload(:,1) = smoothed_unloadS(:,2) - ytemp_unload(:,1); % UNLOAD
data_unload(:,2) = sub1_unload(:,1);
data_unload(:,1) = smoothed_unloadS(:,1);

if N==3; %with Holding
   sub1_holding(:,1)=smoothed_holding(:,2)-ytemp_holding(:,1); 
   data_holding(:,2)=sub1_holding(:,1);
   data_holding(:,1)=smoothed_holding(:,1);
end


%2nd LSFit of function f(x)=A+Bx+Csin(Dx-E)
    x(:,1) = smoothed_load(1:index,1);
    y(:,1) = smoothed_load(1:index,2); 
[s]=recfun(x(:,1),y(:,1));    %[estimates,~] changed to [s]
C=s(1); D=2*pi/s(2); E=s(2)/(2*s(3));

%calculating error relative error between the offseted data and the 2nd
%LSfit to find point where error becomes more than 1%
err=abs((sub1(:,1)-C*sin(smoothed_load(:,1)*D-E))./(smoothed_load(:,2)));
Ierr=find(err(:,1)>0.01,1,'first'); %index where error becomes more than 1%

%     figure;
%     grid on
%     hold on
%     plot(smoothed_load(:,1),sub1(:,1),'-r','LineWidth',1.5)
%     plot(smoothed_unloadS(:,1),sub1_unload(:,1),'-b','LineWidth',1.5)
%     plot(smoothed_load(:,1),C*sin(smoothed_load(:,1)*D-E),'g');
% %     plot(smoothed_load(:,1),err);
%     plot(smoothed_load(Ierr,1),sub1(Ierr,1),'Marker','o','MarkerFaceColor','r');
%     plot([2.5e-6 6.5e-6],[0 0],'-b','LineWidth',1.5)
%     hold off  

%Substract 2nd LS fit f(x) from sub1 in the off from the sample region up to the point
%the err becomes 1% (index of this point is Ierr

sub2=sub1;
sub2(1:Ierr)=sub2(1:Ierr)-C*sin(smoothed_load(1:Ierr,1)*D-E);

figure;
grid on
hold on 
plot(smoothed_load(:,1),sub2(:,1));
hold off

sub3=sub2;
    
    
%     clear ytemp 

%% find contact point based on intersection between mean noncontact-region-
    %line and the increasing contact region
rloess(:,1)=smooth(sub3(:,1),0.02,'rloess');
   



dy = diff(rloess(:,1));     
dx = diff(smoothed_load(:,1));
deriv1 = dy./dx; 

% flip the deriv1 list
rloess_deriv(:,1)=smooth(deriv1(:,1),'moving');    %changed '0.02,'rloess'' to 'moving'
% smooths the derivative.
figure
hold on
plot(smoothed_load(:,1),rloess(:,1));
plot(smoothed_load(:,1),sub3(:,1));
hold off
    

position=find(rloess_deriv(:,1)>0,1,'last');

%  figure;
%  hold on
%  grid on
%  plot([smoothed_load(position,1) smoothed_load(position,1)],...
%        [max(sub3(:,1)) min(rloess_deriv(:,1))],'k','Linewidth',1.5)
%  plot([min(smoothed_load(:,1)) max(smoothed_load(:,1))],[0 0],'k','Linewidth',1.5)
%  plot(smoothed_load(1:end-1,1),deriv1(:,1),'Linewidth',1.5)
%  plot(smoothed_load(1:end-1,1),rloess_deriv(:,1),'Linewidth',1.5)
%  plot(smoothed_load(:,1),sub3(:,1),'Linewidth',1.5)
%  
%  legend('-','-','1st derivative','smoothed derivative','original y-offset data')
% hold off

I=find(sub3(:,1)<0,1,'last');    %find Index of last point which is smaller then 0
% figure;
% hold on;
% plot(smoothed_load(:,1),sub3(:,1),'-b');
% plot(smoothed_load(I,1),sub3(I,1),'Marker','o','MarkerFaceColor','r');
% grid on
% hold off;

k=(sub3(I,1)-sub3(I-1,1))/(smoothed_load(I,1)-smoothed_load(I,1));


xoffset=smoothed_load(I-1,1)-sub3(I,1)/k;
yoffset=0;


%% store offset data


% Apply x-y offset on original data and store them.
f_loadS_OFF(:,1) = smoothed_load(:,1)-xoffset;
f_loadS_OFF(:,2) = sub3(:,1) - yoffset; 

if N==3;    %holding exists
    data_unload(:,2) = sub1_unload(:,1);
    data_unload(:,1) = smoothed_unloadS(:,1)-xoffset;
    
    data_holding(:,2)=sub1_holding(:,1);
    data_holding(:,1)=smoothed_holding(:,1)-xoffset;
    
end

% 
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
%     legend('Approach at contact point')
% 


clear moving_average dy dx deriv1 sub1 sub2 sub3 xmin xmax temp x y p1...
      p2 p3 row j x1 y1 flippedDeriv index ytemp xoffset yoffset position...
      ii n unloadtemp loadtemp sub1_unload ytemp_unload ytemp_holding k N
  




