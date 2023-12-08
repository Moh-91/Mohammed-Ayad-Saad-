classdef Enviroment
    %ENV Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        NMS         % number of Mobile sinks
        NSensors    % number of sensors
        EnvDim      % diminsion of the environment
        Sensors
        MSinks
        rvpPOSmat
    end
    
    methods
        function obj = Enviroment(EnvDim,NSensors,sensors)
            %ENV Construct an instance of this class
            %   Detailed explanation goes here
                        obj.EnvDim=EnvDim;
            if isempty(sensors)
            obj.NSensors=NSensors;
            
            for i=1:NSensors
                Pos= [EnvDim(1)+ rand*(EnvDim(2)-EnvDim(1)) EnvDim(3)+ rand*(EnvDim(4)-EnvDim(3))]; % generate position
                
                obj.Sensors=[obj.Sensors Sensor(i,Pos,randi(10))];
            end
            else
            obj.NSensors=length(sensors);
                for i=1:obj.NSensors
                
                obj.Sensors=[obj.Sensors Sensor(i,sensors(i,1:2),sensors(i,3))];
            end
            end
            
            
        end
        function obj=implementSolution(obj,RVP,vel,collectingDuration)
            global coveragR
            obj.NMS=size(RVP,1);
            rvps=1;
            for i=1:obj.NMS
                %Pos= [EnvDim(1)+ rand*(EnvDim(2)-EnvDim(1)) EnvDim(3)+ rand*(EnvDim(4)-EnvDim(3))]; % generate position
                obj.MSinks=[obj.MSinks MobileSink(i,10,RVP{i,1},RVP{i,2},vel,collectingDuration)];
                RVP2MSinks([rvps:rvps+numel(RVP{i,2})-1])=i;
                rvps=rvps+numel(RVP{i,2});
            end
            %% analysing the solution
            sensors= reshape([obj.Sensors.Position],2,[])';
            NSensors=length(sensors);
            
            obj.rvpPOSmat= cell2mat(RVP(:,1));
            
            rvpHOPmat= cell2mat(RVP(:,2));
            %%%%% distance between every sensors and Randivue and get the minimum distance of them  %%%%%%%
            
            addjmatDistance = pdist2(obj.rvpPOSmat,sensors);
            [minDistance , index] = min(addjmatDistance);
            ids=find(minDistance < coveragR);
            FirstHop=[ids' index(ids)' rvpHOPmat(index(ids),1) ones(length(ids),1)];
            path{length(FirstHop()),1}=[];
            [AddjMatrix , path] = AddjMatrixFun(FirstHop,sensors,path, 1);
            
            %% assign sensors
            for i=1:NSensors
                indx=find(AddjMatrix(:,1)==i);
                if~isempty(indx)
                    RVP=AddjMatrix(indx,2);
                    MSink=RVP2MSinks(RVP);
                    nextHop=path{indx};
                    if~isempty(nextHop)
                        nextHop=nextHop(end);
                    else
                        nextHop=0;
                    end
                    obj.Sensors(i)=obj.Sensors(i).assignRVP(MSink,RVP,nextHop);
                end
            end
        end
        function [] = plotEnv(obj)
            global timeCounter
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            figure(1)
            clf
          hold on
            SPoses=reshape([obj.Sensors.Position],2,[])';
%             indx=find([obj.Sensors.covered]==1); % ploting covered sensors
%             plot(SPoses(indx,1),SPoses(indx,2),'*b')
%             indx=find([obj.Sensors.covered]==0); % ploting uncovered sensors
%             plot(SPoses(indx,1),SPoses(indx,2),'*r')
            MPoses=reshape([obj.MSinks.Position],2,[])';

            plot(MPoses(:,1),MPoses(:,2),'dk')
           
            plot(obj.rvpPOSmat(:,1),obj.rvpPOSmat(:,2),'or')
            cmap = parula(11);
            cmap = cmap(10:-1:1, :);    % dark blue to green (360 colors)
            scatter(SPoses(:,1),SPoses(:,2),[],[obj.Sensors.Trust]', 'filled'); %intincity based trust
            colormap(cmap)
           c = colorbar;
           c.Label.String = 'Trust (1-10)';
            for i=1:obj.NMS
                plot(obj.MSinks(i).Track(:,1),obj.MSinks(i).Track(:,2),'k')
            end
            
 
            title(['Envronment :' num2str(timeCounter/100) ' Sec'])
           % legend({'covered Sensors','uncovered Sensors','Mobile Sinks','RV points','Mobile Sinks Track'},'Location','northeastoutside')
            legend({'Mobile Sinks','RV points','Sensors','Mobile Sinks Track'},'Location','northeastoutside')

        end
        [obj,logger]=runSystem(obj)
        
    end
end

