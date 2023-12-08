%% initialization
clear;clc;close all;
%% adding required paths
currentFolder = pwd;
addpath([ currentFolder '/code']);
addpath([ currentFolder '/objective function']);

             %% ------------------- editable code ------------------------------- %%
global coverage_radious
coverage_radious=100;
popSize=200;
lowerBound_pos=[0 0];
heigherBound_pos=[1000 1000];
lowerBound_dim=[1 2 2];
higherBound_dim=[3 4 6];
numberOfIter=100;
RepSize=200;
p_mutation=1;
mutatedRatio=0.5;
nGrid=7;
alpha=0.1; 
w=0.5;
scale = 0.1;
shrink = 0.5;
minNumParticle=3;
NumScenario = 10 ;
% objfunctions
objFunc= {@objectiveFunctions};
objFunsStrings = 'objectiveFunctions';
nobj = 5;
path = ['../visualization MOO/Whale/'];
if ~exist(path, 'dir')
   mkdir(path)
end

for scenario=1:NumScenario
    rng(scenario);
    [pop,t,maxEnhancementTimeOut,paretoFront,NC, classes,pareto10iter,pareto_timeseries_everyIter]...
        =RunAlgorithm(alpha,nGrid,RepSize,scenario,popSize,nobj,lowerBound_pos,heigherBound_pos,lowerBound_dim,...
        higherBound_dim,numberOfIter,w,p_mutation,mutatedRatio,scale,shrink, minNumParticle);

    save([path '\scenario-' num2str(scenario)] ,'t','pareto10iter','pareto_timeseries_everyIter','paretoFront','NC','classes','maxEnhancementTimeOut','popSize' , 'higherBound_dim');
end
