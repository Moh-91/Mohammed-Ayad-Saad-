 function [sumFinalResult]=Trust(RvpHopmat , AddjMatrix , path )
    
    sum_each_RV=[];
    for i = 1 : length(RvpHopmat) 
        sum_each_hop=[];
        for j = 1 : RvpHopmat(i)  
            index=find(AddjMatrix(:,2)==i &AddjMatrix(:,4)==j);
            if ~isempty(index)
                if j==1
                    sum_each_hop=[sum_each_hop;mean(AddjMatrix(index,5))];
                else
                    production=[];
                    for u = 1: length(index)       
                          production=[production;min([AddjMatrix(find(ismember(AddjMatrix(:,1),cell2mat(path(index(u),1)))),5); AddjMatrix(index(u),5)])];     
                    end
                    sum_each_hop = [sum_each_hop ;mean(production)];
                end 
            end
        end
        if ~isempty(sum_each_hop)
            sum_each_RV= [sum_each_RV;mean(sum_each_hop)];
        end
    end
    sumFinalResult = mean (sum_each_RV) ;
 end