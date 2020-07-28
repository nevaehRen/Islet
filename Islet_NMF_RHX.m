%% NMF algorithm for islet Ca image decomposition
% % Please cite our paper: Pancreatic ¦Á and ¦Â cells are globally phase-locked
% % http://cls.pku.edu.cn:808/online/home/
% % Writen by: Huixia Ren
% % ----------------------------------------------
% % CT Lab and CLY lab  
% % Peking University
% % BJ, China
% % ----------------------------------------------
% % Team member: Yanjun Li, Chengsheng Han, Yi Yu, Daniel Tang, Weiran Qian


function Islet_NMF_RHX()

clear;clc;
%% Step0: read tif image
Image = imreadstack('C57_Islet_10G.tif'); % we provided the C57_Islet_10G.tif, its a islet ca imaging data, image size is 512x512x50

frame      = size(Image,3);
V_original = reshape(Image(:,:,:),[],frame);
epsilo     = 0.001;  

%% Step1: random initialization
W = rand(512*512,2);   
H = rand(2,50);  

%% Step2: iteration EM algorithm
for i=1:100

%% Step 2.1: calculate V'
V_predict = W*H;    
V_ratio   = V_original./(V_predict+epsilo);

%% Step 2.2: update W
 W = W.*(V_ratio * H');
 W = W./sum(W);
 
%% Step 2.3: update H
H   = H.*(W'*V_ratio);

%% Step 3: visualization H
     
        figure(1);
        set(gcf,'Position',[10  100  1000 800], 'color',[1 1 1]);

        subplot(2,3,1); % eigen mode red 
        imshow(reshape([W(:,1)./max(W(:,1)) zeros(512*512,2)],512,512,3));
        axis off;
        subplot(2,3,2); % eigen mode green
        imshow(reshape([zeros(512*512,1) W(:,2)./max(W(:,2)) zeros(512*512,1)],512,512,3));
        axis off;
        text(210,-39, ['iter =' num2str(i)], 'FontName','Comic Sans MS','FontSize',14);
        subplot(2,3,3); % eigen modes merge
        imshow(reshape([W./max(W) zeros(512*512,1)],512,512,3));
        
        subplot(2,3,4:6)
        colors_1 = i/100 * [1 0.3 0.3];
        colors_2 = i/100 * [0.3 1 0.3];
        
        H_norm = H';
        H_norm = H_norm-min(H_norm);
        H_norm = H_norm./max(H_norm);
        H_norm = H_norm';
        
        eval(['h_' num2str(i) ' = plot(H_norm(1,:),''color'',colors_1, ''LineWidth'',0.1+0.03*i);' ]);
        hold on
        eval(['h_2_' num2str(i) ' = plot(H_norm(2,:),''color'',colors_2, ''LineWidth'',0.1+0.03*i);' ]);
        
        if i>5
        eval( ['delete(h_' num2str(i-5)  ');'] );
        eval( ['delete(h_2_' num2str(i-5)  ');'] );
        end


        set(gca,'FontName','Comic Sans MS','FontSize',14, 'LineWidth',2)
        ylabel('activity')
        set(gca,'xtick',[0:10:50])

end



    
%read tif stacks
function f=imreadstack(imname)
info = imfinfo(imname);
num_images = numel(info);
f=zeros(info(1).Height,info(1).Width,num_images);
h=waitbar(0,'Reading Image, Please wait...');
for k = 1:num_images
    waitbar(k/num_images,h,'Reading Image, Please wait...');
    f(:,:,k) =imread(imname, k);
end
close(h);






