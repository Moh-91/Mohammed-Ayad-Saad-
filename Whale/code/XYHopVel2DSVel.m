function [dataStructure] = XYHopVel2DSVel(xVel,yVel,hopVel,class)
% convert the velocity of X,Y,Hop vectors to datastructure 
class = num2str(class)
dataStructure= struct()
dataStructure.ms=struct()
Nms= str2num(class(1))
class=class(2:end)
k=1;
for i=1 : Nms
    dataStructure.ms(i).NRP=struct()
    Nrv =  str2num(class(i))  
    for j=1:Nrv 
        dataStructure.ms(i).NRP(j).velocityX=xVel(k)
        dataStructure.ms(i).NRP(j).velocityY=yVel(k)
        dataStructure.ms(i).NRP(j).velocityHop=hopVel(k)
        k=k+1;
    end
end

