
% This is the demo file for running adaptive sampling 


% First it will call the paramater file 

Adaptive_Sample_parameter_file

% Then it will call the adaptive sampling optimizer

[Sec_data, old_var] = Adaptive_Samp_Optimizer(Data1,num_data1,grid1,bit_size1,mod1,C0,nk1,CC,th_dist1,pop_size1,generation1,mu_rate1,cross_rate1,tr_size1,el_count1);
