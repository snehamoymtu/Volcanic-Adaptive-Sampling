function [Sec_data, old_var] = Adaptive_Samp_Optimizer(Data1,num_data1,grid1,bit_size1,mod1,C0,nk1,CC,th_dist1,pop_size1,generation1,mu_rate1,cross_rate1,tr_size1,el_count1)

% Please check the Adaptive_Sampling_parameter_file.m to understand the
% input data for this code

% OUTPUT

% Sec_data: The adaptive sampling data locations. The number of row will be
% sample as the num_data1 (number of adatpive sample) variable value.

% old_var: The variance calculated using the sample measurement data (Data1
% variable)


c1=[C0(1:end,1:end);CC(1:end,1:end)];
coc1=CC(1:end,1:end)+C0(1:end,1:end);

global Data;
global num_data;
global grid;
global bit_size;
global mod;
global c;
global nk; 
global coc
global th_dist
global p_size
global generation
global mu_rate
global cross_rate
global tr_size
global el_count



c=c1;
mod=mod1;
Data=Data1;
num_data=num_data1;
grid=grid1;
bit_size=bit_size1;
nk=nk1;
coc=coc1;
th_dist=th_dist1;
p_size=pop_size1;
generation=generation1;
mu_rate=mu_rate1;
cross_rate=cross_rate1;
tr_size=tr_size1;
el_count=el_count1;

[krig_var]=krig_sc(Data,grid,mod,c,nk,coc,th_dist);
k_old= krig_var(:,3)>=0;
old_var=sum(krig_var(k_old,3));



options = gaoptimset('CreationFcn', {@PopFunction},...
                     'PopulationSize',p_size,...
                     'Generations',generation,...
                     'PopulationType', 'bitstring',... 
                     'SelectionFcn',{@selectiontournament,tr_size},...
                     'MutationFcn',{@mutationuniform, mu_rate},...
                     'CrossoverFcn', {@crossoverarithmetic,cross_rate},...
                     'EliteCount',el_count,...
                     'StallGenLimit',20,...
                     'PlotFcns',{@gaplotbestf},...  
                     'Display', 'iter'); 
rand('seed',1)
nVars = bit_size*num_data; % 
FitnessFcn = @FitFunc_krigvar; 
[chromosome,~,~,~,~,~] = ga(FitnessFcn,nVars,options);
Best_chromosome = chromosome; % Best Chromosome
for i=1:num_data
    loc=Best_chromosome((i-1)*bit_size+1:i*bit_size);
    x_sec=bi2de(loc);
    a1=((x_sec+0.01)/2^bit_size)*length(grid);
    a2=ceil(a1);
    n_data=grid(a2,:);
    Sec_data(i,:)=n_data;
end



%%% POPULATION FUNCTION
function [pop] = PopFunction(GenomeLength,~,options)
RD = rand;  
pop = (rand(options.PopulationSize, GenomeLength)> RD); % Initial Population
%end

%%% FITNESS FUNCTION   You may design your own fitness function here
function [FitVal] = FitFunc_krigvar(pop)
%global Data
global Data;
global num_data;
global grid;
global bit_size;
global mod;
global c;
global nk; 
global coc
global th_dist

for j=1:num_data
    loc=pop((j-1)*bit_size+1:j*bit_size);
    %loc=Best_chromosome((j-1)*bit_size+1:j*bit_size);
    x_sec=bi2de(loc);
    a1=((x_sec+0.01)/2^bit_size)*length(grid);
    a2=ceil(a1);
    n_data=grid(a2,:);
    new(j,:)=[n_data -999];
end
Data_new=[Data;new];

pos_est=grid;
[s]=krig_sc(Data_new,pos_est,mod,c,nk,coc,th_dist);
k= s(:,3)>=0;
var_sum=sum(s(k,3));
FitVal = var_sum;
%end


