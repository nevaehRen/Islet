function [  Xlabel, cNums ] = CLA( X,neighborNums )
% Example:
%     X = [randn(1000,2)+ones(1000,2); randn(100,2)-ones(100,2)];
%     [idx,cNums]=CLA(X);
%     plot_cluster(idx,cNums,X);
% you can also preset parameters k, like:
%     [idx,cNums]=CLA(X,50);
%     plot_cluster(idx,cNums,X);
% citation: Z. Wang et al., "Clustering by Local Gravitation," in IEEE Transactions on Cybernetics, vol. 48, no. 5, pp. 1383-1396, May 2018.
%   


[rowNums,colNums]=size(X);

if nargin<2
    neighborNums=ceil(rowNums*0.1);
    if rowNums>100 && rowNums<1000
        neighborNums=10+ceil(rowNums*0.02);
    end
    if rowNums>1000
        neighborNums=ceil(rowNums*0.05);
        askNums=16;
    end
    if neighborNums>60
        neighborNums=60;
    end
end

askNums=6;
if rowNums>100 && rowNums<1000
    askNums=10;
end
if rowNums>1000
    askNums=16;
end
if rowNums>5000
    askNums=rowNums*0.005;
end



distMatrix=squareform(pdist(X));
Y=zeros(rowNums,colNums);
Xlabel=zeros(rowNums,1);
cNums=0;
mass=zeros(rowNums,1);
Ynorm=zeros(rowNums,1);
Xnext=-100*ones(size(Ynorm),'int32');
Xfinal=-1*ones(size(Ynorm),'int32');
XnextNums=zeros(size(Ynorm));
XtotalCE=zeros(size(Ynorm));
XNCE=zeros(size(Ynorm));
CO=zeros(size(Y));
sortDistMatrix=zeros(size(distMatrix));
sortDistMatrixIdx=zeros(size(distMatrix));

for m=1:rowNums
    [sortDistMatrix(m,:),sortDistMatrixIdx(m,:)]=sort(distMatrix(m,:));
    a=sortDistMatrix(m,:);
    idx=sortDistMatrixIdx(m,:);
    NormY=zeros(neighborNums,1);
    possibleY=zeros(neighborNums,colNums);
    for k=2:neighborNums
        deltaDist=X(idx(k),:)-X(m,:);
        if norm(deltaDist)~=0
            Y(m,:)=Y(m,:)+(deltaDist/norm(deltaDist));
        end
    end
    deltaDist=X(idx(neighborNums+1),:)-X(m,:);
    if norm(deltaDist)~=0
        possibleY(1,:)=Y(m,:)+(deltaDist/norm(deltaDist));
    end
    NormY(1)=norm(possibleY(1,:));
    for k=2:neighborNums
        deltaDist=X(idx(neighborNums+k),:)-X(m,:);
        if norm(deltaDist)~=0
            possibleY(k,:)=possibleY(k-1,:)+(deltaDist/norm(deltaDist));
        end
        NormY(k)=norm(possibleY(k,:));
    end
    [minNorm,idx2]=min(NormY);
    if minNorm<norm(Y(m,:));
        mass(m)=sum(a(2:neighborNums+idx2(1)));
        Y(m,:)=possibleY(idx2(1),:);
    else
        mass(m)=sum(a(2:neighborNums));
    end
    Y(m,:)=Y(m,:)*mass(m);
    Ynorm(m)=norm(Y(m,:));
end
sortYnorm=sort(Ynorm);
sortMass=sort(mass);


% data points with extre-small mass&&Norm are the seed for core
% smallYnorm=sortYnorm(ceil(rowNums*0.05));
% smallMass=sortMass(ceil(rowNums*0.05));
coreThdMass=sortMass(ceil(rowNums*0.7));
upYnorm=sortYnorm(ceil(rowNums*0.8))*neighborNums;
% upMass=sortMass(ceil(rowNums*0.995));

