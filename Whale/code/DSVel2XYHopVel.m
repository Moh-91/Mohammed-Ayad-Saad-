function [xVel,yVel,hopVel] = DSVel2XYHopVel(dataStructureVel)
xVel=[];
yVel=[];
hopVel=[];
 for j = 1 : length(dataStructureVel.ms)
    for u=1 : length(dataStructureVel.ms(j).NRP)
         xVel    = [xVel   ; dataStructureVel.ms(j).NRP(u).velocityX];
         yVel    = [yVel   ; dataStructureVel.ms(j).NRP(u).velocityY]; 
         hopVel  = [hopVel ; dataStructureVel.ms(j).NRP(u).velocityHop];
    end
end

