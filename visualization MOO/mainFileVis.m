%% initialization and adding required paths
clear;clc;close all;
currentFolder=pwd;
currentFolder(currentFolder=='\')='/';
p=pwd;
p(p=='\')='/';
addpath([currentFolder '/visualization code']);

%% number of objective function , in our example is  (Trust , Energy ,Cost , Time , Non-coveragre)
nobjs = 5;

%% number of optimization algorithm to compare 
nOpt = 4 ;
%% number of Scenario and iterations 
nScenario = 10 ; 
numberofIter=10;
path = ['../visualization MOO/results']
%%
Objectivenames={'Trust','Energy','Cost','Time','Noncoverage'};
Optimizenames={'SCMOPSO','Whale','NSGA2','NSGA3'};
OptObservasion= {'SC','WL','N2','N3'};
pareto10IterNames={'pareto10iterSC','pareto10iterWL','pareto10iterG2','pareto10iterG3'};
paretoNames = {'paretoFrontSC','paretoFrontWL','paretoFrontG2','paretoFrontG3'};
numberofIter=10;
%% plotting convergence
fd = [path '/results images_convergence/'];
convergences;
%% run barPlot visualization 
fd=[path '/results images barplot/'];
AllMeasuresBars;
%% run boxPlot visualization
fd=[path '/results images boxplot/'];
boxPlotAll;

%% the end