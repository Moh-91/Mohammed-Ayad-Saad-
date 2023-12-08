function [connectedsensors ,path, rvpPOSmat,rvpHOPmat,Non_conneted_sensors] = FinalAddjMatrix(individual_solution)
global coverage_radious
%global sensors
load('sensors.mat')
sizeSensors=size(sensors);


%% take 2 vectors of  positions and Nhops of individual solution 
rvpPOSmat= [];  
rvpHOPmat= [];
for i=1:length(individual_solution.ms)
    for j = 1 :length(individual_solution.ms(i).NRP )
        rvpHOPmat=[rvpHOPmat;individual_solution.ms(i).NRP(j).nHops];
        rvpPOSmat=[rvpPOSmat;individual_solution.ms(i).NRP(j).pos];
    end
end
%% calculate the distance between positions of RV and sensors positions to get the sensors that is near to RV point and 
%  calculate the fist hop of RV point
sizeRvps        =size(rvpPOSmat);
addjmatDistance = pdist2(rvpPOSmat,sensors(:,1:2));
[minDistance , index] = min(addjmatDistance);

FirstHop=[];

for i = 1: sizeSensors(1)
        if minDistance(i) < coverage_radious
            FirstHop = [FirstHop;i index(i) rvpHOPmat(index(i),1) 1 sensors(i,3)];
        end
end
%% calculate the all hops of RV point using addjencecy matrix  

size_FirstHop=size(FirstHop);
if(size_FirstHop > 0)
    path{size_FirstHop(1),1} = [];
    [connectedsensors , path] = AddjMatrixFun(FirstHop,sensors,path, 1);
    sizeAdd=size(connectedsensors);
    Non_conneted_sensors=sizeSensors(1)-sizeAdd(1);
else
    connectedsensors=[];
    Non_conneted_sensors=sizeSensors(1);
    path=[];
end

