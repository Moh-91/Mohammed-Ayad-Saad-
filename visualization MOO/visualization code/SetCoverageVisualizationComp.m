
C_N2_SC = SetCoverage(paretoFrontG2,paretoFrontSC);
C_SC_N2 = SetCoverage(paretoFrontSC,paretoFrontG2);
C_N3_SC = SetCoverage(paretoFrontG3,paretoFrontSC);
C_SC_N3 = SetCoverage(paretoFrontSC,paretoFrontG3);
C_WL_N2 = SetCoverage(paretoFrontWL,paretoFrontG2);
C_N2_WL = SetCoverage(paretoFrontG2,paretoFrontWL);
C_WL_N3 = SetCoverage(paretoFrontWL,paretoFrontG3);
C_N3_WL = SetCoverage(paretoFrontG3,paretoFrontWL);

%% figure all optimization Function together 
f1=figure(1);
    %% SC-MOPSO with NSGA2
    somedata=[C_SC_N2 C_N2_SC];
    somenames={ 'c(SC-MOPSO,NSGA-II)' ,'c(NSGA-II,SC-MOPSO)'};
    subplot(2,2,1);
    visualizBarPlot(somedata,somenames,'SC-MOPSO & NSGA II');

    %% SC_MOPSO with NSGA3

    somedata1=[C_SC_N3 C_N3_SC];
    somenames1={'c(SC-MOPSO,NSGA-III)' ,'c(NSGA-III,SC-MOPSO)'}
    subplot(2,2,2);
    visualizBarPlot(somedata1,somenames1,'SC-MOPSO & NSGA III');

    %% Whale with NSGA2
    somedata2=[C_WL_N2 C_N2_WL];
    somenames2={'c(Whale,NSGA-II)','c(NSGA-II,Whale)'};
    subplot(2,2,3);
    visualizBarPlot(somedata2,somenames2,'Whale & NSGA II');

    %% Whale with NSGA3

    somedata3=[C_WL_N3 C_N3_WL];
    somenames3={'c(Whale,NSGA-III)','c(NSGA-III,Whale)'};
    subplot(2,2,4);
    visualizBarPlot(somedata3,somenames3,'Whale & NSGA III');

%% figure SC-MOPSO with (NSGA2 & NSGA3)
f2=figure(2);
    %% SC-MOPSO with NSGA2
    subplot(1,2,1);
    visualizBarPlot(somedata,somenames,'SC-MOPSO & NSGA II');
     %% SC_MOPSO with NSGA3
    subplot(1,2,2);
    visualizBarPlot(somedata1,somenames1,'SC-MOPSO & NSGA III');
    
%% figure Whale with (NSGA2 & NSGA3)
f3=figure(3);
    %% Whale with NSGA2
    subplot(1,2,1);
    visualizBarPlot(somedata2,somenames2,'Whale & NSGA II');
    %% Whale with NSGA3
    subplot(1,2,2);
    visualizBarPlot(somedata3,somenames3,'Whale & NSGA III');
    
%%
f56=figure(56);
    % SCMOPSO with NSGA2 and NSGA3
    somedata=[C_SC_N2 C_N2_SC C_SC_N3 C_N3_SC];
    somenames={ 'c(SC-MOPSO,NSGA-II)' ,'c(NSGA-II,SC-MOPSO)','c(SC-MOPSO,NSGA-III)' ,'c(NSGA-III,SC-MOPSO)'};
    visualizBarPlot(somedata,somenames,'SCMOPSO ,NSGA II ,NSGA III');
%%
f57=figure(57);
    % Whale with NSGA2 and NSGA3
    somedata=[C_WL_N2 C_N2_WL C_WL_N3 C_N3_WL];
    somenames={ 'c(Whale,NSGA-II)' ,'c(NSGA-II,Whale)','c(Whale,NSGA-III)' ,'c(NSGA-III,Whale)'};
    visualizBarPlot(somedata,somenames,'Whale ,NSGA II ,NSGA III');
