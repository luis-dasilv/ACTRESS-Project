function [x] = solve_para(para_res,theta_p7)
%%%% Function used to detect para, Function mainly used for investigation,
%%%% not presented in the report
syms para x_res;
eqn = x_res + para_res*sin(x_res.*pi./(180)) == theta_p7 ;
x = double(vpasolve(eqn,x_res));
end