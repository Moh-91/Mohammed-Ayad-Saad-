%% path initializing
nobjArr=nobjs*ones(1,10);
currentFolder = pwd;
currentFolder(currentFolder=='\')='/';

%% loading sc_vlmopso results
results_SC=load([currentFolder '/SCMOPSO/scenario-' num2str(Scenario)]);
paretoFrontSC=results_SC.paretoFront.solutionsObjectiveValues;
paretoSetSC=results_SC.paretoFront.solutions;
classesSC=results_SC.classes;
NCSC=results_SC.NC;
pareto10iterSC=results_SC.pareto10iter;
%% loading whale results
result_WL=load([currentFolder '/Whale/scenario-' num2str(Scenario)]);
paretoFrontWL=result_WL.paretoFront.solutionsObjectiveValues;
paretoSetWL=result_WL.paretoFront.solutions;
classesWL=result_WL.classes;
NCWL=result_WL.NC;
pareto10iterWL=result_WL.pareto10iter;
%% loading nsga2 results
nsga2=load([currentFolder '/NSGA II/scenario-' num2str(Scenario)]);
paretoFrontG2=nsga2.paretoFront.solutionsObjectiveValues;
paretoSetG2=nsga2.paretoFront.solutions;
pareto10iterG2=nsga2.pareto10iter;
%% loading nsga3 results 
nsga3=load([currentFolder '/NSGA III/scenario-' num2str(Scenario)]);
paretoFrontG3=nsga3.paretoFront.solutionsObjectiveValues;
paretoSetG3=nsga3.paretoFront.solutions;
pareto10iterG3=nsga3.pareto10iter;


