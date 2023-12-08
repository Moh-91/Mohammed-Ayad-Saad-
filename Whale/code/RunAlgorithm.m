function [pop,t,maxEnhancementTimeOut,paretoFront,NC, classes, pareto10iter,pareto_timeseries_everyIter]=...
    RunAlgorithm(alpha,nGrid,RepSize,scenario,popSize,nobj,...
    lowerBound_pos,heigherBound_pos,lowerBound_dim,higherBound_dim,...
    numberOfIter,w,p_mutation,mutatedRatio,scale,shrink,minNumParticle)
tic
w0 = w;
p_mutation0 = p_mutation;

%% initialization
[pop,NC,classes]= initialization(popSize,nobj,lowerBound_pos,heigherBound_pos,lowerBound_dim,higherBound_dim);
%% evaluation

for i=1:popSize
    pop(i).cost= objectiveFunctions(pop(i).pos);
end

%% determine non dominated solutions
pop=DetermineDomination(pop);
Rep=[];
%% starting main sc-mopso algorithm
% create repository
for i=1:popSize
    if ~pop(i).IsDominated 
       Rep= [Rep pop(i)];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%
s=0;
% initialize AMC Matrices
for j=1:NC
    str= ['AMC' num2str(classes(j))];
    eval([str '=[]']);
end

for j=1:NC
    str=['AMC' num2str(classes(j))];
    tmp=eval(str);
    for i=1:numel(pop)
        len=length(pop(i).pos.ms);
        for u=1 : length(pop(i).pos.ms)
            len =strcat(num2str(len),num2str(length(pop(i).pos.ms(u).NRP)));
        end       
        if str2num(len) ==(classes(j))
            tmp=[tmp pop(i)];
        end
    end
    eval([str '=tmp']);
end
s=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize RAM matrix

for j=1:NC
    str1=['AMC' num2str(classes(j))];
    tmp1= eval(str1);
    costs=[];
    for i=1:numel(tmp1)
        costs=[costs; tmp1(i).cost];
    end
    str2=['ind' num2str(classes(j))];
    str3=['min' num2str(classes(j))];
    s=['[' str3 ',' str2 ']' '=min(transpose(costs),[],2)'];
    eval(s);
end

RAM=zeros(nobj,NC);
IRAM=zeros(nobj,NC);
for i=1:NC
    RAM(:,i)=eval(['min' num2str(classes(i))]);
    IRAM(:,i)=eval(['ind' num2str(classes(i))]);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% setting some temporary parameters

