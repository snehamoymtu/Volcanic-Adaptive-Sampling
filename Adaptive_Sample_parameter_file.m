% This code is for Adaptive Sampling for volcanic degassing. Please read
% our manuscript before using it.

% If you are using this code, please cite our work:

% Chatterjee, S., Deering, CD., Waite, GP., Prandi, C., and Lin, P. (2019) 
% An adaptive sampling strategy developed for studies of diffuse volcanic soil 
% gas emissions, Journal of Volcanology and Geothermal Research, 
% https://doi.org/10.1016/j.jvolgeores.2019.06.006

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% First read the data file. 
% The data file should have 3 columuns, first two columns are Norting
% and Easting, OR Y, and X, OR longitude and latitude.
% Thrid column is CO2 flux measurement. 

[Data1] = xlsread('Data.xls');

% Data.xls is an excel file with all sample data

% Then we need to have the grid file where estimation will be made.

[grid1] = xlsread('grid.xls');

% grid.xls is the grid file where the estimation of CO2 flux will be
% performed.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This section is for assigning the paramaters for ordinary kriging

nk1=12;
%   nk: Number of nearest neighbors samples to use in the ordinary kriging
%   variance calculation



mod1=[1 1 1 1 1;4 137 137 0 0];

% mod1: isotropic variogram model with nugget and spherical structure with
% 137 m range

%   model: Each row of this matrix describes a different elementary structure.
%          The first column is a code for the model type, the d following
%          columns give the ranges along the different coordinates and the
%          subsequent columns give rotation angles (a maximum of three).

%          The codes for the current models are:
%             1: nugget effect
%             2: exponential model
%             3: gaussian model
%             4: spherical model
%             5: linear model



 C0=80000;
 %C0: nugtet value
 
 CC=205500;
 %CC: sill value of the variogram
 
 % NOTE: If you want to fit the variograms, you can use the MGTAT Matlab
 % codes available from here: http://mgstat.sourceforge.net/
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % This Section is to assign Genetic Algorithms (GAs) Paramaters
 
 pop_size1=5;
 % pop_size1: the population size of the GAs
 
 generation1=5;
 
 % generation1: Number of generation (iteration number) of the GAs.
 
 % NOTE: For better convergence, the population size and the generation
 % number should be reasonablly high (say, more than 50); however, that
 % will increase the computational time exponentially.
 
 cross_rate1=0.8;
 
 % cross_rate1: Crossover rate of the GA. The value should be within 0 and
 % 1, and higher the crossover rate is recommended.
 
 mu_rate1 = 0.1;
 
 % mu_rate1: Mutation rate of the GA. Mutationa rate value will also be
 % within 0 and 1; but the lower value of the mutationa rate is
 % recommended.
 
 tr_size1 = 2;
 
 % tr_size1: The size of the tournament. We have used tournament selection
 % algorithm in this work.
 
 
 el_count1= 2;

 % el_count1: Elite count of the GA. Some of the best fitted (Elite) parent
 % solution go to the next generation based on the elite count.
 
 % For more details about these paramaters, please read our paper, and
 % consult with Matlab optimization toolbox.
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % This section is to assign remaining Adaptive Sampling Parameters
 
 num_data1=200;
 
 % num_data1: Number of adaptive samples
 
 bit_size1=12;
 
 % bit_size1: The bit size to represent the location of adaptive sample.
 % Higher the number, better the search, but more computational time. 
 % If your grid points are around 10000, it is recommend to keep this value
 % 12. 
 
 % PLESE NOTE: the 2^bitsize should be less than the number of grid points
 
 
 th_dist1= 0.5;
 
 % th_dist1: This will assign the data point to the closes grid point if
 % the distance is the less than this distance. If the th_dist1 is zero,
 % then no data point will be assigned to the grid point, unless the data
 % point is exactly falling at the grid node.
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % This is the end of the parameter file.
 


