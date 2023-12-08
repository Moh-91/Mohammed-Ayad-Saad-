function [] = visualizeBoxConvergence(data,name,k,Xlabl,Ylabl)


ax=boxplot(data,name);
set(gca,'FontWeight','bold','FontSize',12,'LineWidth',2); 

set(gcf,'color','w');
set(gca,'XTickLabelRotation', 45);
xlabel(Xlabl);
if k == 1
  ylabel(Ylabl,'FontSize',15);
end

set(gcf,'units','normalized','outerposition',[0 0 1 1]);



end

