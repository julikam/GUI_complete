function [x_coeff, F, n_lower, n_upper] = fit_proj_area(HEIGHT,AREA,ulim,llim)

% ulim = h_ulimit;
% llim = h_llimit;
% HEIGHT = Tip.HeightData(:,1);
% AREA = Tip.ProjArea(:,1);

% returns the last position of the HEIGHT data that is smaller than the
% lower limit.
n_lower = find(HEIGHT < llim,1,'last'); 

% returns the first position of the HEIGHT data that is greater than the
% upper limit.
n_upper = find(HEIGHT > ulim,1,'first');

% set fitting function
F = @(x,xdata)x(1).*xdata + x(2).*xdata.^2 + x(3).*xdata.^3;
x0=[1 1 1];
x_range = HEIGHT(n_lower:n_upper,1);
area_range = AREA(n_lower:n_upper,1).*10^12;
[x_coeff,resnorm,~,exitflag,output] = lsqcurvefit(F,x0,x_range,area_range);


%     setfigureoptions(8,8)
%     plot(HEIGHT(1:100,1),AREA(1:100,1).*10^12,'-')
%     plot(x_range,(F(x_coeff,x_range)),'-r')
%     plot(HEIGHT(n_lower:n_upper,1),AREA(n_lower:n_upper,1).*10^12,'o')
%     xlabel('Height (nm)')
%     ylabel('Projected area (\mum^2)')
clear ulim llim HEIGHT AREA