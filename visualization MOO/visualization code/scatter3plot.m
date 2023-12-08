%% 3D scatter plot , scatter 3d plotting for first 3 objective function ( Trust , Energy , Cost)
f7=figure(7);
scatter3(abs(paretoFrontG2(:,1)),paretoFrontG2(:,2),paretoFrontG2(:,3),"MarkerEdgeColor","b","MarkerFaceColor",[0 0.7 0.7]);
set(gcf,'color','w');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gca,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15);
xlabel('Trust');
ylabel('Energy');
zlabel('Cost');
title('\fontsize{15} \bf Trust , Energy , Cost');
%% 3D scatter plot , scatter 3d plotting for last 3 objective function ( Cost , Time , Non-coverage)
f8=figure(8);
scatter3(paretoFrontG2(:,3),paretoFrontG2(:,4),paretoFrontG2(:,5),"MarkerEdgeColor","b","MarkerFaceColor",[0 0.7 0.7]);
set(gcf,'color','w');
set(gcf,'units','normalized','outerposition',[0 0 1 1]);
set(gca,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15);
xlabel('Cost');
ylabel('Time');
zlabel('Non-coverage');
title('\fontsize{15} \bf Cost , Time , Non-coverage')


saveas(f7,[fd '/scatter-Fisrt3Obj-scenario' num2str(Scenario) '.svg'])
saveas(f8,[fd '/scatter-last3Obj-scenario' num2str(Scenario) '.svg'])
