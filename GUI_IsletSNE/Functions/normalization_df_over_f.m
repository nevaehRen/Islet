function X = normalization_df_over_f(X)
    I  = sort(X);
    
    F0 = mean(I(1:2));

%     F0 = mean(I(1:5));
%     F0 = I(1);
%     if F0>100
%         X = (X-F0)/F0;
%     else 
%         X = (X-F0);
%     end
     X = (X-F0)/F0;
     X(isnan(X))=0;
     X(isinf(X))=0;

end