
for Scenario=1:nScenario
    AddRequiredPaths;
    paretoall  = [];
    for i  =  1 : nOpt
        paretoall = [paretoall ; eval([paretoNames{i}])];
    end 
%% calculate hypervolume using production strategy
    Ref_Point      = max(paretoall)+10;
    if nobjs > 0   
        for i = 1 : nOpt
             str = ['hyperVol_' OptObservasion{i} '=HyperVolume(' paretoNames{i} '(:,1:round(nobjs/2)), Ref_Point(:,1:round(nobjs/2))'')' ];
             eval(str)
             str = ['hyperVol_' OptObservasion{i} '_1=HyperVolume(' paretoNames{i} '(:,round(nobjs/2)+1:nobjs), Ref_Point(:,round(nobjs/2)+1:nobjs)'')' ];
             eval(str)
             str = ['v_' OptObservasion{i} '_production(' num2str(Scenario) ')=' 'hyperVol_' OptObservasion{i} '*' 'hyperVol_' OptObservasion{i} '_1;']
             eval(str);
        end
    end

  
%% Hyper volum using mean strategy 
 
    for i = 1 : nOpt
        hv=[];
        for j=1 : nobjs
            for u=j+1 : nobjs
                str = ['hyperVol = [' paretoNames{i} '(:,j),'  paretoNames{i} '(:,u)];' ];
                eval(str);
                hvValue=HyperVolume(hyperVol);
                hv = [hv hvValue];
     
            end  
        end 
        mean_hv = mean(hv);
        str = ['v_' OptObservasion{i} '_mean(' num2str(Scenario) ')=mean_hv ;'];
        eval(str);

    end
end
data_mean= []; 
data_production = []; 
for i = 1 : nOpt
    data_mean = [data_mean eval(['v_' OptObservasion{i} '_mean'''])];
    data_production = [data_production eval(['v_' OptObservasion{i} '_production'''])];
end

%%
%% figure for HV-mean of all optimization function  
visualizeBoxPlotFigure(data_mean,Optimizenames,'Comparison between Optimization algorithm in terms of HV within 10 Scenarios ',[fd '/HV-mean(all_Opt)'])

%% figure for HV-production of all optimization function  
visualizeBoxPlotFigure(data_production,paretoNames,'Comparison between Optimization algorithm in terms of HV within 10 Scenarios ',[fd '/HV-production(all_Opt)'])

%% save xlsx for HV_mean
folder = [path '/results xlsx'];
if ~exist(folder,'dir')
     mkdir(folder);
end 

T = [] ;
tt = {} ; 
for i = 1 : nOpt
    str = [Optimizenames{i} '=' 'v_' OptObservasion{i}  '_mean''']; 
    eval(str);
    T = [T , eval([Optimizenames{i}])];
    tt{end+1} = [Optimizenames{i}] ;
end 

baseFileName = 'Comp all algo in terms of HV_mean measure for 10 Scenarios.xlsx';
fullFileName = fullfile(folder, baseFileName);

xlswrite(fullFileName,tt,'Range','A1');
xlswrite(fullFileName,T,'Range','A2');


%% save xlsx for HV_production
T = [] ;
tt = {} ; 
for i = 1 : nOpt
    str = [Optimizenames{i} '=' 'v_' OptObservasion{i}  '_production''']; 
    eval(str);
    T = [T , eval([Optimizenames{i}])];
    tt{end+1} = [Optimizenames{i}] ;
end 

baseFileName = 'Comp all algo in terms of HV_production measure for 10 Scenarios.xlsx';
fullFileName = fullfile(folder, baseFileName);

xlswrite(fullFileName,tt,'Range','A1');
xlswrite(fullFileName,T,'Range','A2');



%%
disp('saving is done');
