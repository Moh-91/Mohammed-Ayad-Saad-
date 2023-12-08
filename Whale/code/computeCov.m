function cov=computeCov(pos,env)
c=0;
d=zeros(length(env.sensors),length(pos.x));
for s=1:length(env.sensors)
    xyS=[env.sensors(s).x env.sensors(s).y];
    for r=1:length(pos.x)
        xyR=[pos.x(r) pos.y(r)];
        d(s,r)=equlidianDist(xyS,xyR);
    end
end
for s=1:size(d,1)
   if min(d(s,:))>3
       c=c+1;
   end
end
cov=(length(env.sensors)-c)/length(env.sensors);
end
    