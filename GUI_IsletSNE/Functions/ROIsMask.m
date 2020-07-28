function flag=ROIsMask(RoIs,num,Picsize)


flag  = zeros(Picsize,Picsize);
Ayo=RoIs{num}.mnCoordinates;
Ayo=[Ayo;Ayo(1,:)];
[~,flag] = roifill(flag, Ayo(:,1),   Ayo(:,2));
% [~,flag] = roifill(flag, RoIs{num}.mnCoordinates(:,1),   RoIs{num}.mnCoordinates(:,2));

% [X Y]=meshgrid(1:Picsize,1:Picsize);
% 

% 
% flag = myinpolygon(X,Y,Ayo(:,1),Ayo(:,2));

% figure
% imshow(flag)



end



