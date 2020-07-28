

% Ca = mean([Islet.Ca]); idx = [Islet.type];
% sort_Ca_idx(Ca, idx)
function idx_new = sort_cell_type_idx(Islet, idx)
idx = double(idx);
I   = unique(idx);

Ca = [Islet.Ca];
for i=1:length(I)    
    rank(i).num = mean([Islet(idx==I(i)).cell_type]);
end


[B I] = sort([rank.num]);
% [B I] = sort([rank.num],'descend');

idx_new = 0*idx;
for i=1:length(rank)
    rank(i).old = I(i);
    rank(i).new = i;
    I_sort      =  idx == rank(i).old;
    idx_new(I_sort)    = i;
end

end
