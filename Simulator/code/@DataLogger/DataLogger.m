classdef DataLogger
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        PDR
        E2EDelay
        EnergyConsumption
        TrustLevel
    end
    
    methods
        function obj = DataLogger()
            obj.PDR=[];
            obj.E2EDelay=[];
            obj.EnergyConsumption=[];
            obj.TrustLevel=[];
        end
        
        function obj = logData(obj)
            global  numberOfRecivedPackets numberOfDroppedPackets1 numberOfDroppedPackets2...
                E2EDelay recivedPacketsTrust totalConsE timeUnit
            obj.PDR=[obj.PDR numberOfRecivedPackets/(numberOfRecivedPackets+numberOfDroppedPackets1+numberOfDroppedPackets2)];
            obj.E2EDelay=[obj.E2EDelay timeUnit*nanmean(E2EDelay)];
            obj.EnergyConsumption=[ obj.EnergyConsumption totalConsE];
            obj.TrustLevel=[obj.TrustLevel mean(recivedPacketsTrust)];
            
        end
        function[]=logPlots(obj)
            figure(2)
            clf
            subplot 221
            plot( obj.PDR)
            title('PDR')
            xlabel('Time steps')
            subplot 222
            plot(obj.E2EDelay)
            title('E2EDelay')
            xlabel('Time steps')
            ylabel('[Sec]')
            subplot 223
            plot(obj.EnergyConsumption)
            title('Energy Consumption')
            xlabel('Time steps')
            ylabel('[joul]')
            subplot 224
            plot(obj.TrustLevel)
            title('Trust Level')
            xlabel('Time steps')
            pause(0)
        end
    end
end

