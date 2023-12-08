function [max_result,Number_of_MS]= Time(solution , Addjmatrix)

sum_distance= [];
Number_of_MS = 0;
for i = 1: length(solution.ms)
    matrix=[];
    for j=1 : length(solution.ms(i).NRP)
        matrix   = [matrix;solution.ms(i).NRP(j).pos] ;
    end
    if length(solution.ms(i).NRP) == 1
        distances = solution.ms(i).NRP(1).pos;
        break
    end
    [sorted_matrix , index]= sort(pdist2(matrix(1,:),matrix(2:end,:),'euclidean'));
    index=index+1;% fixing idex of array
    distances= [sorted_matrix(1);sorted_matrix(end)]; %distance from first point to the second point  
    for j = 1:length(index)-1 
        
              distances = [distances;pdist2(matrix(index(j+1),:),matrix(index(j),:),'euclidean')];
        
    end       
    sum_distance = [sum_distance, sum(distances)];
    Number_of_MS = Number_of_MS + 1;
end
max_result = max(sum_distance);
end