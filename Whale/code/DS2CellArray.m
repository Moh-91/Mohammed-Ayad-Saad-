function [RVP_CellArray] = DS2CellArray(DataStructure)
for i = 1 : length(DataStructure.ms)
    pos=[];
    nHops=[];
    for j =1 : length(DataStructure.ms(i).NRP)
        pos=[pos;DataStructure.ms(i).NRP(j).pos];
        nHops=[nHops;DataStructure.ms(i).NRP(j).nHops];
    end
    RVP_CellArray{i,1}=pos
    RVP_CellArray{i,2}=nHops
end

