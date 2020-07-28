function Islet_p = Perm_Islet(Islet,I)
% resort Islet
Islet = fresh_ca_signals(Islet);

Islet_p = Islet(I);

Islet(1).Ca          = Islet_p(1).Ca;
% Islet(1).Ca_ori      = Islet_p(1).Ca_ori;
    Islet(1).Ca_0_1  =  Islet_p(1).Ca_0_1;
    Islet(1).Ca_df_f =  Islet_p(1).Ca_df_f;

Islet(1).Ca_very_ori = Islet_p(1).Ca_very_ori;
Islet(1).iy          = Islet_p(1).iy;
Islet(1).ix          = Islet_p(1).ix;
Islet(1).id          = Islet_p(1).id;
Islet(1).type        = Islet_p(1).type;

if isfield(Islet,'cell_type')
Islet(1).cell_type          = Islet_p(1).cell_type;
end

if isfield(Islet(1),'ix_tsne')
Islet(1).ix_tsne     = Islet_p(1).ix_tsne;
end
if isfield(Islet(1),'iy_tsne')
Islet(1).iy_tsne     = Islet_p(1).iy_tsne;
end

Islet_p(1) = Islet(1);

if isfield(Islet,'Corr')
    if size(Islet_p(1).Corr,2)==size(Islet_p(1).Corr,1)
        Islet_p(1).Corr = Islet_p(1).Corr(I,I);
    else
        Islet_p(1).Corr = Islet_p(1).Corr(I,:);
    end
end



% Name = Islet(1).Name;
% save([Islet(1).Name '.mat']);
% toc;

end