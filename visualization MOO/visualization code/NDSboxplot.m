
for Scenario=1:nScenario
    AddRequiredPaths;
    for i = 1 : nOpt
        str = ['nds_' OptObservasion{i} '(' num2str(Scenario) ')=length(' paretoNames{i} ');' ];
        eval(str);
    end 

end
%% figure NDS all optimization Function 
data = [];
Xlabel={};
for i = 1 : nOpt
    data = [data eval(['nds_' OptObservasion{i} ''''])];
    Xlabel{end+1} = Optimizenames{i} ;        
end
visualizeBoxPlotFigure(data,Xlabel,'Comparison between optimization algorithm in terms of NDS within 10 Scenarios ',[fd 'NDS'])

%% save xlsx
folder = [path '/results xlsx'];
if ~exist(folder,'dir')
     mkdir(folder);
end 
T = [] ;
tt = {} ; 
for i = 1 : nOpt
    str = [Optimizenames{i}  '=' 'nds_' OptObservasion{i} ''''];
    eval(str);
    T = [T ,eval([Optimizenames{i}])]
    tt{end+1} = Optimizenames{i};
end 

baseFileName = 'Comparesion NDS 10 Scenarios.xlsx';
fullFileName = fullfile(folder, baseFileName);

xlswrite(fullFileName,tt,'Range','A1')
xlswrite(fullFileName,T,'Range','A2')
