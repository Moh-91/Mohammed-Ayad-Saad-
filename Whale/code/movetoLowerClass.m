function [newParticle] = movetoLowerClass(class , exampler ,oldparticle ,difference)
newParticle=oldparticle;
for i = 1: abs(difference)
      r=randi(length(newParticle.pos.ms));
      newParticle.pos.ms(r)=[];
      newParticle.vel.ms(r)=[];
      newParticle.pbest.ms(r)=[];

end

newParticle= Add_delete_RVs(exampler,newParticle , class);
        
end

