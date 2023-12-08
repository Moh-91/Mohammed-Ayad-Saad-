%% initialization and adding required paths
%% generate all 10 scenarios measures figures and paretoFront using bars
for Scenario=1:10
    clc;
    disp(['Scenario: ' num2str(Scenario)]);
    AddRequiredPaths;

    if ~exist(fd,'dir')
        mkdir(fd);
    end

    SetCoverageVisualizationComp;

    NDS;

    HvVisualizationComp;

    %timeComp;



    %%
    clc;disp('save is done');
    close all;
end
%% the end