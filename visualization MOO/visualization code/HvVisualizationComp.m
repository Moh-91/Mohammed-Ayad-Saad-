%% hypervolum using production strategy
    paretoall      = [paretoFrontSC;paretoFrontG2;paretoFrontWL;paretoFrontG3];
    Ref_Point      = max(paretoall)+10;
    hyperVol_vl    = HyperVolume(paretoFrontSC(:,1:3) , Ref_Point(:,1:3)');
    hyperVol_vl_1  = HyperVolume(paretoFrontSC(:,4:5) , Ref_Point(:,4:5)');
    hyperVol_n2    = HyperVolume(paretoFrontG2(:,1:3) , Ref_Point(:,1:3)');
    hyperVol_n2_1  = HyperVolume(paretoFrontG2(:,4:5) , Ref_Point(:,4:5)');
    hyperVol_wl    = HyperVolume(paretoFrontWL(:,1:3) , Ref_Point(:,1:3)');
    hyperVol_wl_1  = HyperVolume(paretoFrontWL(:,4:5) , Ref_Point(:,4:5)');
    hyperVol_n3    = HyperVolume(paretoFrontG3(:,1:3) , Ref_Point(:,1:3)');
    hyperVol_n3_1  = HyperVolume(paretoFrontG3(:,4:5) , Ref_Point(:,4:5)');
    h1             = hyperVol_vl * hyperVol_vl_1;
    h2             = hyperVol_n2 * hyperVol_n2_1;
    h3             = hyperVol_wl * hyperVol_wl_1;
    h4             = hyperVol_n3 * hyperVol_n3_1;

    v_VL(Scenario) = h1;
    v_N2(Scenario) = h2;
    v_WL(Scenario) = h3;
    v_N3(Scenario) = h4;
    
 %% Hyper volum using mean strategy 
    HV =[];
    pareto  = ["paretoFrontSC","paretoFrontG2","paretoFrontWL","paretoFrontG3"];
    for i = 1 : nOpt
        paretoF=eval(pareto(i));
        tmp = [paretoF(:,1),paretoF(:,2)];
        hv12 = HyperVolume(tmp);
        tmp = [paretoF(:,1),paretoF(:,3)];
        hv13 = HyperVolume(tmp);
        tmp = [paretoF(:,1),paretoF(:,4)];
        hv14= HyperVolume(tmp);
        tmp = [paretoF(:,1),paretoF(:,5)];
        hv15 = HyperVolume(tmp);
        tmp = [paretoF(:,2),paretoF(:,3)];
        hv23 = HyperVolume(tmp);
        tmp = [paretoF(:,2),paretoF(:,4)];
        hv24 = HyperVolume(tmp);
        tmp = [paretoF(:,2),paretoF(:,5)];
        hv25 = HyperVolume(tmp);
        tmp = [paretoF(:,3),paretoF(:,4)];
        hv34 = HyperVolume(tmp);
        tmp = [paretoF(:,3),paretoF(:,5)];
        hv35 = HyperVolume(tmp);
        tmp = [paretoF(:,4),paretoF(:,5)];
        hv45 = HyperVolume(tmp);
        hv = mean([hv12 hv13 hv14 hv15 hv23 hv24 hv25 hv34 hv35 hv45]);
        HV = [HV;hv];
    end
%% figure for HV-production of all optimization function 
f7=figure(7);
    somedata=[h1,h2,h4];
    somenames={'SC-MOPSO','NSGA-II','NSGA-III'};
    subplot(1,2,1);
    visualizBarPlot(somedata,somenames,'HV production (SC-MOPSO & NSGA2 & NSGA3)');


    somedata1=[h3,h2,h4];
    somenames1={'Whale','NSGA-II','NSGA-III'};
    subplot(1,2,2);
    visualizBarPlot(somedata1,somenames1,'HV production (Whale & NSGA2 & NSGA3)');
%% figure for HV-production of SCMOPSO
     visualizeBarPlotFigure(somedata,somenames,'HV production (SC-MOPSO & NSGA2 & NSGA3)',[fd '/HV-production(all-Opt)-scenario' num2str(Scenario)]);

%% figure for HV-production of Whale  
    visualizeBarPlotFigure(somedata1,somenames1,'HV production (Whale & NSGA2 & NSGA3)',[fd '/HV-production(Whale with (N2,N3))-scenario' num2str(Scenario)])

%% figure for HV-mean of all optimization function 
f10=figure(10);   
    somedata2=[HV(1),HV(2),HV(4)];
    somenames2={'SC-MOPSO','NSGA-II','NSGA-III'};
    subplot(1,2,1);
    visualizBarPlot(somedata2,somenames2,'HV mean (SC-MOPSO & NSGA2 & NSGA3)');
    
    somedata3=[HV(3),HV(2),HV(4)];
    somenames3={'Whale','NSGA-II','NSGA-III'};
    subplot(1,2,2);
    visualizBarPlot(somedata3,somenames3,'HV mean (Whale & NSGA2 & NSGA3)');
%% figure for HV-mean of SCMOPSO 
visualizeBarPlotFigure(somedata2,somenames2,'HV mean (SC-MOPSO & NSGA2 & NSGA3)',[fd '/HV-mean(SCMOPSO with (N2,N3)-scenario' num2str(Scenario)]);

%%
visualizeBarPlotFigure(somedata2,somenames2,'HV mean (SC-MOPSO & NSGA2 & NSGA3)',[fd '/HV-mean(SCMOPSO with (N2,N3)-scenario' num2str(Scenario)]);

%% figure for HV-mean of Whale
visualizeBarPlotFigure(somedata3,somenames3,'HV mean (Whale & NSGA2 & NSGA3)',[fd '/HV-mean(Whale with (N2,N3))-scenario' num2str(Scenario)]);
% end