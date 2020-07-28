function Update_axes_tSNE(Islet)

%% This function is used to plot scatter dots in tSNE space
%--% step 1. load tSNE position and type index
cla;
X      = [[Islet.ix_tsne]; [Islet.iy_tsne]]';
idx    = double([Islet.type]);
% idx  = double([Islet.cell_type]);

k      =   max(idx);

%--% step 2. load tSNE position
Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(k)];

%--% step 3. plot tSNE scatter dots
% figure(888);close;figure(888); 
hold on;
    set(gcf,'Color',[1 1 1])
%     set(gcf,'Position',[100  600  400 400], 'color',[1 1 1]);
    set(gca,'FontName','American Typewriter','FontSize',18, 'color',[1 1 1])
    for i = 1:k
        plot(X((idx==i),1),X((idx==i),2),'o','markerfacecolor',Colors(i,:),'markeredgecolor',[1 1 1],'Markersize',10, 'LineWidth',.2)
    end
set(gca, 'LineWidth',3) 

% saveas(gcf,'Result/3.t-SNE space.png','png');
