x = 0:0.01:5;
y = sqrt(5*x)+x;
tol=0.01;
addpath('../');
[x_coarse,y_coarse] = CoarsenXYData(x,y,tol);
err_max = max(abs(interp1(x_coarse,y_coarse,x)-y));
plot(x,y,'-',x_coarse,y_coarse,'o')
title(sprintf('N=%d --> N=%d, err_m_a_x=%1.4f < %1.4f',length(x),length(x_coarse),err_max,tol))
assert(err_max<tol, 'err_max > tol')