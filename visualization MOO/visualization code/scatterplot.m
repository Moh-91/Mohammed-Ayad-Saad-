%% 2D scatter , scatter plotting of each objective function with rest objective in one figure 
f6 = figure(6)
title('2D scatter plot','FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15);
iter=0;
Objective=[1 , 2 , 3 , 4 , 5];
nameObjective =["Trust","Energy","Cost","Time","Non-coverage"]
for i = 1 : 5
    for j = 1 : 5 
        pareto1=paretoFrontG2(:,Objective(i));
        pareto2=paretoFrontG2(:,Objective(j));
        subplot(5,5,iter+1);
        if i == 1 
            pareto1=abs(paretoFrontG2(:,Objective(i)));
        end
        if j == 1
              pareto2=abs(paretoFrontG2(:,Objective(j)))
        end
        scatter(pareto1,pareto2,"MarkerEdgeColor","b","MarkerFaceColor",[0 0.7 0.7])
        set(gcf,'color','w');
        set(gcf,'units','normalized','outerposition',[0 0 1 1])
        set(gca,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',10) 
%         if (i == 5)
%             xlabel(nameObjective(j));
%         end
%         if (j==1)
%             ylabel(nameObjective(i));
%         end
        xlabel(nameObjective(i));
        ylabel(nameObjective(j));
        iter =iter +1
        
        
    end 
end
saveas(f6,[fd '/scatter-allObj-scenario' num2str(Scenario) '.svg'])

%% 2D scatter , scatter plotting for each objective function with the rest in 5 figure 

nameObjective1 ={'Trust','Energy','Cost','Time','Non-coverage'};
for i = 1 : 5
    f= figure(i);
    title([nameObjective1{i}],'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',8)
    iter=0;
    for j = 1 : 5 
        if i ~= j 
            subplot(1,4,iter+1);
            pareto1=paretoFrontG2(:,Objective(i));
            pareto2=paretoFrontG2(:,Objective(j));
            if i == 1 
                pareto1=abs(paretoFrontG2(:,Objective(i)));
            end
            if j == 1
                pareto2=abs(paretoFrontG2(:,Objective(j)))
            end
            scatter(pareto1,pareto2,"MarkerEdgeColor","b","MarkerFaceColor",[0 0.7 0.7])
            set(gcf,'color','w');
            set(gcf,'units','normalized','outerposition',[0 0 1 1]);
            set(gca,'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15); 
            xlabel(nameObjective(i));
            ylabel(nameObjective(j));
            iter =iter +1
        end
        
        
    end
    
    saveas(f,[fd '/scatter-' nameObjective1{i} '_withOtherObj-scenario' num2str(Scenario) '.svg']);
   
end

