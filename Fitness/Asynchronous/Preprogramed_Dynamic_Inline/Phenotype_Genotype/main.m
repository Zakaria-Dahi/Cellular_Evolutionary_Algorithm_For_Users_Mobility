% -- Asynchronous Cellular Genetic Algorithm According to Phenotype & Genotype Criterion ----
clear all
%% -------- Initialisation of POI Libs -----------------------------
% Add Java POI Libs to matlab javapath
javaaddpath('Jar/poi-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-3.8-20120326.jar');
javaaddpath('Jar/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('Jar/xmlbeans-2.3.0.jar');
javaaddpath('Jar/dom4j-1.6.1.jar');
javaaddpath('Jar/stax-api-1.0.1.jar');
%% -------------------- Starting the execution of the program -----------------------------------
for ind=1:12
%% -------------   Initialize the parameters of the experiments -------------------------------------------
%%%% -------------- The number of execution ------------------------------
global execution 
       execution = [1 1 1 1 1 1 1 1 1 1 1 1];
%% ------ Number of individuals contained in the population --------------
global  indiv
        indiv = 400;
%% Save the dimension of the individual (it corresponds to the size of the network)
global Dimension
       Network_size = size(Instance(ind));
       Dimension = Network_size(1);
%% Number of itterations 
global iter
       iter = 437;
%% Number of execution 
global Nexe
       Nexe = execution(ind);
%% Instances and neighbourhood of the network
global network 
       network = Instance(ind);
global neighbourhoud
       if ind == 1 || ind == 2 || ind == 3 || ind == 13 || ind == 16 ||  ind == 17
           neighbourhoud = neighbour(4);
       end
       if ind == 4 || ind == 5 || ind == 6 || ind == 14
           neighbourhoud = neighbour(6);
       end
       if ind == 7 || ind == 8 || ind == 9 || ind == 15
           neighbourhoud = neighbour(8);
       end
       if ind == 10 || ind == 11 || ind == 12
           neighbourhoud = neighbour(10);
       end
       if ind == 18 
          neighbourhoud =   neighbour(19);
       end
       if ind == 19
          neighbourhoud =   neighbour(63);
       end
       if ind == 20 
          neighbourhoud =   neighbour(99);
       end
%% ---- Saving the type and the dimension of the network used -------------
global instance 
      if ind == 1
          instance =  'Network_1_4x4';
      end
      if ind == 2
          instance =  'Network_2_4x4';       
      end
      if ind == 3
          instance =  'Network_3_4x4';         
      end
      if ind == 4
          instance =  'Network_1_6x6';         
      end
      if ind == 5
          instance =  'Network_2_6x6';         
      end
      if ind == 6
          instance =  'Network_3_6x6';         
      end
      if ind == 7
          instance =  'Network_1_8x8';         
      end
      if ind == 8
          instance =  'Network_2_8x8';
      end
      if ind == 9
          instance =  'Network_3_8x8';          
      end
      if ind == 10
          instance =  'Network_1_10x10';         
      end
      if ind == 11
          instance =  'Network_2_10x10';          
      end      
      if ind == 12
          instance =  'Network_3_10x10';
      end
      if ind == 13
          instance =  'Network_4_4x4';         
      end
      if ind == 14
          instance =  'Network_4_6x6';          
      end      
      if ind == 15
          instance =  'Network_4_8x8';
      end
      if ind == 16
          instance =  'Network_5_4x4';
      end
      if ind == 17
          instance =  'Network_6_4x4';
      end
      if ind == 18
          instance =  'Network_19_Cells';
      end
      if ind == 19
          instance =  'Network_7x9_Cells';
      end
      if ind == 20
          instance =  'Network_9x11_Cells';
      end
%% -------- Prameters  of the dynamic cellular Genetic Algorithm  ------
   pcr = 1;  % By default I set it to 1 as recomended by Professor Alba
   pm = (1/Dimension);  % as recomended by Professor Alba  
   % we decide to start with a rectangular grid shape since it is cosidered
   % at the midle between a square and a narrow one
   global grid_x
          grid_x = 40;
   global grid_y 
          grid_y = 10;
%% ------- Parameters of the Phenotype Strategy ------------------------
   global epsilon 
          epsilon = 0.05;
   global num
          num = indiv; 
   global ub_grid_y
          ub_grid_y = 20;
   global lb_grid_y
          lb_grid_y = 4;
%% variable to save for each execution  ----------------------
     % Fitness of the best individual reach after the end of all the ietteration 
     global ALL_EXECUTION
            ALL_EXECUTION = [];
     % Save all the execution Time per run 
     global ALL_TIME
            ALL_TIME = [];
     % save all the best fitnesses through the generations
     global ALL_FITNESSES
            ALL_FITNESSES = [];
     % save all the itterations where the fitness value where extracted
     global ALL_ITTERATIONS
            ALL_ITTERATIONS = [];
     % Mean of all the fitness reached  
     global moy
            moy =0;
     % Standard deviation of the fitness reached 
     global ecart 
            ecart = 0;
     % save all the information relative to the experiment 
     global vect_one 
            vect_one = [];
     global vect_two
            vect_two = [];
     % save to best individual all along the NEXE execution 
     global FITNESS_GBEST
            FITNESS_GBEST = 1000000000000000000000000000000000000;
     % save the best individual all along the Nexe exveution 
     global GBEST_ALL
            GBEST_ALL = [];
%% ------------- Start of the execution loop -------------------------------
for exe=1:Nexe
%% ----- Change the seed of the Mersenne Twister Random Generator ----------
rng shuffle
% ------------------------------------------------------------------------
ti = 0;
tic
%% --- To reset The number Of Fitness Evolution ----------
it = 0;
%% variable used during the calcul ---------------------------------------
     % Vector conaiting the fitness of all individuals of the population 
     global fit
            fit = [];
     % Vector containing the best individual so far 
     global gbest
            gbest = [];
     % contain the index of the best individual so far 
     global indbest_one 
     % The population 
     global population
            population = [];
     % To save the itteration and the corresponding fitness value of this itteration (fitness evauation)
     ALL_FITNESSES = [];
     ALL_ITTERATIONS = [];
     % Save the average fitnesses difference at generaion t 
     global  average_difference_actual 
             average_difference_actual = 0;
      % Save the average fitnesses difference at generaion t 
     global  average_difference_previous
             average_difference_previous = 0;
      % save the previous mean fitnesses 
      global mean_fitness_previous 
             mean_fitness_previous = 0;
      % save the previous mean fitnesses 
      global mean_fitness_actual
             mean_fitness_actual = 0;  
     % Save the average fitnesses difference at generaion t 
     global  average_entropy_difference_actual 
             average_entropy_difference_actual = 0;
      % Save the average fitnesses difference at generaion t 
     global  average_entropy_difference_previous
             average_entropy_difference_previous = 0;
      % save the previous mean fitnesses 
      global mean_entropy_previous 
             mean_entropy_previous = 0;
      % save the previous mean fitnesses 
      global mean_entropy_actual
             mean_entropy_actual = 0;         
      % compute the allowed grid shape
      facnum = factor(num);
      uf = unique(facnum);
      hf = histc(facnum,uf);
      vec = (uf(1)).^(0:hf(1));
      for i=2:length(uf)
          fac = uf(i);
          x = fac.^(0:hf(i));
          vec = kron(vec,x); 
      end
      div_y = sort(vec);
      div = repmat(num,1,length(div_y)); 
      div_x = div./div_y; 
      index = find((div_y <= ub_grid_y) & (div_y >= lb_grid_y)); 
      div_y = div_y(index);
      div_x = div_x(index);
      %% extract grid sizes x and y 
      global grid_xs
             grid_xs = div_x;
      global grid_ys
             grid_ys = div_y;
      %%  extract the actual index 
      global index_actual_shape
             index_actual_shape = find(grid_ys == grid_y);
%% ------------ Generate the intial population ---------------------
population = single(Ini_Pop(indiv,Dimension));
% ------------------------------------------------------------------
%% ------ Compute the initial fitnesses for the initial population -------
for w=1:indiv
    result  = RC_Function(population(w,:),Dimension,network,neighbourhoud);
    fit = [fit , result];
end
% ------------------------------------------------------------------------
%% -- calculate the best individual (it's index , it's fitness and ..) ---
[bestFit_one,indbest_one] = min(fit);
gbest = population(indbest_one,:);
ALL_FITNESSES = [ALL_FITNESSES min(fit)]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS indiv];
%% -------- Record genotype informations -------------------------
% --- Recording Information About The State Of the Population ----
gene = zeros(4,Dimension);
for index=1:Dimension
    %% --- Recording the Mean of the 'Index' gene of all the chromosomes ----
    gene(1,index) = mean(population(:,index));
    %% --- Recording the STD of the 'Index' gene of all the chromosomes ----
    gene(2,index) = std(population(:,index));
    %% --- Recording the Varaiance of the 'Index' gene of all the chromosomes ----
    gene(3,index) = gene(2,index)^2;
    %% --- Recording the shanon entropy of the 'Index' gene of all the chromosomes ----
    number_of_ones = length(find(population(:,index) == 1));
    prob_one = (number_of_ones/indiv);
    number_of_zeros = length(find(population(:,index) == 0));
    prob_zero = (number_of_zeros/indiv);
    gene(4,index) = -((prob_one*(log2(prob_one))) + (prob_zero * (log2(prob_zero))));
