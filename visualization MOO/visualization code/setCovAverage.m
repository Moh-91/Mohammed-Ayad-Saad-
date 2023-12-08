% clear;close all;
cont = 1;
for problemNumber=10:14
for Scenario=1:10
    AddRequiredPaths;
    C_VL_MOmut = SetCoverage2(paretoFrontvl,paretoFront);
    C_MOmut_VL = SetCoverage2(paretoFront,paretoFrontvl);
    C_MOmut_MO(cont) = SetCoverage2(paretoFront,paretoFrontwm);
        C_MOmut_N2(cont) = SetCoverage2(paretoFront,pno);
        C_MOmut_WS(cont) = SetCoverage2(paretoFront,paretoFrontws);

    C_MO_VL = SetCoverage2(paretoFrontwm,paretoFrontvl);
     C_MO_MOmut(cont) = SetCoverage2(paretoFrontwm,paretoFront);
     C_MO_N2(cont) = SetCoverage2(paretoFrontwm,pno);
     C_MO_WS(cont) = SetCoverage2(paretoFrontwm,paretoFrontws);
     
    C_VL_MO = SetCoverage2(paretoFrontvl,paretoFrontwm);
    C_WS_VL = SetCoverage2(paretoFrontws,paretoFrontvl);
    C_WS_MOmut(cont) = SetCoverage2(paretoFrontws,paretoFront);
    C_WS_MO(cont) = SetCoverage2(paretoFrontws,paretoFrontwm);
     C_WS_N2(cont) = SetCoverage2(paretoFrontws,pno);
     
    C_VL_WS = SetCoverage2(paretoFrontvl,paretoFrontws);
    C_VL_N2 = SetCoverage2(paretoFrontvl,pno);
    C_N2_VL = SetCoverage2(pno,paretoFrontvl);
     C_N2_MOmut(cont) = SetCoverage2(pno,paretoFront);
     C_N2_MO(cont) = SetCoverage2(pno,paretoFrontwm);
      C_N2_WS(cont) = SetCoverage2(pno,paretoFrontws);
     
     
    
meanC_VL_MOmut(cont)=(C_VL_MOmut);
meanMOmut_VL(cont)=(C_MOmut_VL);
meanC_MO_VL(cont)=(C_MO_VL);
meanC_VL_MO(cont)=(C_VL_MO);
meanC_WS_VL(cont)=(C_WS_VL);
meanC_VL_WS(cont)=(C_VL_WS);
meanC_VL_N2(cont)=(C_VL_N2);
meanC_N2_VL(cont)=(C_N2_VL);
cont = cont + 1;
end
end
[~,pvm]=ttest(meanC_VL_MOmut,meanMOmut_VL);
[~,pvws]=ttest(meanC_WS_VL,meanC_VL_WS);
[~,pvwm]=ttest(meanC_MO_VL,meanC_VL_MO);
[~,pvn]=ttest(meanC_VL_N2,meanC_N2_VL);
%% save xlsx
SC_MOPSO__m_MOPSO = C_VL_MOmut'; 
m_MOPSO__SC_MOPSO = C_MOmut_VL'; 
SC_MOPSO__MOPSO = C_VL_MO'  ;
MOPSO__SC_MOPSO = C_MO_VL'  ;
SC_MOPSO__NSGA_II = C_VL_N2' ;
NSGA_II__SC_MOPSO = C_N2_VL' ;
SC_MOPSO__WS_VLPSO = C_VL_WS';
WS_VLPSO__SC_MOPSO = C_WS_VL';
T=[SC_MOPSO__m_MOPSO, m_MOPSO__SC_MOPSO, SC_MOPSO__MOPSO,...
    MOPSO__SC_MOPSO ,SC_MOPSO__NSGA_II, NSGA_II__SC_MOPSO ,SC_MOPSO__WS_VLPSO,WS_VLPSO__SC_MOPSO];
baseFileName = 'Comparison between SC-MOPSO and other algorithms in terms of C Metric for Fonseca & ZDT functions.xlsx';
fold=[cd '/tables'];
fullFileName = fullfile(fold, baseFileName);
 tt={'C(SC-MOPSO,m-MOPSO)'...
    ,'C(m-MOPSO,SC-MOPSO)','C(SC-MOPSO,MOPSO)','C(MOPSO,SC-MOPSO)','C(SC-MOPSO,NSGA-II)','C(NSGA-II,SC-MOPSO)','C(SC-MOPSO,WS-VLPSO)','C(WS-VLPSO,SC-MOPSO)'}