maxEnhancementTimeOut=19;%round(numberOfIter/10);
hhhh = waitbar(1,'hello');
caa=0;
%% start iterations
paretoiter=[];
pareto10iter=[];
timeseries=0;
pareto_timeseries=[];
pareto_timeseries_everyIter=[];
u=1;
for iter=1:numberOfIter
    deletedClasses=[];
    clc
    prog=['Senario: ' num2str(scenario) ' from 10 scenarios | '  'iter:' num2str(iter) ' progress: ' num2str(ceil(100-(numberOfIter-iter)/numberOfIter*100)) '%'];
    
    waitbar(1-((numberOfIter-iter)/numberOfIter),hhhh,prog)
    disp(['iter=' num2str(iter)])
    halfItersNum = numberOfIter/2;
    x = iter + 1 - halfItersNum;
    sc = scale;
    a=2-iter*((2)/numberOfIter); % a decreases linearly fron 2 to 0 in Eq. (2.3) 
    % a2 linearly dicreases from -1 to -2 to calculate t in Eq. (3.12)
    a2=-1+iter*((-1)/numberOfIter);
    p_mutation = p_mutation0*(-a*x^2 + 1);
    
    %*************************************************************
    %% update AMC matrices
    for c=1:NC

        
        str = ['AMC' num2str(classes(c))];
        tmpAMC=eval(str);
        costs=[];
        for i=1:numel(tmpAMC)
            costs=[costs; tmpAMC(i).cost];
        end
        costs=costs';
        if(isempty(costs)) % if AMS is empty then continue
            continue;
        end
        %%
        f=round(unifrnd(1,nobj)); % determine random objective
        %% create pdf for each AMC
        if all(costs(f,:)==0)     % if all objectives values =0 then the selection
            % probability is the same for all
            pdfpf=ones(size(costs(f,:)))/length(costs(f,:));
        else
            pdfpf=exp(costs(f,:)./(sum(costs(f,:)))); % calculate pdf
        end 
        pdfpf(pdfpf<0)=1+ pdfpf(pdfpf<0);
        pdfpf= pdfpf/sum(pdfpf);
        h=RouletteWheelSelectionMin((pdfpf)); % select random exampler
        %   h=fortune_wheel(1./pdfpf);
        disp(['h=' num2str(h)]);
        if isempty(h) || h==-1
            h=randi(length(pdfpf));
        end

        
        %% Movement
        for i=1:length(tmpAMC)
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
        
            A=2*a*r1-a;  % Eq. (2.3) in the paper
            C=2*r2;      % Eq. (2.4) in the paper
        
        
            b=1;               %  parameters in Eq. (2.5)
            l=(a2-1)*rand+1;   %  parameters in Eq. (2.5)
        
            p = 0.4;        % p in Eq. (2.6)
            [xLeader yLeader hopLeader]=DS2XYHop(tmpAMC(h).pos)
            [x y hop]=DS2XYHop(tmpAMC(i).pos)  
      
            if p<0.5   
                if abs(A)>=1
                   rand_leader_index = floor(size(tmpAMC,2)*rand()+1);
                   X_rand = tmpAMC(rand_leader_index);
                   
                   [xRand yRand hopRand]=DS2XYHop(X_rand.pos) 
                   [xbest ybest hopbest]=DS2XYHop(X_rand.pbest)
                  
                     D_X_rand(:,1)=abs(C.*xRand-x);
                     D_X_rand(:,2)=abs(C.*yRand-y);
                     D_X_rand(:,3)=abs(C.*hopRand-hop);
                     
                     tmpo(:,1)=xRand-A.*D_X_rand(:,1);
                     tmpo(:,2)=yRand-A.*D_X_rand(:,2);
                     tmpo(:,3)=round(hopRand-A.*D_X_rand(:,3));
                     
              elseif abs(A)<1
                     D_Leader(:,1)=abs(C.*xLeader-x); % Eq. (2.1)
                     D_Leader(:,2)=abs(C.*yLeader-y); % Eq. (2.1)
                     D_Leader(:,3)=abs(C.*hopLeader-hop); % Eq. (2.1)
                     tmpo(:,1)=xLeader-A.*D_Leader(:,1);      % Eq. (2.2)
                     tmpo(:,2)=yLeader-A*D_Leader(:,2); 
                     tmpo(:,3)=round(hopLeader-A*D_Leader(:,3)); 
                end
             elseif p>=0.5
              
                distance2Leader(:,1)=abs(xLeader-x);
                distance2Leader(:,2)=abs(yLeader-y);
                distance2Leader(:,3)=abs(hopLeader-hop);
                % Eq. (2.5)
                tmpo(:,1)=distance2Leader(:,1)*exp(b.*l).*cos(l.*2*pi)+xLeader;
                tmpo(:,2)=distance2Leader(:,2)*exp(b.*l).*cos(l.*2*pi)+yLeader;
                tmpo(:,3)=round(distance2Leader(:,3)*exp(b.*l).*cos(l.*2*pi)+hopLeader);
                
             end

            D_X_rand=[];
            D_Leader=[];
            distance2Leader=[];
            lowerBound   = [lowerBound_pos lowerBound_dim(3)];
            heigherBound = [heigherBound_pos higherBound_dim(3)];
            for j = 1 : length(heigherBound)
                tmpo(tmpo(:,j)<lowerBound(j),j)   = lowerBound(j);
                tmpo(tmpo(:,j)>heigherBound(j),j) = heigherBound(j);
            end
            
            if rand<p_mutation
                tmpo = mutationPso(tmpo,mutatedRatio,lowerBound,heigherBound,sc);
                for j = 1 : length(heigherBound)
                      tmpo(tmpo(:,j)<lowerBound(j),j)   = lowerBound(j);
                      tmpo(tmpo(:,j)>heigherBound(j),j) = heigherBound(j);
                end
            end
            
            tmpo = XYHop2DS(tmpo(:,1) ,tmpo(:,2) ,tmpo(:,3) , tmpAMC(i).class)
            
            tmp_cost= objectiveFunctions(tmpo);
            
            if(Dominates(tmp_cost,tmpAMC(i).cost))
                tmpAMC(i).pos=tmpo; % update particle position
                
          
            else
                % count number of non enhancement times for the particle
                tmpAMC(i).cont= tmpAMC(i).cont+1;
          
            end
            %% rest nonEnhancementCounter
            if rem(iter,maxEnhancementTimeOut+1)==0
                tmpAMC(i).cont=0;
            end

            tmpAMC(i).cost=objectiveFunctions(tmpAMC(i).pos);
            if Dominates( tmpAMC(i).cost, objectiveFunctions(tmpAMC(i).pbest))
                tmpAMC(i).pbest= tmpAMC(i).pos; %update particle pbest
            end
            tmpo = []
            vel=[]
        end
        eval([str '=tmpAMC' ]); %update AMC matrix for the current class
       
    end
    %% update particles lengths
  
    for j=1:NC
        if NC==1
            index=[];
            break;
            
        end
        index=[];
        str1=['AMC' num2str(classes(j))];
        tmp1= eval(str1);
        Cont=[];
        
        Cont=[Cont tmp1.cont];
        
        med=median(Cont);
        %        maxEnhancementTimeOut=19;
        enhancement_timeout=maxEnhancementTimeOut*((maxEnhancementTimeOut-...
           med)/maxEnhancementTimeOut);
        for i=1:length(tmp1)
            if tmp1(i).cont>enhancement_timeout && length(tmp1)>=minNumParticle % if the particle isn't improved within...
                %10 iterations
                tmp1(i).cont=0;
                newClassTemp=tmp1(i);
                cf=round(unifrnd(1,nobj)); % random objective
                if all(RAM(cf,:)==0) % if all RAM objectives ==0 then select...
                      % with the same probability
                    pdfcf=ones(size( RAM(cf,:)))/length(RAM(cf,:));
                else
                    pdfcf=RAM(cf,:);
                    pdfcf=exp(RAM(cf,:)./sum(RAM(cf,:)));% pdf
                    pdfcf(pdfcf<0)=1+pdfcf(pdfcf<0);
                    pdfcf= pdfcf/sum(pdfcf);
                end
                %                newClass=normpdf(pdfcf);
                newClass=RouletteWheelSelectionMin(pdfcf);
                str=['AMC' num2str(classes(newClass))];
                % newClass=fortune_wheel(1./pdfcf);
                while isempty(eval(str))
                     cf=round(unifrnd(1,nobj))
                     if all(RAM(cf,:)==0) % if all RAM objectives ==0 then select...
                      % with the same probability
                        pdfcf=ones(size( RAM(cf,:)))/length(RAM(cf,:));
                    else
                    pdfcf=RAM(cf,:);
                    pdfcf=exp(RAM(cf,:)./sum(RAM(cf,:)));% pdf
                    pdfcf(pdfcf<0)=1+pdfcf(pdfcf<0);
                    pdfcf= pdfcf/sum(pdfcf);
                     end
                    newClass=RouletteWheelSelectionMin(pdfcf);
                    str=['AMC' num2str(classes(newClass))];
                end
                if isempty(newClass)
                    continue;
                end
                if(newClass==j)
                    continue;
                end
                index=[index i];% put moved particle index in the "index" array
                
                index_exampler= IRAM(cf,newClass);
                
                str=['AMC' num2str(classes(newClass))];
                tmpNewACM=eval(str);
                exampler=tmpNewACM(index_exampler);
                % zero padding when move to higher class
             %   if classes(newClass)>classes(j)
                str_newclass=num2str(classes(newClass));
                str_oldclass=num2str(classes(j));
                difference = str_newclass(1) - str_oldclass(1);
                if difference > 0
                    newClassTemp=movetoUpperClass(str_newclass,exampler,newClassTemp,difference);
                elseif difference<0
                 
                     newClassTemp=movetoLowerClass(str_newclass,exampler,newClassTemp,difference);
                elseif difference ==0
                    newClassTemp= Add_delete_RVs(newClassTemp,exampler , str_newclass);
                end
                newClassTemp.cost=objectiveFunctions(newClassTemp.pos);
                newClassTemp.class=str_newclass;
                % update the AMC for the new class
                tmpNewACM=[tmpNewACM newClassTemp];
                
                eval([str '=tmpNewACM']);
                
            end
            
        end
        
        tmp1(index)=[];
        eval([str1 '=tmp1']);% delete moved particles from AMC
       
        costs=[];
        for i=1:numel(tmp1)
            costs=[costs; tmp1(i).cost];
        end
        str2=['ind' num2str(classes(j))];
        str3=['min' num2str(classes(j))];
        s=['[' str3 ',' str2 ']' '=min(transpose(costs),[],2)'];
        eval(s);
        if(~isempty(tmp1))
           RAM(:,j)=eval(['min' num2str(classes(j))]);
           IRAM(:,j)=eval(['ind' num2str(classes(j))]);
        end
        
    end
    ic=[]  ;
    %% delete moved particles from the class
    for j=1:NC
        str1=['AMC' num2str(classes(j))];
        tmp1= eval(str1);
        if isempty(tmp1)
            ic=[ic j];
            eval(['clear ' str1 ' ']); % delete empty AMCs
        end
    end
    %%
    classes(ic)=[]; % delete empty classes
    %update classes and number of classes
    classes= unique(classes);
    NC= length(unique(classes));
    % update RAM matrix
    for j=1:NC
        str1=['AMC' num2str(classes(j))];
        tmp1= eval(str1);
        costs=[];
        for i=1:numel(tmp1)
            costs=[costs; tmp1(i).cost];
        end
        str2=['ind' num2str(classes(j))];
        str3=['min' num2str(classes(j))];
        s=['[' str3  ']' '=min(transpose(costs),[],2)'];
        eval(s);
    end
    RAM=zeros(nobj,NC);
    IRAM=zeros(nobj,NC);
    for i=1:NC
        RAM(:,i)=eval(['min' num2str(classes(i))]);
        IRAM(:,i)=eval(['ind' num2str(classes(i))]);
    end
    %%%%%%%%%%%%%%%%%%%
    popC=0;
    for i=1:NC
        str1=['AMC' num2str(classes(i))];
        v=eval(str1);  % all particles objectives
        for j=1:length(v)
            popC=popC+1;
            pop(popC)=v(j);
        end
    end
    %  w = w*0.99;
    % p_mutation = p_mutation*0.99;
        %% determine nonDominated sols
    pop=DetermineDomination(pop);
    pareto= pop(~[pop.IsDominated]);
    pareto = [pareto.cost];
    pareto = reshape(pareto,5,length(pareto)/5);
    pareto = pareto';
        %% update the repository
    for i=1:popSize
        if ~pop(i).IsDominated
            Rep= [Rep pop(i)];
        end
    end
    Rep=DetermineDomination(Rep);
    ind=false(1,numel(Rep));
    for i=1:numel(Rep)
        if Rep(i).IsDominated
            ind(i)=true;
        end
    end
    Rep(ind)=[];
    Grid=CreateGrid(Rep,nGrid,alpha);
    
    for i=1:numel(Rep)
        Rep(i)=FindGridIndex(Rep(i),Grid);
    end

    gi=Rep.GridIndex;
    uniq=(unique(gi));
    while numel(Rep)>RepSize
        Rep=deleteFromRep(uniq,Rep);
    end
    for i = 1 : size(Rep,2)
        pareto_timeseries=[pareto_timeseries ;  Rep(i).cost];
        paretoiter=[paretoiter ; Rep(i).cost];
    end
    pareto_timeseries_everyIter{iter,1}= paretoiter;
    paretoiter=[];
    if iter == timeseries+10
        pareto10iter{u,1} = pareto_timeseries;
        u=u+1;
        timeseries = timeseries+10;
        pareto_timeseries=[];
    end
    
end % end iterations
%% find pareto front and particles objectives values
classes= unique(classes);
NC= length(unique(classes));
paretoFront=[];
cSet=0;
%**************************************************************

Rep=DetermineDomination(Rep);
ind=false(1,numel(Rep));
for i=1:numel(Rep)
    if Rep(i).IsDominated
        ind(i)=true;
    end
end
Rep(ind)=[];
for i=1:numel(Rep)
    paretoFront.solutionsObjectiveValues(i,:)=Rep(i).cost;
    paretoFront.solutions(i,:).pos=Rep(i).pos
    paretoFront.solutions(i,:).class=Rep(i).class;
end
close(hhhh) ;
t=toc;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



