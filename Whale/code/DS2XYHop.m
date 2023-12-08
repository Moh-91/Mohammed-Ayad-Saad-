function [x,y,hop] = DS2XYHop(dataStruct)

x=[];
y=[];
hop=[];
 for j = 1 : length(dataStruct.ms)
    for u=1 : length(dataStruct.ms(j).NRP)
         x    = [x   ; dataStruct.ms(j).NRP(u).pos(1)];
         y    = [y   ; dataStruct.ms(j).NRP(u).pos(2)]; 
         hop  = [hop ; dataStruct.ms(j).NRP(u).nHops];
    end
end

