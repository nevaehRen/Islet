function Islet = Get_Corr_matrix_spearman(Islet)

n_cell = length(Islet);

Corr        = zeros(n_cell,n_cell);   
Distance    = zeros(n_cell,n_cell);

% pos      = [Islet.ix; Islet.iy;];
% Distance = dist(pos);

tic;
for i = 1:(n_cell)
    for j = (i+1):n_cell
%          Corr(i,j) = corr(Islet(i).Ca,Islet(j).Ca,'type','Spearman');
%          Corr(i,j) = corr(Islet(i).Ca_very_ori,Islet(j).Ca_ori,'type','Pearson');
          Corr(i,j) = corr(Islet(i).Ca,Islet(j).Ca,'type','Pearson');

%          Corr(i,j) = corr(Islet(i).Ca,Islet(j).Ca,'type','Pearson');

     end
end



Corr = Corr + Corr' +eye(n_cell,n_cell);
toc;

            I_temp = isnan(Corr);
            Corr(I_temp)=0;
            I_temp = isinf(Corr);
            Corr(I_temp)=0;
Islet(1).Corr        = Corr;
