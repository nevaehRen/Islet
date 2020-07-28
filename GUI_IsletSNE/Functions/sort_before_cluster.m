function Islet_p = sort_before_cluster(Y,Islet)
           Y_d = pdist(Y);
     tree      = linkage(Y_d);
     leafOrder = optimalleaforder(tree,Y_d);
    % figure;
    % dendrogram(tree,0);
%     figure(111);subplot(1,2,1);
%     imagesc([Islet.Ca]');
         Islet_p = Perm_Islet(Islet,leafOrder);
%          load([Islet(1).Name '.mat']);
%          Islet = Perm_Islet(Islet,leafOrder);
%          save([Islet(1).Name '.mat'], 'Islet');
    % idx = cluster(Z,'maxclust',20);
%     figure(111);subplot(1,2,2);
%     imagesc([Islet.Ca]');
end