function Updata_axes_Islet(Islet)


%% 1. avoid first time

if ~isfield(Islet,'type')
    for i = 1:length(Islet)
        Islet(i).type = 1;
    end
end

%% 2. Get mask

ROI    = ImageJ_to_MASK(Islet);
Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(max(unique([Islet.type])))];

%% 3. Plot mask
set(gcf, 'color',[1 1 1]);

Map = cat(3, ROI(:,:,1)*0,  ROI(:,:,1)*0 ,ROI(:,:,1)*0);

for i=unique([Islet.type])
    Map(:,:,1) = Map(:,:,1) + ROI(:,:,i)*Colors(i,1);
    Map(:,:,2) = Map(:,:,2) + ROI(:,:,i)*Colors(i,2);
    Map(:,:,3) = Map(:,:,3) + ROI(:,:,i)*Colors(i,3);
end

imagesc(cat(3, imadjust(Map(:,:,1)),  imadjust(Map(:,:,2)) ,imadjust(Map(:,:,3))));  %colorbar; colormap(hsv);freezeColors;

axis off;
% title('cells');