end
mean_entropy_actual = mean(gene(4,:));
mean_entropy_previous = 0;
average_entropy_difference_actual = mean_entropy_actual - mean_entropy_previous;
average_entropy_difference_previous = average_entropy_difference_actual;
mean_entropy_previous = mean_entropy_actual;
%% --------- Record Phenotype information ----------------------------
mean_fitness_actual = mean(fit);
mean_fitness_previous = 0;
average_difference_actual = mean_fitness_actual - mean_fitness_previous;
average_difference_previous = average_difference_actual;
mean_fitness_previous = mean_fitness_actual;
for it=2:iter % --------- itteration loop  ---------------------------
% -------------------------------------------------------------------------
for i=0:(grid_y - 1)
    for j=1:grid_x
        % ----------- Select the First Parentat position i,j ---------
        parent_1 = (i * grid_x) + j;
        chosen = parent_1;
        parent_1 = population(chosen,:);
        fit_parent_1 = fit(chosen);
        % ----------- Select the second parent -----------------------
        y = floor(chosen/grid_x);
        x = chosen - (y * grid_x);
        neighbourhood = [];
        if y == 0
            %% ------ First element of the grid ---------
            if x == 1 
                x1 = x + 1;
                y1 = y;
                x2 = x;
                y2 = y+1;
                x3 = x;
                y3 = grid_y - 1;
                x4 = grid_x;
                y4 = y;
                candidate1 = (y1 * grid_x) + x1;
                candidate2 = (y2 * grid_x) + x2;
                candidate3 = (y3 * grid_x) + x3;
                candidate4 = (y4 * grid_x) + x4;
                neighbourhood = [candidate2 candidate1 candidate3 candidate4];
            else 
               %% ----------- First line of the grid -----------------------
                x1 = x + 1;
                y1 = y;
                x2 = x;
                y2 = y+1;
                x3 = x;
                y3 = grid_y - 1;
                x4 = x - 1;
                y4 = y;
                candidate1 = (y1 * grid_x) + x1;
                candidate2 = (y2 * grid_x) + x2;
                candidate3 = (y3 * grid_x) + x3;
                candidate4 = (y4 * grid_x) + x4;
                neighbourhood = [candidate4 candidate1 candidate2  candidate3];               
            end
        else
             if x == 0
                if y == 1
                   %% ------------ the last element of the first line -------------
                   x1 = grid_x - 1;
                   y1 = 0;
                   x2 = 0;
                   y2 = 2;
                   x3 = 1;
                   y3 = 0;
                   x4 = 0;
                   y4 = grid_y;
                   candidate1 = (y1 * grid_x) + x1;
                   candidate2 = (y2 * grid_x) + x2;
                   candidate3 = (y3 * grid_x) + x3;
                   candidate4 = (y4 * grid_x) + x4;
                   neighbourhood = [candidate3 candidate1 candidate2 candidate4]; 
                else
                   if y == grid_y
                      %% ------------ the last element of the last line -------------
                      x1 = 1;
                      y1 = grid_y - 1;
                      x2 = 0;
                      y2 = grid_y - 1;
                      x3 = grid_x - 1;
                      y3 = grid_y - 1;
                      x4 = 0;
                      y4 = 1;
                      candidate1 = (y1 * grid_x) + x1;
                      candidate2 = (y2 * grid_x) + x2;
                      candidate3 = (y3 * grid_x) + x3;
                      candidate4 = (y4 * grid_x) + x4;
                      neighbourhood = [candidate4 candidate1 candidate2 candidate3]; 
                   else
                      %% ------------ the last element of the rest line -------------
                      x1 = 0;
                      y1 = y - 1;
                      x2 = 1;
                      y2 = y - 1;
                      x3 = grid_x - 1;
                      y3 = y - 1;
                      x4 = 0;
                      y4 = y + 1;
                      candidate1 = (y1 * grid_x) + x1;
                      candidate2 = (y2 * grid_x) + x2;
                      candidate3 = (y3 * grid_x) + x3;
                      candidate4 = (y4 * grid_x) + x4;
                      neighbourhood = [candidate1 candidate2 candidate3 candidate4];                      
                   end
                end
             else
                 if x == 1
                    if y == (grid_y - 1)
                       %% --------------- first element of the last line -----------
                        x1 = 1;
                        y1 = 0;
                        x2 = 1;
                        y2 = y - 1;
                        x3 = x + 1;
                        y3 = y;
                        x4 = 0;
                        y4 = y + 1;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate1 candidate2 candidate3 candidate4];                 
                    else
                       %% --------------- first element of the remaining lines ----------- 
                        x1 = 1;
                        y1 = y - 1;
                        x2 = 1;
                        y2 = y + 1;
                        x3 = x + 1;
                        y3 = y;
                        x4 = 0;
                        y4 = y + 1;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate1 candidate2 candidate3 candidate4];                          
                    end
                 else
                    if  y  == (grid_y - 1)
                       %% --------------- other element of the last line ----------- 
                        x1 = x;
                        y1 = y - 1;
                        x2 = x - 1;
                        y2 = y;
                        x3 = x + 1;
                        y3 = y;
                        x4 = x;
                        y4 = 0;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate1 candidate2 candidate3 candidate4];                     
                    else
                       %% --------------- other element of the remaining lines ----------- 
                        x1 = x - 1;
                        y1 = y ;
                        x2 = x + 1;
                        y2 = y;
                        x3 = x;
                        y3 = y + 1;
                        x4 = x;
                        y4 = y - 1;
                        candidate1 = (y1 * grid_x) + x1;
                        candidate2 = (y2 * grid_x) + x2;
                        candidate3 = (y3 * grid_x) + x3;
                        candidate4 = (y4 * grid_x) + x4;
                        neighbourhood = [candidate4 candidate1 candidate2 candidate3];                        
                    end
                 end
              end
        end
        % ------ Perform the binary tournament on the neighbourhoud --------- 
        fit_list = []; 
        for k=1:length(neighbourhood) 
            fit_list = [fit_list fit(neighbourhood(k))]; 
        end
        % ------ extract the best individual from the neighbourhood----------
        [chosen_value,ind_chosen] = min(fit_list); 
        indice = neighbourhood(ind_chosen); 
        parent_2 = population(indice,:); 
        fit_parent_2 = fit(indice);
        %% ----------------- Perform DPX1 crossover -------------------------
        if rand <= pcr 
            cross_point_one = randi(Dimension); 
            cross_point_two = randi(Dimension);  
            % -- condition to avoid the first point is after the second -----
            if cross_point_one > cross_point_two 
                a = cross_point_one; 
                cross_point_one = cross_point_two; 
                cross_point_two = a; 
            end
            c1 = [parent_1(1:cross_point_one) parent_2((cross_point_one+1):cross_point_two) parent_1((cross_point_two + 1):Dimension)];
            c2 = [parent_2(1:cross_point_one) parent_1((cross_point_one+1):cross_point_two) parent_2((cross_point_two + 1):Dimension)];
        else
            c1 = parent_1;
            c2 = parent_2;
        end
        %% --- find the best parent ----
        if fit_parent_2 > fit_parent_1
            best_parent = parent_1;
        else
            best_parent = parent_2;
        end
        % ------- compute the child that has the bigger part of the best ---
        sub_1 = abs(c1 - best_parent);
        sub_2 = abs(c2 - best_parent);
        pos_1 = find(sub_1 == 0);
        pos_2 = find(sub_2 == 0);
        test_1 = length(pos_1);
        test_2 = length(pos_2);
        if test_1 > test_2
            child = c1;
        else
            child = c2;
        end
        %% ---- Apply Bit-Flip Mutation On the resulted child --------------
        vect_bit_flip = rand(1,Dimension); 
        test_bit_flip = repmat(pm,1,Dimension);
        vect_bit_flip = (vect_bit_flip <= test_bit_flip);  
        child = xor(child,vect_bit_flip); 
        %% ---------- Evaluation of the Produced Offsprings ----------------
        child_fit = RC_Function(child,Dimension,network,neighbourhoud); 
        %% ---------- Update the population using binary tournament --------
        if fit(chosen) >= child_fit 
            fit(chosen) = child_fit; 
            population(chosen,:) = child; 
        end
    end
