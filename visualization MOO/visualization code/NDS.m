
n_scmopso=length(paretoFrontSC);
n_nsga2=length(paretoFrontG2);
n_nsga3=length(paretoFrontG3);
n_whale=length(paretoFrontWL);

%% figure NDS for all optimization function
somedata=[n_scmopso,n_nsga2,n_nsga3,n_whale];
somenames={'SC-MOPSO','NSGA-II','NSGA-III','Whale'};
visualizeBarPlotFigure(somedata,somenames,'NDS',[fd '/NDS(all_Opt)-scenario' num2str(Scenario)]);

%% figure NDS for SCMOPSO with (NSGA2 & NSGA3)
somedata=[n_scmopso,n_nsga2,n_nsga3];
somenames={'SC-MOPSO','NSGA-II','NSGA-III'};
visualizeBarPlotFigure(somedata,somenames,'NDS',[fd '/NDS(SCMOPSO with (N2,N3))-scenario' num2str(Scenario)]);

%% figure NDS for Whale with (NSGA2 & NSGA3)
somedata=[n_whale,n_nsga2,n_nsga3];
somenames={'Whale','NSGA-II','NSGA-III'};
visualizeBarPlotFigure(somedata,somenames,'NDS',[fd '/NDS(Whale with (N2,N3))-scenario' num2str(Scenario)]);
