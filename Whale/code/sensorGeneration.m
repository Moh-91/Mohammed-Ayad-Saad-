clear all
for j=1:100
        sensors(j,:)=[rand(1,2)*1000 randi(10)];
        
end
    
save('sensors1')