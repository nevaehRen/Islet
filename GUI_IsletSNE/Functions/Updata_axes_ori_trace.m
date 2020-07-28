function Updata_axes_ori_trace(Islet,I)
% updata islet global trace with interested I

plot(Islet(1).GlobalSignal, 'k');

if nargin==2
    s = (I(2:end) - I(1:end-1))~=1;
    I_start = [I(logical([1 s(1:end-1)]))];
    I_last  = [I(s) I(end)]-I_start;
    for i=1:length(I_last)
        StimBars(I_start(i),I_last(i));
    end
end

% xlabel('t');
ylabel('Ca');
set(gca,'linewidth',1.5 , 'Fontsize', 10, 'Fontname' , 'Comic Sans MS');

end

