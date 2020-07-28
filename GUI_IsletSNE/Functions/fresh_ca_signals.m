function Islet = fresh_ca_signals(Islet)

for i=1:length(Islet)
    Ca               = Islet(i).Ca_very_ori;
    Islet(i).Ca      = normalization_0_to_1(Ca(:));
    Islet(i).Ca_0_1  =  normalization_0_to_1(Ca(:));
    Islet(i).Ca_df_f =  normalization_df_over_f(Ca(:));
end

end