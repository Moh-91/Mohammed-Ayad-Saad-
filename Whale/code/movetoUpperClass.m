function [newParticle] = movetoUpperClass(class , exampler ,oldparticle ,difference )

newParticle=oldparticle;

for i =1 : difference
    r=randi(length(exampler.pos.ms));
    newParticle.pos.ms(end+1)= exampler.pos.ms(r);
    newParticle.vel.ms(end+1)= exampler.vel.ms(r);
    newParticle.pbest.ms(end+1)= exampler.pbest.ms(r);   
    for u = 1 : length(newParticle.pos.ms(end).NRP)
        newParticle.vel.ms(end).NRP(u).velocityX=0;
        newParticle.vel.ms(end).NRP(u).velocityY=0;
        newParticle.vel.ms(end).NRP(u).velocityHop=0;
    end
end

newParticle= Add_delete_RVs(newParticle,exampler , class);

end