end
%% ------------calculate the new best individual --------------------
[bestFit,indbest] = min(fit);
gbest = population(indbest,:);
fitness_best = fit(indbest);

%% -------- Record genotype informations -------------------------
% -- Recording Information About The State Of the Population -----------
gene = zeros(4,Dimension);
for index=1:Dimension
    %% --- Recording the Mean of the 'Index' gene of all the chromosomes ----
    gene(1,index) = mean(population(:,index));
    %% --- Recording the STD of the 'Index' gene of all the chromosomes ----
    gene(2,index) = std(population(:,index));
    %% --- Recording the Varaiance of the 'Index' gene of all the chromosomes ----
    gene(3,index) = gene(2,index)^2;
    %% --- Recording the shanon entropy of the 'Index' gene of all the chromosomes ----
    number_of_ones = length(find(population(:,index) == 1));
    prob_one = (number_of_ones/indiv);
    number_of_zeros = length(find(population(:,index) == 0));
    prob_zero = (number_of_zeros/indiv);
    gene(4,index) = -((prob_one*(log2(prob_one))) + (prob_zero * (log2(prob_zero))));
end
mean_entropy_actual = mean(gene(4,:));
average_entropy_difference_actual = mean_entropy_actual - mean_entropy_previous;
%% -------- Record phenotype informations -------------------------
mean_fitness_actual = mean(fit);
average_difference_actual = mean_fitness_actual - mean_fitness_previous;
%% -------- Perform a dynamic evolution of the grid shape ---------
threshold_c1 = (1 + epsilon) * average_entropy_difference_previous;
threshold_c3 = (2  - epsilon) * average_entropy_difference_previous;
threshold_c2 = (1 + epsilon) * average_difference_previous;
threshold_c4 = (2  - epsilon) * average_difference_previous;
% ----- exploit: change towards square shapes ----
if (average_entropy_difference_actual < threshold_c1) & (average_difference_actual < threshold_c2 )
   if grid_y ~= ub_grid_y
       if index_actual_shape < length(grid_ys)
           index_actual_shape = (index_actual_shape + 1); 
           grid_y = grid_ys(index_actual_shape); 
           grid_x = grid_xs(index_actual_shape);
       end
   end