cType=zeros(rowNums,1);
coreNums=0;
boderNums=0;
CEscore=zeros(rowNums,1);
for m=1:rowNums
    resultantY=Y(m,:);
    coreScore=0;
    idx=sortDistMatrixIdx(m,:);
    currentNorm=Ynorm(m);
    iterNum=0;
    for k=2:neighborNums
        currentNorm=currentNorm+Ynorm(idx(k));
        resultantY=resultantY+Y(idx(k),:);
        deltaDist=X(m,:)-X(idx(k),:);
        if norm(deltaDist)~=0 && Ynorm(idx(k),:)~=0
            iterNum=iterNum+1;
            coreScore=coreScore+dot(deltaDist,Y(idx(k),:))/(norm(deltaDist)*Ynorm(idx(k),:));
        end
    end
    coreScore=coreScore/iterNum;
    coreScoreMax=coreScore;
    while currentNorm<upYnorm
        k=k+1;
        currentNorm=currentNorm+Ynorm(idx(k));
        resultantY=resultantY+Y(idx(k),:);
        deltaDist=X(m,:)-X(idx(k),:);
        if norm(deltaDist)~=0 && Ynorm(idx(k),:)~=0
            coreScore=coreScore*(iterNum)+dot(deltaDist,Y(idx(k),:))/(norm(deltaDist)*Ynorm(idx(k),:));
            iterNum=iterNum+1;
            coreScore=coreScore/iterNum;
        end
        if coreScoreMax<coreScore
            coreScoreMax=coreScore;
        end
    end
    CO(m)=dot(resultantY,Y(m,:));
    if coreScore<0.2 && CO(m)>0
        boderNums=boderNums+1;
        cType(m)=1;
    else
        if  coreScore>=-0.5 && mass(m)<=coreThdMass
            coreNums=coreNums+1;
            cType(m)=2;
        end
    end
    CEscore(m)=coreScore;
    %     maxIdx=-1;
    %     maxDot=0;
    %     for t=2:k
    %         cDot=dot(resultantY,Y(idx(t),:));
    %         if cDot>maxDot
    %             maxDot=cDot;
    %             maxIdx=idx(t);
    %         end
    %     end
    %     Xnext(m)=maxIdx;
end




% for m=1:rowNums
%     p=m
%     XnextNums(m)=XnextNums(m)+1;
%     cCE=CEscore(p);
%     iter=0;
%     while cCE>CEscore(Xnext(p))
%         p=Xnext(p);
%         XnextNums(m)=XnextNums(m)+1;
%         iter=iter+1;
%         if iter>20
%             break;
%         end
%     end
% end
%
%
% for m=1:rowNums
%     idx=sortDistMatrixIdx(m,:);
%     XnextNums(m)=XnextNums(m)+2;
%     XtotalCE(m)=XtotalCE(m)+CEscore(idx(k));
%     for k=2:rowNums
%         if (CEscore(idx(k))>CEscore(m))
%             break;
%         end
%         XnextNums(m)=XnextNums(m)+1;
%         XtotalCE(m)=XtotalCE(m)+CEscore(idx(k));
%         if CEscore(idx(k))<0
%             XNCE(m)=XNCE(m)+CEscore(idx(k));
%         end
%     end
% end



% Every point votes its neighbors to be examplar.
for m=1:rowNums
    idx=sortDistMatrixIdx(m,:);
    for t=2:neighborNums
        if CEscore(m)<CEscore(idx(t)) && Ynorm(m)>Ynorm(idx(t)) && dot(Y(m,:),X(idx(t),:)-X(m,:))>0
            Xnext(m)=idx(t);
            break;
        end
    end
end

%
for m=1:rowNums
    if Xnext(m)==-100
        idx=sortDistMatrixIdx(m,:);
        for t=2:neighborNums
            if CEscore(m)<CEscore(idx(t)) && dot(Y(m,:),X(idx(t),:)-X(m,:))>0
                Xnext(m)=idx(t);
                break;
            end
        end
    end
end

for m=1:rowNums
    if Xnext(m)==-100
        idx=sortDistMatrixIdx(m,:);
        for t=2:neighborNums
            if CEscore(m)<CEscore(idx(t))
                Xnext(m)=idx(t);
                break;
            end
        end
    end
end



localCenters=[];
for m=1:rowNums
    if Xnext(m)==-100
        localCenters=[localCenters,m];
    end
end


