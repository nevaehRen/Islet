function Updata_axes_Corr(Islet)
%% This function is used to plot correlation matrix

% Colors = [[1 0 0;0 0.5 0;0 0 1]; lines(max([Islet.type]))];
Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(max([Islet.type]))];

Corr = Islet(1).Corr;
idx  = [Islet.type];
Data = [Islet.Ca]';

Temp     = Corr;
[idx,I]  = sort(idx);


% I=1:length(Islet);
Negative_edge = [];
for i=unique(idx)
    Negative_edge = [Negative_edge;[0 sum(idx<i)   16  sum(idx==i)]];
end

B        = [Islet(I).type]'/max([Islet(I).type]);
B        = [B B*0];
% figure(333);close; figure(333);set(gcf,'position',[50 100,1800,270]);
% subplot(1,5,1);
if size(Corr,2)==size(Corr,1)
imagesc([B(:,[1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2])'; Corr(I,I)]');

else
imagesc([B(:,[1 1  2 ])'; (Corr(I,:)./max(Corr))']');
end
axis off;

%% ============= colormap ============= %%
axis image;
% axis off;
% [map,num,typ] = brewermap(100,'RdBu');
[map,num,typ] = brewermap(100,'YlGnBu');
% [map,num,typ] = brewermap(100,'PuBu');
% [map,num,typ] = brewermap(100,'Greys');
map = map(end:-1:1,:);colormap(map);
caxis([0 1]);
%% ==================================== %%
s=1;
for  i=unique(idx)
    rectangle('Position',Negative_edge(s,:),'linewidth',1.5,'edgecolor',Colors(i,:),'facecolor',Colors(i,:));
    s=s+1;
end

% for i = 1:size(Negative_edge,1)
%     rectangle('Position',Negative_edge(i,:),'linewidth',1.5,'edgecolor',Colors(i,:),'facecolor',Colors(i,:))
% end
% box on;

