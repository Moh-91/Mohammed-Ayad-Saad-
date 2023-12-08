function pos= mutationPso(pos,mutRatio,lowerBound,higherBound,sc)
sizePOS=size(pos);
numberOfMutated=round(sizePOS(1)*mutRatio);
mutatedIndices= round(unifrnd(1,sizePOS(1),1,numberOfMutated));
while length(unique(mutatedIndices)) < length(mutatedIndices)
mutatedIndices= round(unifrnd(1,sizePOS(1),1,numberOfMutated));
end
if rand<0.9
randNum = randn(1,numberOfMutated); % Normaly distribution
for i = 1 : length(higherBound)
    sc1 = sc*(higherBound(i)-lowerBound(i));
    pos(mutatedIndices,i) = pos(mutatedIndices,i)+sc1.*randNum';
    if i == 3
        pos(mutatedIndices,i) = round(pos(mutatedIndices,i)+sc1.*randNum');
    end
end
else
  for i = 1 : length(higherBound)
    pos(mutatedIndices,i) = unifrnd(lowerBound(i),higherBound(i),1,numberOfMutated); 
    if i == 3 
         pos(mutatedIndices,i) = round(unifrnd(lowerBound(i),higherBound(i),1,numberOfMutated)); 
    end
  end
end

end