xlswrite(fullFileName,tt,'Range','A1')
xlswrite(fullFileName,T,'Range','A2')
%%
f11 = figure;


subplot(5,5,1)
boxplot(zeros(size(C_WS_MOmut)));
ylabel('SC-MOPSO');
set(gca,'xTicklabels',[])
% set(gca,'yTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,2)
boxplot(meanC_VL_MOmut);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,3)
boxplot(meanC_VL_MO);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,4)
boxplot(meanC_VL_N2);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,5)
boxplot(meanC_VL_WS);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,6)
boxplot(meanMOmut_VL);
ylabel('m-MOPSO');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,8)
boxplot(C_MOmut_MO);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,9)
boxplot(C_MOmut_N2);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,10)
boxplot(C_MOmut_WS);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,11)
boxplot(meanC_MO_VL);
ylabel('MOPSO');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,12)
boxplot(C_MO_MOmut);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,14)
boxplot(C_MO_N2);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,15)
boxplot(C_MO_WS);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,16)
boxplot(meanC_N2_VL);
ylabel('NSGA-II');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,17)
boxplot(C_N2_MOmut);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,18)
boxplot(C_N2_MO);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,20)
boxplot(C_N2_WS);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,21)
boxplot(meanC_WS_VL);
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

ylabel('WS-VLPSO');
xlabel('SC-MOPSO');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,22)
boxplot(C_WS_MOmut);
xlabel('m-MOPSO');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,23)
boxplot(C_WS_MO);
xlabel('MOPSO');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,24)
boxplot(C_WS_N2);
xlabel('NSGA-II');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,25)
boxplot(zeros(size(C_WS_MOmut)));
xlabel('WS-VLPSO');
set(gca,'xTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])


subplot(5,5,7)
boxplot(zeros(size(C_WS_MOmut)));
set(gca,'xTicklabels',[])
% set(gca,'yTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,13)
boxplot(zeros(size(C_WS_MOmut)));
set(gca,'xTicklabels',[])
% set(gca,'yTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])

subplot(5,5,19)
boxplot(zeros(size(C_WS_MOmut)));
set(gca,'xTicklabels',[])
% set(gca,'yTicklabels',[])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 
ylim([0 1])


h = findobj('tag','Box');
    n=length(h);
    for k=1:n
    set(h(k),'linewidth',2);
    end


% subplot(5,5,25)
suptitle('SetCoverage Confusion Matrix for Fonseca & ZDT functions');
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w');

f1=figure;
h=boxplot([meanC_VL_MOmut' meanMOmut_VL'  meanC_VL_MO'  meanC_MO_VL'   meanC_VL_N2' meanC_N2_VL' meanC_VL_WS' meanC_WS_VL'],'Labels',{'C(SC-MOPSO,m-MOPSO)'...
    ,'C(m-MOPSO,SC-MOPSO)','C(SC-MOPSO,MOPSO)','C(MOPSO,SC-MOPSO)',...
    'C(SC-MOPSO,NSGA-II)','C(NSGA-II,SC-MOPSO)','C(SC-MOPSO,WS-VLPSO)','C(WS-VLPSO,SC-MOPSO)'});
set(gca,'XTickLabelRotation', 45);
title('Comparison between SC-MOPSO and other algorithms in terms of SetCoverage for Fonseca & ZDT functions')
set(gcf,'color','w');
set(gca,'FontSize',6);
set(h,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 

f2=figure;
title('SetCov T-Test for Fonseca & ZDT functions');
set(gcf,'color','w');
set(gca,'FontSize',16);
set(gca,'LineWidth', 2);
set(gcf,'units','normalized','outerposition',[0 0 1 1])
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2) 

bdata=[pvm;pvwm;pvn;pvws];
coloredBar(bdata);
set(gcf,'color','w');
set(gca,'xticklabel',{[]})
legend({'ttest(SC-MOPSO,m-MOPSO)','ttest(SC-MOPSO,MOPSO)','ttest(SC-MOPSO,NSGA-II)','ttest(SC-MOPSO,WS-VLPSO)'},'location','northoutside')
p=pwd;p(p=='\')='/';
folder='mathAll-Functions';
saveas(f1, [p '/results images/' folder '/setCovAll2.png'])
saveas(f2, [p '/results images/' folder '/setCovAllTtest2.png'])
saveas(f11, [p '/results images/' folder '/setCovAllConfMat2.png'])

%% 
clc;
close all;
disp('save is done');