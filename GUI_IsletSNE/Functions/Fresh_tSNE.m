function Islet = Fresh_tSNE(Islet,methods,n_CLA)


    if methods(1)==1    % 10G oscillation
        Islet = Get_Corr_matrix_spearman(Islet);
          Y = tsne([Islet(1).Corr],'NumDimensions',2);
             [idx,cNums]  = CLA_n_cluster(Y, n_CLA );

    elseif methods(2)==1 % 3G active
%         Islet = Get_Corr_matrix_spearman_active(Islet,[0.1 0.1 0.25]);
        Islet   = Tell_3G_active(Islet);
            Y   = [Islet(1).Corr];
            idx = 1*(Y(:,1)>n_CLA)+2*(Y(:,1)<=n_CLA);
%             save test.mat
    elseif methods(3)==1 % 3G active
        Islet = Get_Corr_matrix_spearman(Islet);
        MainPath = mfilename('fullpath');
        s = regexp(MainPath,'Fresh_tSNE','split');
        Path_umap = s{1};
        addpath([Path_umap '\umap']);
        addpath([Path_umap '\util']);
        javaaddpath([Path_umap '\umap\umap.jar']);
        [Y,umap] = run_umap([Islet(1).Corr]);
        close;
        [idx,cNums]  = CLA_n_cluster(Y, n_CLA );

    end

%     [idx,cNums] = CLA( Y, n_CLA );
             idx = sort_Ca_idx(Islet, idx);  %% sort according to Ca activity
             if isfield(Islet,'cell_type')
                idx = sort_cell_type_idx(Islet, idx);  %% sort according to cell type
             end
    for i=1:length(Islet)
        Islet(i).type = idx(i);
        Islet(i).ix_tsne = Y(i,1);
        Islet(i).iy_tsne = Y(i,2);
    end
    
    Islet = sort_before_cluster(Y,Islet);
    
Islet(1).Y = Y;

end