end
% ----- explore: change towards narrow shapes ----
if (average_entropy_difference_actual > threshold_c3) & (average_difference_actual > threshold_c4)
   if grid_y ~= lb_grid_y
       if index_actual_shape > 1 
           index_actual_shape = (index_actual_shape - 1);
           grid_y = grid_ys(index_actual_shape); 
           grid_x = grid_xs(index_actual_shape);
       end
   end
end
%% -------- Update information for the next generation ------------
average_entropy_difference_previous = average_entropy_difference_actual;
mean_entropy_previous = mean_entropy_actual;
average_difference_previous = average_difference_actual;
mean_fitness_previous = mean_fitness_actual;
%% --------------------------------------------------------------------
ALL_FITNESSES = [ALL_FITNESSES fitness_best]; 
ALL_ITTERATIONS = [ALL_ITTERATIONS (it * indiv)];
% -------------------------------------------------------------------------
end %--------------end of the loop t=1:iter-------------------------------
if FITNESS_GBEST > fitness_best
FITNESS_GBEST = fitness_best;
GBEST_ALL = gbest;
end
ALL_EXECUTION = [ALL_EXECUTION fitness_best];
oo = toc;
ti = ti + oo;
ALL_TIME = [ALL_TIME ti];
end
%% ----  Writing the result -----------------------------------------------
moy =  mean(ALL_EXECUTION);
ecart = std (ALL_EXECUTION);
datte = mat2cell(date);
timee =  num2str(sum(ALL_TIME));
timme =  mat2cell(timee);
%% ---- Writing on Excel File ---------------------------------------------------------------------------------------------
vect_one = [datte Nexe it indiv Dimension instance timme mean(ALL_TIME) std(ALL_TIME)  min(ALL_EXECUTION) max(ALL_EXECUTION) moy ecart];

