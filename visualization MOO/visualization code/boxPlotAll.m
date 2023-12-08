
if ~exist(fd,'dir')
    mkdir(fd);
end
%% set coverage box plot
setCovBoxPlot;
%% Non Dominated Sorting boxplot
NDSboxplot;
%% Hyper volume box plot
HvBoxplot;
%% 
clc;
disp('all done');
%% the end

