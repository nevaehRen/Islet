function X = normalization_0_to_1(X)
    X = (X-min(X))/(max(X)-min(X));
    X(isnan(X))=0;
    X(isinf(X))=0;
%     F0 = I(1);
%     if F0>100
%         X = (X-F0)/F0;
%     else 
%         X = (X-F0);
%     end
end