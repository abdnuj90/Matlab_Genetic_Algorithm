%% Binery Genetic Algorithem 
clearvars; clc;
%% generate initial population
npop = 20;
nbits = 8;
old_pop = round(rand(npop,nbits));%initial population of 20 with 8 bits to 
                                  %reprsent two parameters, each with 4 bit
new_pop = zeros(npop,nbits);      %define the new population 
Pm = 0.05;                        %mutation rate 
Pc = 0.8;                         %crossover probability
gen = 100;                        %number of generation required 

%% Main loop of GA
for iter = 1:1:gen
    new_pop = zeros(npop,nbits);  %define the new population
    % Tournement Selection
    for i = 1:1:npop
        k = ceil(npop*rand(1,1)); %choose the first chromoshom location
        j = ceil(npop*rand(1,1)); %chosse the second chromoshom location
        a = ff(old_pop(k,:));
        b = ff(old_pop(j,:));
            if a <= b;            %choose the fittest chromoshom
                new_pop(i,:) = old_pop(k,:); 
            else 
                new_pop(i,:) = old_pop(j,:);
            end
    end
    
    %Simple Point Crossover 
    temp_pop=new_pop;
    for i = 1:1:npop/2
        cros_prop = rand;
        if cros_prop <= Pc
            cros_point = ceil(nbits*rand);
            for j = 1:1:cros_point
                new_pop(2*i-1,j)=temp_pop(2*i,j);
                new_pop(2*i,j)=temp_pop(2*i-1,j);
            end
        end
    end
    
    %Mutatation
    x= new_pop;
    for i=1:1:npop
        for j = 1:1:nbits
            mu_prop = rand;
            if mu_prop <= Pm
                new_pop(i,j) = abs(1-new_pop(i,j)); %perform mutation
            end
        end
    end
    
    %Store best value per iteration and overall
    for i = 1:1:npop
    [new_pop(i,11),new_pop(i,9),new_pop(i,10)] = ff(new_pop(i,:));
    end 
    [k1,ind1] = min(new_pop(:,11));
    optimal_per_run(iter,:) = [new_pop(ind1,9) new_pop(ind1,10) new_pop(ind1,11)] ;
    [k2,ind2] = min(optimal_per_run(:,3));
    optimal_overall(iter,:) = [optimal_per_run(ind2,1) optimal_per_run(ind2,2) optimal_per_run(ind2,3)];
    old_pop = new_pop(:,[1:nbits]);
end

%plot final results
plot([1:iter],optimal_overall(:,3)), title('Binery Genetic Algorithem'), ...
    xlabel('Generation'), ylabel('Objective function'), ...
    legend('P_m = 0.05 P_c = 0.8'), axis([0 100 -1 1+max(optimal_overall(:,3))]), grid on;

fprintf('Minimum objective value is: '); fprintf('%g \n', optimal_overall(gen,3)), 
fprintf('Optimized parameters: x_1 = %g  x_2 = %g\n',optimal_overall(gen,1), optimal_overall(gen,2))
