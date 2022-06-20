function [] = lineanddot(para,theta_p7,color)
%%%PRINT ZEROS OF SHIFTED FUNCTIONS AND PRINT THE DOTS
%%% COMPUTE THE ZEROS BASED ON THE ZERO OF THE PARA=0 FUNCTIONS AND THE
%%% PARA FROM THE ACTUAL FUNCTIONS

text3=['Zeros @ ' num2str(round(para*pi/180*100)),'\% = '];
text4=[num2str(round(solve_para(para,theta_p7),1))];
text5=[text3 text4];
xline(solve_para(para,theta_p7),'-',text5,'Color',color,'LabelVerticalAlignment','bottom', 'HandleVisibility','off','FontWeight','bold',Interpreter='latex',FontSize=12)

plot(solve_para(para,theta_p7),0,'o','Color',color,'MarkerFaceColor',color,'HandleVisibility','off')

end