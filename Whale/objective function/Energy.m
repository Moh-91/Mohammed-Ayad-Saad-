function [sumFinalResult] = Energy(RvpHopmat , AddjMatrix , path )
    AddjMatrix (: , 6)= 0.01;
    finalresult= [];
    for i = 1 : length(RvpHopmat)
        sum_each_RV    = [];
        number_of_hops = RvpHopmat(i);
        for j = 1 : RvpHopmat(i)
            index          = find(AddjMatrix(:,2)==i &AddjMatrix(:,4)==j);
            sum_each_RV    = [sum_each_RV ;sum(power(AddjMatrix(index,6),number_of_hops))];
            number_of_hops = number_of_hops - 1;
        end
        finalresult  = [finalresult;sum(sum_each_RV)];
    end
    sumFinalResult = sum (finalresult);     
end