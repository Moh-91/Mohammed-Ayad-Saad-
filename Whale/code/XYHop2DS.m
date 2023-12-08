function [dataStructure] = XYHop2DS(x ,y ,hop , class)
%convert X,Y ,Hops to datastructure 
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
        dataStructure.ms(i).NRP(j).pos=[x(k) y(k)] 
        dataStructure.ms(i).NRP(j).nHops=hop(k)
        k=k+1;
    end
    
 
end

