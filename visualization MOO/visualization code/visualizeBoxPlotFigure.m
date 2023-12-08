function[]=visualizeBoxPlotFigure(data,name,TitleFigure,Titlesave)

figure
ax=boxplot(data,name);
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2); 
title(TitleFigure,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15)
set(gcf,'color','w');


set(gcf,'units','normalized','outerposition',[0 0 1 1]);
pos1 = get(gca, 'Position');
new_pos1 = pos1 +[0.1 0.2 -0.2 -0.3];
set(gca, 'Position',new_pos1 );
saveas(gca,[Titlesave '.svg']);

end