CdistMatrix=squareform(pdist(X(localCenters,:)));
lcNums=size(localCenters,2);
if lcNums>2
    isClustered=zeros(lcNums,1);
    cNums=0;
    clusters={};
    for m=1:lcNums
        if isClustered(m)==0
            cNums=cNums+1;
            isClustered(m)=isClustered(m)+1;
            clusters{cNums}=[m];
        else
            continue;
        end
        p=m;
        pOld=-1;
        while p~=pOld
            %             if isClustered(p)>0
            %                 break;
            %             end
            pOld=p;
            [a,Cidx]=sort(CdistMatrix(p,:));
            slcNums=min(50,lcNums);
            for k=2:slcNums
                if ~isempty(find(clusters{cNums}==Cidx(k),1))
                    continue;
                end
                % try to connect to its neighbors
                isConnected=0;
                pp=localCenters(p);
                searchTimes=0;
                while pp~=localCenters(Cidx(k)) && searchTimes<50
                    searchTimes=searchTimes+1;
                    DeltaDist=X(localCenters(Cidx(k)),:)-X(pp,:);
                    idx=sortDistMatrixIdx(pp,:);
                    maxAngle=0;
                    maxIdx=-1;
                    for l=2:askNums
                        if idx(l)==localCenters(Cidx(k)) && l<neighborNums
                            pp=localCenters(Cidx(k));
                            isConnected=1;
                            break;
                        end
                        if CEscore(idx(l))<0
                            continue;
                        end
                        if dot(DeltaDist,(X(idx(l),:)-X(pp,:)))<=0
                            continue;
                        end
                        midX=0.5*(X(idx(l),:)+X(pp,:));
                        mDist=X(localCenters(Cidx(k)),:)-midX;
                        cAngle=dot(DeltaDist,(X(idx(l),:)-X(pp,:)))/(norm(DeltaDist)*norm(((X(idx(l),:)-X(pp,:)))));
                        if cAngle>maxAngle && dot(mDist,X(idx(l),:)-X(pp,:))>0
                            maxAngle=cAngle;
                            maxIdx=idx(l);
                        end
                    end
                    if maxIdx==-1 || isConnected==1
                        break;
                    end
                    pp=maxIdx;
                end         %end while
                if isConnected==1
                    if isClustered(Cidx(k))<1
                        clusters{cNums}=[clusters{cNums},Cidx(k)];
                        isClustered(Cidx(k))=isClustered(Cidx(k))+1;
                        p=Cidx(k);
                        break;
                    else
                        for ooo=1:cNums
                            %                             if ~isempty(find(clusters{ooo}==Cidx(k),1))
                            %                                 clusters{cNums}=[clusters{cNums},clusters{ooo}]
                            %                                 clusters{ooo}=-1;
                            %                             end
                        end
                    end
                end
            end
        end
    end
    
    if sum(isClustered>1)>0
        isClustered
        pause
    end
    
    cNums=0;
    for m=1:size(clusters,2)
        cCluster=clusters{m};
        if size(cCluster,2)>0
            cNums=cNums+1;
            for k=1:size(cCluster,2)
                Xfinal(localCenters(cCluster(k)))=cNums;
            end
        end
    end
    
else
    for m=1:lcNums
        Xfinal(localCenters(m))=m;
    end
end

for m=1:rowNums
    p=m;
    cTrace=[];
    while Xfinal(p)<0
        cTrace=[cTrace,p];
        p=Xnext(p);
    end
    for k=1:size(cTrace,2)
        Xfinal(cTrace(k))=Xfinal(p);
    end
end
Xlabel = Xfinal;

Xlabel = sort_idx(Xlabel);


% possbileCentersNums=sum(Xnext<0);
% possbileCentersNumsTemp=0;
% while possbileCentersNumsTemp ~= possbileCentersNums
%     possbileCentersNumsTemp=possbileCentersNums
%     for m=1:rowNums
%         if Xnext(m)==-100
%             idx=sortDistMatrixIdx(m,:);
%             for t=2:2*neighborNums
%                 if CEscore(m)<CEscore(idx(t)) && Ynorm(m)>Ynorm(idx(t))
%                     Xnext(m)=idx(t);
%                     break;
%                 end
%             end
%         end
%     end
%     possbileCentersNums=sum(Xnext<0);
% end
%
% for m=1:rowNums
%     if Xnext(m)==-100
%         idx=sortDistMatrixIdx(m,:);
%         for t=2:2*neighborNums
%             if  CEscore(idx(t))>0 && CEscore(m)<CEscore(idx(t))
%                 Xnext(m)=idx(t);
%                 break;
%             end
%         end
%     end
% end


% for m=1:rowNums
%     tempTree=[];
%     p=m;
%     if CEscore(p)<0 && CO(p)>0
%         while Xfinal(p)==-1
%             tempTree=[tempTree, p];
%             if ~(CEscore(Xnext(p))<0 && CO(Xnext(p))>0)
%                 p=Xnext(p);
%                 tempTree=[tempTree, p];
%                 break;
%             end
%             if p==Xnext(p) || isempty(find(tempTree==Xnext(p),1))
%                 break;
%             end
%             p=Xnext(p);
%         end
%         if size(tempTree,1)>1
%             for iter=1:size(tempTree,1)
%                 Xfinal(tempTree(iter))=p;
%             end
%         end
%     end
% end









end




function idx_new = sort_idx(idx)
idx = double(idx);
I   = unique(idx);
for i=1:length(I)
    rank(i).num = sum(idx==I(i));
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


%% types According 
