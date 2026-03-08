
clear;

% Params used in Figure 6e
Params.slow_g      = 1/10;
Params.slow_s      = 1/10;
Params.tau_diff    = 5;
Params.alphaMass   = 2;   % 0.1 1 2
Params.s_ex        = 0;  
Params.h           = 5;

 
% % Params used in Figure 6g
% Params.slow_g      = 1/10;
% Params.slow_s      = 1/10;
% Params.tau_diff    = 5;
% Params.alphaMass   = 1.4;
% Params.s_ex        = 0;  % 0 0.2   0.5 
% Params.h           = 5;


F_nullcline.Params = Params;

temp_a = [];
temp_d = [];

for d   = 0:0.01:2
    F_alpha = @(a) Params.alphaMass*(a.^Params.h/(a.^Params.h+d.^Params.h ) + Params.slow_g) - a;
    for init_a = 0.1:0.1:2
        a   = fsolve(F_alpha,init_a);
        if (abs(F_alpha(a))<1e-4)&(a>0)
            temp_a = [temp_a a];
            temp_d = [temp_d d];
        end
    end
end

[~,r] = sort(temp_a);
F_nullcline.F_alpha = F_alpha;
F_nullcline.F_alpha_nullcline_a = temp_a(r);
F_nullcline.F_alpha_nullcline_d = temp_d(r);


temp_a = [];
temp_d = [];

for a   = 0:0.01:3
    F_delta = @(d) a.^Params.h./(a.^Params.h+d.^Params.h) + Params.slow_s +Params.s_ex   - d;
    d   = fsolve(F_delta,[0.1]);
    temp_a = [temp_a a];
    temp_d = [temp_d d];    
%     scatter(d,a,10,'r','filled')
end

% xlim([0 1.5])

[~,r] = sort(temp_a);
F_nullcline.F_delta = F_delta;
F_nullcline.F_delta_nullcline_a = temp_a(r);
F_nullcline.F_delta_nullcline_d = temp_d(r);

% Params = F_nullcline.Params;
a = [' tau_diff = ' strrep(num2str(Params.tau_diff),'.','_')];
b = [' alphaMass = ' strrep(num2str(Params.alphaMass),'.','_')];
c = [' s_ex = ' strrep(num2str(Params.s_ex),'.','_')];
d = [' h = ' strrep(num2str(Params.h),'.','_')];
% save(['Data ' a b c d '.mat'],'F_nullcline');

%%

Params = F_nullcline.Params;
a = [' tau_diff = ' strrep(num2str(Params.tau_diff),'.','_')];
b = [' alphaMass = ' strrep(num2str(Params.alphaMass),'.','_')];
c = [' s_ex = ' strrep(num2str(Params.s_ex),'.','_')];
d = [' h = ' strrep(num2str(Params.h),'.','_')];
figure(111); clf; hold on;
set(gcf,'Color','w');
hold on;
xlabel('\delta')
ylabel('\alpha')
title([a b c d]);
plot(F_nullcline.F_alpha_nullcline_d,F_nullcline.F_alpha_nullcline_a);
plot(F_nullcline.F_delta_nullcline_d,F_nullcline.F_delta_nullcline_a);
xlim([0 3]);
ylim([0 3]);


% saveas(gcf,['Data ' a b c d '.fig']);
% saveas(gcf,['Data ' a b c d '.png']);






