% clear;close all;
for Scenario=1:nScenario
    AddRequiredPaths;
    for i = 1 : nOpt
        for j = 1 : nOpt
            if i == j 
                continue;
            end
            str = ['C_' OptObservasion{i} '_' OptObservasion{j} '(' num2str(Scenario) ')' '=SetCoverage(' paretoNames{i} ',' paretoNames{j} ');' ];
            eval(str);
        end
    end    
end
% 
%% figure set-coverage
for i = 1 : nOpt
    for j = i : nOpt
        if i == j 
            continue;
        end
        data = ['[C_' OptObservasion{i} '_' OptObservasion{j} '''' ' ' 'C_' OptObservasion{j} '_' OptObservasion{i} ''']'];
        Xlabel = {['C(' Optimizenames{i} ',' Optimizenames{j} ')'] , ['C(' Optimizenames{j} ',' Optimizenames{i} ')'] };
        visualizeBoxPlotFigure(eval(data),Xlabel,'Comparison between optimization algorithm in terms of SetCoverage within 10 Scenarios ',[fd 'SetCoverage(' OptObservasion{i} '&' OptObservasion{j} ')'])
    end 
end

%% save xlsx
folder = [path '/results xlsx'];
if ~exist(folder,'dir')
     mkdir(folder);
end 
T = [] ;
tt = {} ; 
for i = 1 : nOpt
    for j = 1 : nOpt
        if i == j 
            continue;
        end
        str = [Optimizenames{i} '_' Optimizenames{j} '=' 'C_' OptObservasion{i} '_' OptObservasion{j} ''''];
        eval(str);
        T = [T ,eval([Optimizenames{i} '_' Optimizenames{j}])]
        tt{end+1} = ['C(' OptObservasion{i} '_' OptObservasion{j} ')'] ;
    end 
end 

baseFileName = 'Comparesion SetCoverage 10 Scenarios.xlsx';
fullFileName = fullfile(folder, baseFileName);

xlswrite(fullFileName,tt,'Range','A1')
xlswrite(fullFileName,T,'Range','A2')
%%
