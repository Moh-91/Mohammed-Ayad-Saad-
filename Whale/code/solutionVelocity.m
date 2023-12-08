function [RVP] = solutionVelocity(particle)
% RVP= struct()
% RVP.ms=struct()
% Nms=length(particle.ms);
% class= Nms
% 
% for i=1:Nms
%     
%     Nrv =   length(particle.ms(i).NRP) 
%     RVP.ms(i).NRP=struct()
%   
%     for j=1:Nrv
%          RVP.ms(i).NRP.velocityX= zeros(1,Nrv);
%          RVP.ms(i).NRP.velocityY=zeros(1,Nrv);
%          RVP.ms(i).NRP.velocityHOP=zeros(1,Nrv);
%     end
RVP= struct();
RVP.ms=struct();
Nms= length(particle.ms);

for i=1:Nms
    RVP.ms(i).NRP=struct();
    Nrv = length(particle.ms(i).NRP);
    for j=1:Nrv 
        RVP.ms(i).NRP(j).velocityX=0;
        RVP.ms(i).NRP(j).velocityY=0;
        RVP.ms(i).NRP(j).velocityHop=0;

    end

end
end



