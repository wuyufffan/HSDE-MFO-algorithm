% From: Wenyin Gong Parameter extraction of solar cell models using repaired adaptive differential evolution

%  PV model with single-diode
if func_flag==1
    Xmin = [ 0.0  0.0      0.0  0.0    1.0];
    Xmax = [ 1.0  1.0e-06  0.5  100.0  2.0];
%     Xmin = [0.760775662  0.323154e-06  0.03637551  53.72563852    1.481225178];
%     Xmax = [0.760775662  0.323154e-06  0.03637551  53.72563852    1.481225178];

    D = 5;
    known_optimal   = 0.0;
end
 
%  PV model with double-diode
if func_flag==2
    Xmin = [ 0.0  0.0      0.0   0.0   1.0  0.0     1.0];
    Xmax = [ 1.0  1.0e-06  0.5  100.0  2.0  1.0e-06  2];
%     Xmin = [0.760781  0.225974e-06  0.03674  55.485441 1.451017 0.749346e-06 2];
%     Xmax = [0.760781  0.225974e-06  0.03674  55.485441 1.451017 0.749346e-06 2];
    D = 7;
    known_optimal   = 0.0;
end

%  PV model with module-diode
if func_flag==3
    Xmin = [ 0.0  0.0       0.0  0    1.0];
    Xmax = [ 2.0  50.0e-06  2.0  2000.0  50.0];
%     Xmin = [1.030514  3.482263e-06  1.201271  981.982240  48.642835];
%     Xmax = [1.030514  3.482263e-06  1.201271  981.982240  48.642835];    
    
    
    D = 5;
    known_optimal   = 0.0;
end




% PV model with module-diode
if func_flag==4
    Xmin = [ 1.0  0.0      0.0  0.0     1.0   0.0      1.0 ];
    Xmax = [ 2.0  50.0e-6  2.0  2000.0  50.0  50.0e-6  50 ];
    D = 7;
    known_optimal   = 0.0;
end
 
 