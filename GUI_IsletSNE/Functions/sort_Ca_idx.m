

% Ca = mean([Islet.Ca]); idx = [Islet.type];
% sort_Ca_idx(Ca, idx)
function idx_new = sort_Ca_idx(Islet, idx)
idx = double(idx);
I   = unique(idx);

Ca = [Islet.Ca];
for i=1:length(I)
   %% sorting cells according to Max Ca signal
    Ca_mean = mean(   Ca(:,idx==I(i))');
    rank(i).num = max(Ca_mean);    
end


[B I] = sort([rank.num],'descend');

idx_new = 0*idx;
for i=1:length(rank)
    rank(i).old = I(i);
    rank(i).new = i;
    I_sort      =  idx == rank(i).old;
    idx_new(I_sort)    = i;
end
end
