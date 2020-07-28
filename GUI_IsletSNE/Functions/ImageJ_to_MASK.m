function ROI = ImageJ_to_MASK(Islet)
        
kernal_type = ones(5,5);

Types  = unique([Islet.type]);
    k  = max([max(Types),3]);
n_cell = length(Islet);

idx   = [Islet.type];
len   = Islet(1).size;
% [~,I] = sort(idx);

% step 5.1  save ROI plot to Imagej
% function ROI_cluster(Islet)

Temp = zeros(len,len);
ROI  = zeros(len,len,k);

if isfield(Islet(1),'width')
Temp = zeros(Islet(1).height, Islet(1).width);
ROI  = zeros(Islet(1).height, Islet(1).width,k);
end

for i = 1:k

x = round([Islet(idx==i).ix]);
y = round([Islet(idx==i).iy]);
    
    for s=1:length(x)
    Temp(x(s),y(s)) = 1;
    end
   
    
    ROI(:,:,i)  = ROI(:,:,i) + conv2(Temp, kernal_type, 'same');  %  ROI(:,:,k)  = ROI(:,:,k) + conv2(Temp,kernal_type(:,:,idx(i)),'same');
    Temp = Temp*0;
    

end


    end