function   Typical_original_Curve_Print(Islet,No)

if nargin==2
    Islet(1).Time = 1:length(Islet(1).Time);
end

Colors = [[0 0.5 0;1 0 0;0 0 1]; lines(max(unique([Islet.type])))];
% Colors = [[1 0 0;0 0.5 0;0 0 1]; lines(length(unique([Islet.type])))];

% Colors(2,:)=[0 0 1];
% Islet(1).Time = Islet(1).Time*3/60;


idx   = [Islet.type];
[~,I] = sort(idx);
k     = max(unique(idx));

% for i=1:length(Islet)
%     Islet(i).Ca = normalization_df_over_f(Islet(i).Ca);
% end

%%%%%%%%%%%%%%%%%%%%%%
Up = [];
Down = [];
for i = 1:k
Up   = [Up;max(mean([Islet(idx ==i).Ca]'))];
Down = [Down;min(mean([Islet(idx ==i).Ca]'))];
end

Up   = max(Up);
Down = min(Down);
%%%%%%%%%%%%%%%%%%%%%%


Ca = [Islet.Ca]';



if exist(['Result/' Islet(1).Name  '_Trace/'])~=0; rmdir(['Result/' Islet(1).Name '_Trace/'],'s'); end;
% 2.1 - move Name.zip
mkdir(['Result/' Islet(1).Name  '_Trace/']);

for i=1:k
    mkdir(['Result/' Islet(1).Name  '_Trace/Type_' num2str(i)]);
end

figure(1222);close;figure(1222);

for i=1:k
    tem   = 1:length(idx);
    Index = tem(idx==i);
    Index = Index(randperm(length(Index)));
    for j=1:length(Index)
subplot(1,4,1);
point_specific_single_cells(Islet,Index(j));
title(Islet(1).Name);
subplot(1,4,2:4);

        
        if sum(Index)>j
            set(gcf,'visible','off','position',[100 100,1800,400], 'color',[1 1 1]);hold on;
            plot(Islet(1).Time,Islet(Index(j)).Ca,'color',Colors(Islet(Index(j)).type,:),'linewidth',1);
            if isfield(Islet,'GlobalSignal_ori')
                plot(Islet(1).Time,Islet(1).GlobalSignal_ori,'k:');
            end
            %%%%
            Up_temp   = Up;
            Down_temp = Down;
            if max(max([Islet(Index(j)).Ca])) > Up
                Up_temp=max(max([Islet(Index(j)).Ca]));
            end
            if min(min([Islet(Index(j)).Ca])) < Down
                Down_temp=min(min([Islet(Index(j)).Ca]));
            end
            ylim([Down_temp Up_temp]);
            set(gca,'linewidth',1.5 , 'Fontsize', 10, 'Fontname' , 'Comic Sans MS');
            %%%%
            
           if isfield(Islet,'cell_type')
           YlabelsCellName={'alpha', 'beta', 'delta'};
           title([' cell ' num2str(Islet(Index(j)).id) ', ' YlabelsCellName{Islet(Index(j)).cell_type} ' cell']);
           else
           title([' cell ' num2str(Islet(Index(j)).id)]);
           end
                     
            saveas(gcf,['Result/' Islet(1).Name '_Trace/Type_' num2str(i) '/Cell-' num2str(Islet(Index(j)).id) '.png']);
            close(1222);figure(1222);
            %     xlabel(num2str(Islet(Index(j)).type));
        end
    end
end

figure(1222);close;



 
