function [RVP , class , dim] = generateSolution(lowerBound_pos,higherBound_pos,lowerBound_dim,higherBound_dim  )
RVP= struct();
RVP.ms=struct();
Nms= randi([lowerBound_dim(1) higherBound_dim(1)]);
class= Nms;
dim=0;
for i=1:Nms
    RVP.ms(i).NRP=struct();
    Nrv = randi([lowerBound_dim(2) higherBound_dim(2)]);  
    for j=1:Nrv 
        RVP.ms(i).NRP(j).pos=[rand*(higherBound_pos(1)-lowerBound_pos(1)) rand*(higherBound_pos(2)-lowerBound_pos(2))]; 
        RVP.ms(i).NRP(j).nHops=randi([lowerBound_dim(3) higherBound_dim(3)]);

    end
    dim= dim +Nrv*3;
    class =strcat(num2str(class),num2str(Nrv));
end
end

