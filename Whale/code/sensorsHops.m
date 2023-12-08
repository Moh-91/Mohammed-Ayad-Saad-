clear all
rng(2)
load('sensors.mat')
load('rvps.mat')
sizeSensors=size(sensors);

rvpPOSmat= [];  
for i=1:length(RVP)
    rvpPOSmat=[rvpPOSmat;RVP{i,1}];
end
rvpHOPmat= [];
for i=1:length(RVP)
    rvpHOPmat=[rvpHOPmat;RVP{i,2}];

end
%%%%% distance between every sensors and Randivue and get the minimum distance of them  %%%%%%%

sizeRvps        =size(rvpPOSmat);
addjmatDistance = pdist2(rvpPOSmat,sensors);
[minDistance , index] = min(addjmatDistance);


FirstHop=[];

for i = 1: sizeSensors(1)
        if minDistance(i) < 100
            FirstHop = [FirstHop;i index(i) rvpHOPmat(index(i),1) 1];
        end
end
path{length(FirstHop()),1} = [];

[AddjMatrix , path] = AddjMatrixFun(FirstHop,sensors,path, 1);
AddjMatrix (: , 5)  = randi(10,length(AddjMatrix),1);
trust_result        = Trust(rvpHOPmat , AddjMatrix , path );
energy_result       = Energy(rvpHOPmat , AddjMatrix , path );
[time_result ,cost] = Time(RVP , AddjMatrix);

result_final      = {'Trust_Result' 'Energy Result' 'Cost' 'Time Result'};
result_final{2,1} = trust_result ; 
result_final{2,2} = energy_result ;
result_final{2,3} = cost ;
result_final{2,4} = time_result ;

