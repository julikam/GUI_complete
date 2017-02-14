%% plotting stuff

%
setfigureoptions(15,10)

subplot(1,2,1)
imagesc(flip(probe_tip_tgt1_run12_0002))
c=colorbar;
axis square
set(gca,'FontSize',8)

subplot(1,2,2)
plot(depth_num(:,1),projected_area(:,1).*10^12)
grid on
xlabel('Height (nm)')
ylabel('Projected area (\mum^2)')
set(gca,'FontSize',8)
axis square



%% plot the connected data
setfigureoptions(10,10)
plot(fdata_loadS{j,1}(:,1),...
    fdata_loadS{j,1}(:,2),'o',fdata_unloadS{j,1}(:,1),fdata_unloadS{j,1}(:,2),'o')


%% plot the original unconnected ones
setfigureoptions(10,10)
plot(fdata_load{j,1}(:,1),...
    fdata_load{j,1}(:,2),'o',fdata_unload{j,1}(:,1),fdata_unload{j,1}(:,2),'o')

%% plot offseted ones

setfigureoptions(10,10)
plot(f_loadS_OFF{j,1}(:,1),...
    f_loadS_OFF{j,1}(:,2),'o',data_unload{j,1}(:,1),data_unload{j,1}(:,2),'o')

