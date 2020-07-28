
function Map = Colorful_Map_ori(Islet,No,colors)
% save test.mat
Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(max(unique([Islet.type])))];
idx     = [Islet.type];
k_type  = unique(idx);

if nargin>=3
    Colors = [colors; lines(max(unique([Islet.type])))];
end

if nargin>=2
    Islet(1).Time = 1:length(Islet(1).Time);
end


ROI   = ImageJ_to_MASK(Islet);



Map = cat(3, ROI(:,:,1)*0,  ROI(:,:,1)*0 ,ROI(:,:,1)*0);

for i=1:length(unique([Islet.type]))%size(ROI,3)
Map(:,:,1) = Map(:,:,1) + ROI(:,:,i)*Colors(k_type(i),1);
Map(:,:,2) = Map(:,:,2) + ROI(:,:,i)*Colors(k_type(i),2);
Map(:,:,3) = Map(:,:,3) + ROI(:,:,i)*Colors(k_type(i),3);
end



figure(222);
close(222);
figure(222);
set(gcf,'Position',[50  200  1800 450], 'color',[1 1 1]);

subplot(1,3,1);
% if nargin>2
imagesc(cat(3, imadjust(Map(:,:,1)),  imadjust(Map(:,:,2)) ,imadjust(Map(:,:,3))));  %colorbar; colormap(hsv);freezeColors;
% else
% imagesc(cat(3, imadjust(Map(:,:,1)),  imadjust(Map(:,:,2)+imadjust(Islet(1).Max/max(max(Islet(1).Max)))) ,imadjust(Map(:,:,3)))); 
% end
axis off;
title('spatial distribution of clusters');


% subplot(1,3,2);
% 
% Ca = [Islet.Ca]';
% 
% for i=1:length(unique([Islet.type]))
%     
% I = [Islet.type]==i;
% 
% % plot(Islet(1).Time, mean(Ca(I,:)),'color',Colors(i,:));
% [hl, hp] = boundedline(Islet(1).Time, mean(Ca(I,:)), std(Ca(I,:)),'cmap',Colors(i,:),'alpha');
% 
% hold on;
% 
% end
% 
% % imagesc(Firing_RGB);  colormap(hsv);
% % axis off;
% xlabel('time');
% ylabel('Ca');
% title('Normalized trace of each cluster');
%     set(gca,'linewidth',1.5 , 'Fontsize', 10, 'Fontname' , 'Comic Sans MS');



subplot(1,3,2:3);

Ca = [Islet.Ca]';


for i=1:length(unique([Islet.type]))
    
I = [Islet.type]==k_type(i);

plot(Islet(1).Time,( mean(Ca(I,:))),'color',Colors(k_type(i),:),'linewidth',2);
% [hl, hp] = boundedline(Islet(1).Time, mean(Ca(I,:)), std(Ca(I,:)),'cmap',Colors(i,:),'alpha');

hold on;

end


xlabel('frame');
ylabel('Ca');
set(gca,'linewidth',1.5 , 'Fontsize', 10, 'Fontname' , 'Comic Sans MS');



end

