function [idx,cNums] = CLA_n_cluster(Y, n_cluster )
% 
% Y = Islet(1).Y;
% n_cluster = 2;
% save test.mat
s=5;
[idx,cNums] = CLA(Y, s );
try_num = 1;

while (cNums~=n_cluster)&(try_num<100)
    try_num = try_num+1;
    [idx,cNums] = CLA(Y,s);
    
    if length(unique(idx))>n_cluster
        s = s +1;
    elseif length(unique(idx))<2
        s = s -1;
    end
    
end

if (cNums~=n_cluster)
    disp('fail to cluster, please try again ...');
end

end






