clear;
clc;
format long; 
gbest_all_val ={[] [] []};
gbest_all_pos ={[] [] []};
cg_curve_all = {[] [] []};
NP=50;
% Max_FES=100;
Max_FES=100000;
runs=30;
fun_num=1;
func= @evaluate_normal_fitness;
funslope=zeros(50,1);
Algorithm_name={'HSDEMFO'};

%  for k=1:size(Algorithm_name,2)
for k=1:1
    fprintf('Algorithm =\t %d\n',k);
    cg_curve =[];
    for i=1:3
        func_flag=i;
        if i == 2
            gbest_pos=zeros(30,7);
        else
            gbest_pos=zeros(30,5);
        end
        fprintf('Problem =\t %d\n',i);
        for j=1:runs
            fprintf('run =\t %d\n',j);
            FUNC = Algorithm_name{k};
            tic;
                   
                  [Best_IL,Best_IL_POS,Convergence_curve]=feval(FUNC,func_flag,NP,Max_FES,func);
                  t(1,j) = toc;
                  gbest_val(1,j) = Best_IL;
                  gbest_pos(j,:) = Best_IL_POS;
                  cg_curve(j,:)=Convergence_curve(1,:);
                  
        end
        gbest_all_val{1,i} =gbest_val;
        gbest_all_pos{1,i} =gbest_pos;
        cg_curve_all{1,i} = cg_curve;
        time_all{1,i} = t;   
    end
 end 



