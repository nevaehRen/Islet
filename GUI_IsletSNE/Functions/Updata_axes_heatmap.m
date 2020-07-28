function Updata_axes_heatmap(Islet)
Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(length(unique([Islet.type])))];


idx  = [Islet.type];
Data = [Islet.Ca]';

[idx,I]    = sort(idx);
% I=1:length(Islet);
n_l=min(14,round(0.1*(sum(size(Data))-length(Islet)))+1);
% n_l=1;
T=size(Data,2);
Negative_edge = [];
edge = [];
for i=unique(idx)
    Negative_edge = [Negative_edge;[0 sum(idx<i)+0.5   n_l+0.5  sum(idx==i)-0.5]];
    edge = [edge;[0 sum(idx<i)+0.5   T+n_l+0.5   sum(idx==i)-0.5]];
end
edge(end,4)=edge(end,4)+0.5;
Negative_edge(end,4)=Negative_edge(end,4)+0.5;


B        = [Islet(I).type]'/max([Islet(I).type]);
B        = [B B*0];

% for i=1:length(Islet)
%     Islet(i).Ca=  normalization_0_to_1(Islet(i).Ca);
% end

Data  = [Islet.Ca];
% Data  = [Islet.Ca];


Data  =  Data(:,I);

imagesc([B(:,[ones(1,n_l)])'; Data]');

% imagesc([B(:,[1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2])'; Data]');

% title('Spearson Corr of Cells');
set(gca,'FontName','Comic Sans Ms','FontSize',10,'Linewidth',1)

%% ============= colormap ============= %%
% axis image;
% axis off;
% [map,num,typ] = brewermap(100,'RdBu');
[map,num,typ] = brewermap(100,'YlGnBu');
% [map,num,typ] = brewermap(100,'PuBu');
% [map,num,typ] = brewermap(100,'Greys');
map = map(end:-1:1,:);colormap(map);
caxis([0.1 0.8]);
%% ==================================== %%

axis off;
s=1;
for  i=unique(idx)
    rectangle('Position',Negative_edge(s,:),'linewidth',1.5,'edgecolor',Colors(i,:),'facecolor',Colors(i,:));
    rectangle('Position',edge(s,:),'linewidth',2,'edgecolor',Colors(i,:));
    s=s+1;
end

% for i = size(Negative_edge,1):-1:1
%     rectangle('Position',Negative_edge(i,:),'linewidth',1.5,'edgecolor',Colors(i,:),'facecolor',Colors(i,:))
%     rectangle('Position',edge(i,:),'linewidth',2,'edgecolor',Colors(i,:))
% end



end