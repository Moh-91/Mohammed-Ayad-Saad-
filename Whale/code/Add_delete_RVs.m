function [oldparticle] = Add_delete_RVs(oldparticle,exampler , class)
class= num2str(class);
class=class(2:end);
for i = 1 :length(oldparticle.pos.ms)
    difference=length(oldparticle.pos.ms(i).NRP) - str2num(class(i)) ;
    if difference < 0
        for j = 1 : abs(difference)
            r=randi(length(exampler.pos.ms(i).NRP));
            le=length(oldparticle.pos.ms(i).NRP);
            oldparticle.pos.ms(i).NRP(le+1)= exampler.pos.ms(i).NRP(r);
            oldparticle.pbest.ms(i).NRP(le+1)= exampler.pbest.ms(i).NRP(r);
            len=length(oldparticle.pos.ms(i).NRP);
            oldparticle.vel.ms(i).NRP(len).velocityX=0;
            oldparticle.vel.ms(i).NRP(len).velocityY=0;
            oldparticle.vel.ms(i).NRP(len).velocityHop=0;
        end
    else
         for j = 1 : difference
             r=randi(length(exampler.pos.ms(i).NRP));
             oldparticle.pos.ms(i).NRP(r)=[];
             oldparticle.pbest.ms(i).NRP(r)=[];
             oldparticle.vel.ms(i).NRP(r)=[];
             
         end
    end
end
end

