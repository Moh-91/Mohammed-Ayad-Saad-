for Scenario=1:nScenario 
    clc;
    disp(['Scenario: ' num2str(Scenario)]);
    AddRequiredPaths;

    %% saving all figures as svg
    p=pwd;
    p(p=='\')='/';

    if ~exist(fd,'dir')
        mkdir(fd);
    end
    optValue=[];

    for iter =1 : numberofIter
            optValue= [optValue;pareto10iterSC{iter};pareto10iterWL{iter};pareto10iterG2{iter};pareto10iterG3{iter}];
    end
    maxdata=max(optValue);

    for u=1:size(Optimizenames,1) 
        GRB=[];
        for obj =1 : nobjs 
            str = [Objectivenames{obj} '=[];'];
            eval(str);
        end
        for i = 1 : nobjs
            figure;
            title(['convergence Scenario' num2str(Scenario)],'FontName','Times','LineWidth',2,'FontWeight','bold','FontSize',15);
            k=1;
            for j = 1 : nOpt
                   Opt=eval(pareto10IterNames{u,j});
                   subplot(1,nOpt,k);
                   k=k+1;
                   for y = 1 :numberofIter
                        str=[Objectivenames{i} '=' '[' Objectivenames{i} ' abs(Opt{y,1}(:,i))'']'] ;
                        eval(str) ;
                        GRB=[GRB,ones(1,length(Opt{y,1}))*y*10];
                   end
                   data=eval([Objectivenames{i}]);
                   visualizeBoxConvergence(data,GRB,k-1,Optimizenames{u,j},Objectivenames{i});
                   pos1 = get(gca, 'Position');
                   new_pos1 = pos1 +[0 0.2 0 -0.3];
                   set(gca, 'Position',new_pos1 );
                   maxNumber=maxdata(i);
                   set(gca,'ylim',[0 abs(maxNumber)]);

            end 
             saveas(gca,[fd '/convergence_' Objectivenames{i} '_scenario-' num2str(Scenario) '_' 'BoxPlot.svg']);
        GRB=[];
      end

    end
    




end