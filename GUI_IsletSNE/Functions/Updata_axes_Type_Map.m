function Updata_axes_Type_Map(Islet,No)

cla;
Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(max(unique([Islet.type])))];
cla;
if nargin==2
    Islet(1).Time = 1:length(Islet(1).Time);
end

Ca = [Islet.Ca]';
idx =  [Islet.type];
for i=unique(idx)
    
I = idx==i;

% [hl, hp] = boundedline(Islet(1).Time, normalization_0_to_1(mean(Ca(I,:))), std(Ca(I,:)),'cmap',Colors(i,:),'alpha');
[hl, hp] = boundedline(Islet(1).Time, mean(Ca(I,:)), std(Ca(I,:)),'cmap',Colors(i,:),'alpha');
hold on;

plot(Islet(1).Time, mean(Ca(I,:)),'color',Colors(i,:),'linewidth',2);
% plot(Islet(1).Time, normalization_0_to_1(mean(Ca(I,:))),'color',Colors(i,:),'linewidth',2);


end

% imagesc(Firing_RGB);  colormap(hsv);
% xlabel('time');
% ylabel('Ca');
% title('Original trace of each cluster');
set(gca,'linewidth',1.5 , 'Fontsize', 10, 'Fontname' , 'Comic Sans MS');
axis off;
% box on;


end