headers = {'date', 'Nbr_Execution','Nbr_Fitness_Evaluations','Nbr_Individual','Dimension (cells)','Instance','Execution_Time','Mean','Std','Best','Worst','Mean','Std'};
name = strcat(instance,'.xls');
xlwrite(name,[headers;vect_one],1);
%% --- Recording the results obtained by the best individual  -------------------------------
datee =  num2str(date);
result = Gbest_Show(GBEST_ALL,Dimension,network,neighbourhoud);
vect_two = [datte result(1) result(2) result(3)];
headers = {'date','Fitness','Update Location Cost','Paging Cost'};
xlwrite(name,[headers;vect_two],2);
%% ---- Recording The Reporting Cells ID ------------------------------------------------------
vect_two = [cell2mat(result(4))'];
headers = {'Reporting Cell'};
xlwrite(name,vect_two',3);
%% ---- Recording the ID of Non Reporting Cells -----------------------------------------------
vect_two = [cell2mat(result(5))];
headers = {'Non Reporting Cell'};
xlwrite(name,vect_two',4);
xlwrite(name,ALL_EXECUTION,6);
xlwrite(name,ALL_TIME,7);
xlwrite(name,transpose(ALL_FITNESSES),8);
xlwrite(name,transpose(ALL_ITTERATIONS),9);
end
%% I added this command because Daniel told me that if i don't add it it will ot escape and display the results of the run 
exit;
