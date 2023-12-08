function [] = visualizeBarPlotFigure(data,names,TitleFigure,TitleSaving)
figure;
bar(data);set(gca,'xticklabel',names);
set(gcf,'color','w');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gca,'FontWeight','bold','FontSize',10,'LineWidth',2) 
title(TitleFigure,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15);
saveas(gca,[TitleSaving '-BarPlot.svg'])
end

