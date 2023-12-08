function result_final = objectiveFunctions(individual_solution)

[AddjMatrix ,path, rvpPOSmat,rvpHOPmat,Non_conneted_sensors] = FinalAddjMatrix(individual_solution);
if ~isempty(AddjMatrix) 
    trust_result        = Trust(rvpHOPmat , AddjMatrix , path );
    energy_result       = Energy(rvpHOPmat , AddjMatrix , path );
    [time_result ,cost] = Time(individual_solution , AddjMatrix);
    coverage            = Non_conneted_sensors;
else
    trust_result        = -realmax;
    energy_result       = realmax;
    time_result         = realmax;
    cost                = realmax;
    coverage            = 100
end

result_final(1) = -trust_result ; 
result_final(2) = energy_result ;
result_final(3) = cost ;
result_final(4) = time_result ;
result_final(5) = coverage;


end

