function Islet_clip = Clip_Islet(Islet,I,shift_or_not)

    

Islet_clip = Islet;

Islet_clip(1).Time = Islet_clip(1).Time(I);
Islet_clip(1).GlobalSignal = Islet_clip(1).GlobalSignal(I);
Islet_clip(1).GlobalSignal_ori = Islet_clip(1).GlobalSignal_ori(I);

for i=1:length(Islet_clip)
    Islet_clip(i).Ca = Islet_clip(i).Ca(I);
    Islet_clip(i).Ca_very_ori = Islet_clip(i).Ca_very_ori(I);
    Islet_clip(i).Ca_ori = Islet_clip(i).Ca_very_ori;
    Islet_clip(i).entropy     = entropy([Islet(i).Ca(I)]);
end


if nargin==3
Islet_clip(1).Time = Islet_clip(1).Time-min(Islet_clip(1).Time);
end