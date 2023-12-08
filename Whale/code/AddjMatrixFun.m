function [nextHop ,path]= AddjMatrixFun(nextHop ,sensors,path, Nhops)
    global coverage_radious
    nm_hop    = Nhops+1;
    %take the connected sensors 
    cols      = nextHop(:,1);
    %take the rest of sensors that isn't connected 
    rows      = setdiff([1:length(sensors)],cols');
    %take the sensors that connected to RV point ,which the number of hops
    %of this RV greater than the current hop
    connected = nextHop(:,3) >= nm_hop;
    cols      = nextHop(connected,1);
  
    if isempty(rows) || nm_hop > max(nextHop(:,3))
        return
    end
    
    Distance  = pdist2(sensors(rows,1:2),sensors(cols,1:2));
    sizeDis   = size(Distance);
    [minVal,index] = min(Distance,[],2);
    % apply loop for each minVal(minimum distance between connected sensors
    % and non-connected sensors )and check this distance if its < coverage
    % radious then put this sensor in the nextHop matrix and what the
    % sensor does it connected to and which hop does it connected and trust of this sensor 
    %and put to it's path the sensor that to connect to it 
    for i=1 : sizeDis(1)
        if minVal(i) < coverage_radious
               nextHop = [nextHop; rows(i) nextHop(find(nextHop(:,1)==cols(index(i))),2) nextHop(find(nextHop(:,1)==cols(index(i))),3) nm_hop sensors(rows(i),3)];
               path = [path ; path{find(nextHop(:,1)==cols(index(i))),1} cols(index(i))];
        end

    end
    [nextHop , path] = AddjMatrixFun(nextHop,sensors,path, nm_hop);
end