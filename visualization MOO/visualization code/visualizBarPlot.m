function [] = visualizBarPlot(data,names,T)

bar(data);set(gca,'xticklabel',names);
set(gcf,'color','w');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gca,'FontWeight','bold','FontSize',10,'LineWidth',2) 
title(T,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',17);
end

