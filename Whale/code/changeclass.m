 function [dataStructure1] = changeclass(class, dataStructure1 , difference)
sumhop=[]
str= num2str(class);
str= str(2:end);
hop1=[]
for i = 1 : length(dataStructure1.ms)
    hop1 = [dataStructure1.ms(i).NRP(j).nHops ] 
    sumhop = [sumhop ;sum(hop1)]
end
    sumhop = [sumhop ;sum(hop1)]
end
[sorted , index]= sort(sumhop)
for i = 1 ; difference
    dataStructure1.ms(index(i))=[]
end

for i = 1 ; length(dataStructure1.ms)
    if length(dataStructure1.ms(i).NRP)==num2str(str(i))
        continue
    else 
        difference= length(dataStructure1.ms(i).NRP)-num2str(str(i))
        if difference > 0   
            for i=1 : difference
                dataStructure1.ms(i).NRP(length(dataStructure1.ms(i).NRP)+1).pos=[rand*(higherBound_pos(1)-lowerBound_pos(1)) rand*(higherBound_pos(2)-lowerBound_pos(2))]
                dataStructure1.ms(i).NRP(length(dataStructure1.ms(i).NRP)+1).nHops=randi([lowerBound_dim(3) higherBound_dim(3)])
            end
        else 
            for i=1 : difference
               [minimum , index ]=sort([dataStructure1.ms(i).NRP.nHops]) 
               rmfield(dataStructure1,dataStructure1.ms(i).NRP(index(i))) 
            
        end
    end
end



end

