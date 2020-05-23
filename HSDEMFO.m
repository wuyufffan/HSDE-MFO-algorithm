%  Hybrid Symbiotic Differential Evolution Moth-Flame Optimization algorithm(HSDE-MFO)                                                            
%  Source codes demo version 1.0                                                                      
%                                                                                                     
%  Developed in MATLAB R2019a                                                                
%                                                                                                     
%  programmer: YuFan Wu
%  e-Mail: 1095978552@qq.com

function [Best_IL,Best_IL_POS,Convergence_curve]=MFO_10_DEblast_19(func_flag,NP,Max_FES,fobj)  
addpath('Benchmark_Solar_Cell');
format long; 
display('HSDE-MFO is optimizing your problem');
rand('seed', sum(100 * clock));


PV_Xrange;
max_iteration = Max_FES/NP;
dimension=size(Xmin,2);
Convergence_curve = zeros(1,max_iteration);
numg1 = 35;
Val_X = zeros(1,NP);
Val_V = zeros(1,numg1);
V = zeros(numg1,dimension);
gbest_fitness = ones(1,1);
gbest_pos = ones(1,dimension);
X = repmat(Xmin, NP, 1) + rand(NP, D) .* (repmat(Xmax-Xmin, NP, 1));
bb=1;
fitcount = 0;
CR = 0.9;

       for i=1:NP
            Val_X(1,i)=fobj(X(i,:),func_flag);
            fitcount = fitcount + 1;
       end

pbest_pos=X;
pbest_fitness=Val_X;
k = 0;
while k<=max_iteration && fitcount<=Max_FES
     k=k+1;

if k>800
           [~,index_Best] = sort(Val_X); 
           Best = X(index_Best(1),:);
                newX(1,:)=Best(1,:)+Levy(D).*Best(1,:);
                   for d=1:D
                        if rand>=1-fitcount/Max_FES
                            newX(1,d)=Best(d);
                        end       
                   end                 
                  newX = boundConstraint_absorb(newX, Xmin, Xmax);
                      new_val = fobj(newX,func_flag);
                      fitcount = fitcount + 1;   
                  if new_val<Val_X(index_Best(end))   %%%
                      Val_X(1,index_Best(end)) = new_val; 
                      X(index_Best(end),:) = newX;
                  end
end
                 
      pool_pos = [X;pbest_pos];
      pool_fit = [Val_X,pbest_fitness];
    
    [~,pool_index] = sort(pool_fit);
    pool_pos_sorted = pool_pos(pool_index(:),:);
  
         for i = 1:numg1
            c=1;
            b=numg1;
                    dx=randperm(b-c+1)+c-1;
                    r1=dx(1);    
                    r2=dx(2);
                    r3=dx(3);

                    if r1==i
                        r1=dx(6);
                    elseif r2==i
                        r2=dx(6);
                    elseif r3==i
                        r3=dx(6);
                    end
            V(i,:) = X(r1,:)+rand*(X(r2,:)-X(r3,:));
            V(i,:)=boundConstraint_absorb(V(i,:), Xmin, Xmax);
            randx=randperm(dimension);
            for d=1:dimension
                if (rand>CR)&&(randx(1)~=d)
                    V(i,d)=X(i,d);
                end
            end
            Val_V(1,i) =fobj(V(i,:),func_flag);
            fitcount = fitcount + 1;
            if fitcount>=Max_FES
                break;
            end

                if Val_V(1,i)<Val_X(1,i)
                    X(i,:) = V(i,:);
                    Val_X(1,i) = Val_V(1,i);
                    if Val_V(1,i)<pbest_fitness(1,i)
                        pbest_fitness(1,i) = Val_V(1,i);
                        pbest_pos(i,:) =V(i,:);
                        if Val_X(1,i)<gbest_fitness
                            gbest_fitness = Val_V(1,i);
                            gbest_pos = V(i,:);
                        end
                    end
                end
         end
         
         
        for i = numg1+1:NP
            flame = pool_pos_sorted(1:(NP-numg1),:); 
            a=-1+k*((-1)/max_iteration);
            distance_to_flame_temp=abs(X(i,:)-flame(i-numg1,:));
            t=(a-1)*rand(1,dimension)+1;
            X(i,:)=distance_to_flame_temp.*exp(bb.*t).*cos(t.*2*pi)+flame(i-numg1,:);   
            X(i,:)=boundConstraint_absorb(X(i,:), Xmin, Xmax);
            Val_X(1,i)=fobj(X(i,:),func_flag);
            fitcount = fitcount + 1;       
            if fitcount>=Max_FES
                break;
            end
            if  Val_X(1,i)<pbest_fitness(1,i)
                    pbest_fitness(1,i) = Val_X(1,i);
                    pbest_pos(i,:) =X(i,:);
                    if Val_X(1,i)<gbest_fitness
                        gbest_fitness = Val_X(1,i);
                        gbest_pos = X(i,:);
                    end
            end
        end

    if (k==max_iteration)&&(fitcount<max_FES)
        k=k-1;
    end
     Convergence_curve(1,k) =gbest_fitness;  
end
Best_IL = gbest_fitness;
Best_IL_POS = gbest_pos;
end


