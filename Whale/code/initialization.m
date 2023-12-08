function [pop, numberOfClasses, classes]= initialization(popSize,nobj,lowerBound_pos,higherBound_pos,lowerBound_dim,higherBound_dim)

pop(popSize)=struct();
for i=1:popSize

    [pop(i).pos ,classes{i,1} , dim]=generateSolution(lowerBound_pos,higherBound_pos,lowerBound_dim,higherBound_dim );
    classes{i,2}=dim;
    pop(i).cost=zeros(1,nobj);
    pop(i).vel=solutionVelocity(pop(i).pos);
    pop(i).cont=0;
    pop(i).IsDominated=false;
    pop(i).pbest=pop(i).pos
    pop(i).GridIndex=[];
    pop(i).GridSubIndex=[];
    pop(i).class = classes{i,1};
end
for i =1 :length(classes)
    classes{i,3}=str2num(classes{i,1});
end
numberOfClasses= length( unique(cell2mat(classes(:,3))));
classes=unique(cell2mat(classes(:,3)));

end
    