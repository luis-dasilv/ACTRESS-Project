clc ;close all;

% %%%%%ANCHORING FORCE PREDICTION FROM 3D POLYFIT
GRAIN_grav= 2 ;%mm
GRAIN_sand = 0 ;
GRAIN_AQ1 = 0.9 ;
GRAIN_AQ2 = 1.5 ;

%GRAIN_grav= 1432 ;%mm
%GRAIN_sand = 1048 ;
%GRAIN_AQ1 = 1632 ;
%GRAIN_AQ2 = 1508 ;


%%SWITCH_ANGLE PREDICITION
Theta_switch_grav = 37.5+90 ;
Theta_switch_sand = 20+90 ;
Theta_switch_AQ1 = 27.5+90 ;
Theta_switch_AQ2 = 35+90 ;
%%% LINEAR INTERPOLATION
Predicted_AQ1_Switch = (Theta_switch_grav-Theta_switch_sand)/(GRAIN_grav-GRAIN_sand).*(GRAIN_AQ1-GRAIN_sand)+Theta_switch_sand;
Predicted_AQ2_Switch = (Theta_switch_grav-Theta_switch_sand)/(GRAIN_grav-GRAIN_sand).*(GRAIN_AQ2-GRAIN_sand)+Theta_switch_sand;

%REFINED EXPERIMENT SWITCH ANGLE

initial_angle = [30 40 25 40];
range=[0:8]*2.5-10
configuration = flip((initial_angle'-range)',1)
Results= [0	0	0	0;
          0	0	0	0;
          0	1	1	0;
          1	2	2	1;
          2	2	2	2;
          2	2	2	2;
          2	2	2	2;
          2	2	2	2;
          2	2	2	2]
figure;
hold on
media=[{'Aquarium 1 '},{'Aquarium 2 '},{'Sand '},{'Gravel 1 '}];
for j =1:size(Results,2)
    yline(j,Alpha=0.2)
    for i=1:size(Results,1)
        switch Results(i,j)
            case 1 
                scatter(configuration(i,j),j,'yo','filled',"SizeData",100)
            case 2 
                scatter(configuration(i,j),j,'ro','filled',"SizeData",100)
            case 0
                scatter(configuration(i,j),j,'go','filled',"SizeData",100)
        end
   
    end
    
    text(10,j,media(j),'HorizontalAlignment','right','VerticalAlignment','middle',Interpreter="latex",FontSize=12);

end
title('Refined experimental switch angle inspection',Interpreter="latex",FontSize=16)
xlabel('Angle of anchor [\textsuperscript{o}]',Interpreter='latex',FontSize=12)
legend('','Upwards lift','','','Zero lift','Downwards lift',Location='northwest',Interpreter="latex",FontSize=14)
xlim([10 48])
ylim([0.8 4.2])
set(gca,'ytick',[])
grid
hold off

%PLOTTING SWITCH ANGLE MODEL PREDICTION
figure
res=2.5;%range_estimation_size
hold on
grain=(0:1000)./200;
plot([GRAIN_AQ1 GRAIN_AQ1],[Theta_switch_AQ1-res Theta_switch_AQ1+res],'k',LineWidth=4);
plot([GRAIN_AQ2 GRAIN_AQ2],[Theta_switch_AQ2-res Theta_switch_AQ2+res],'k',LineWidth=4);
plot(grain,(Theta_switch_grav-Theta_switch_sand)/(GRAIN_grav-GRAIN_sand).*(grain-GRAIN_sand)+Theta_switch_sand)
scatter(GRAIN_AQ1,Theta_switch_AQ1,100,'co','filled')
scatter(GRAIN_AQ2,Theta_switch_AQ2,100,'co','filled')
scatter(GRAIN_AQ1,Predicted_AQ1_Switch,100,'ro','filled')
scatter(GRAIN_AQ2,Predicted_AQ2_Switch,100,'ro','filled')
text6AQ1=['AQ1 GRAIN DIAMETER= ' num2str(GRAIN_AQ1)];
text6AQ2=['AQ2 GRAIN DIAMETER= ' num2str(GRAIN_AQ2)];
xline(GRAIN_AQ1,'-r',text6AQ1,'LabelVerticalAlignment','top',Interpreter='latex')
xline(GRAIN_AQ2,'-r',text6AQ2,'LabelVerticalAlignment','top',Interpreter='latex')
text7AQ1=['PREDICTED AQ1 THETA SWITCH = ',num2str(Predicted_AQ1_Switch)];
text7AQ2=['PREDICTED AQ2 THETA SWITCH = ',num2str(Predicted_AQ2_Switch)];
text8AQ1=['EXPERIMENTAL AQ1 THETA SWITCH = ',num2str(Predicted_AQ1_Switch)];
text8AQ2=['EXPERIMENTAL AQ2 THETA SWITCH = ',num2str(Predicted_AQ2_Switch)];
yline(Predicted_AQ1_Switch,'-r',text7AQ1,'LabelHorizontalAlignment','right','FontSize',12, Interpreter='latex')
yline(Predicted_AQ2_Switch,'-r',text7AQ2,'LabelHorizontalAlignment','right','FontSize',12,Interpreter='latex')
xline(GRAIN_grav,':','Grain diameter Gravel n\textsuperscript{o}1','LabelVerticalAlignment','top','FontSize',12,Interpreter='latex');
xline(GRAIN_sand,':','Grain diameter Sand','LabelVerticalAlignment','top','FontSize',12,Interpreter='latex')
yline(Theta_switch_sand,':','Switch angle Sand','LabelHorizontalAlignment','right','FontSize',12,Interpreter='latex')
yline(Theta_switch_grav,':','Switch angle Gravel n\textsuperscript{o}1','LabelHorizontalAlignment','right','FontSize',12,Interpreter='latex')
xlabel('Grain diameter (mm)','FontSize',12,Interpreter='latex')
xlim([-0.5 5])
ylabel('Switch angle (\textsuperscript{o})','FontSize',12,Interpreter='latex')
title('Switch angle prediction Linear Prediction, based on 2 points',Interpreter='latex',FontSize=16)
legend('Experimental estimate range ','','','Experimental points','','Predicted values','',Interpreter='latex',FontSize=12)
ylim([109 140])


%ANALYSIS SWITCH ANGLE MODEL PREDICTION
DIF_SW_AQ1 = (Predicted_AQ1_Switch - Theta_switch_AQ1)/max(Predicted_AQ1_Switch-90,Theta_switch_AQ1-90)
DIF_SW_AQ2 = (Predicted_AQ2_Switch - Theta_switch_AQ2)/max(Predicted_AQ2_Switch-90,Theta_switch_AQ2-90)

TABLE_RESULTS_SWITCH = [Theta_switch_AQ1-90 DIF_SW_AQ1 Predicted_AQ1_Switch-90 ; Theta_switch_AQ2-90 DIF_SW_AQ2 Predicted_AQ2_Switch-90]'


%%%%%PREDICTION FROM 3D POLYFIT

% SAND MODEL
load("DATA_SAND.mat")
ANGLES_S = DATA_SAND(1,:)';
AREAS_S = DATA_SAND(2,:)';
DATA_S =[ANGLES_S,AREAS_S];
SAND = DATA_SAND(3,:)';
p_sand = polyfitn(DATA_S,SAND,1);    %POLYFITN

% Gravel MODEL
load("DATA_GRAVELN1.mat")
ANGLES_G = DATA_GRAVELN1(1,:)';
AREAS_G = DATA_GRAVELN1(2,:)';
DATA_G=[ANGLES_G,AREAS_G];
GRAVEL= DATA_GRAVELN1(3,:)';
p_gravel = polyfitn(DATA_G,GRAVEL,1); %POLYFITN

% Aquarium sand VALIDATION
load("DATA_SAND_AQ1.mat")
ANGLES_AQ1 = DATA_SAND_AQ1(1,:)';
AREAS_AQ1 = DATA_SAND_AQ1(2,:)';
DATA_AQ1=[ANGLES_AQ1,AREAS_AQ1];
AQ1= DATA_SAND_AQ1(3,:)';

% Aquarium sand VALIDATION
load("DATA_SAND_AQ2.mat")
ANGLES_AQ2 = DATA_SAND_AQ2(1,:)';
AREAS_AQ2 = DATA_SAND_AQ2(2,:)';
DATA_AQ2=[ANGLES_AQ2,AREAS_AQ2];
AQ2= DATA_SAND_AQ2(3,:)';

POINTS_S = polyvaln(p_sand,[ANGLES_AQ1,AREAS_AQ1]);
POINTS_G = polyvaln(p_gravel,[ANGLES_AQ1,AREAS_AQ1]);
Predicted_AQ1 = (POINTS_G-POINTS_S)/(GRAIN_grav-GRAIN_sand)*(GRAIN_AQ1-GRAIN_sand)+POINTS_S;
Predicted_AQ2 = (POINTS_G-POINTS_S)/(GRAIN_grav-GRAIN_sand)*(GRAIN_AQ2-GRAIN_sand)+POINTS_S;


h=figure;
view(3)
hold on

% Evaluate on a grid and plot
angle_grid_ini= 0:45;
area_grid_ini = 0:500:4500;
[xg,yg]=meshgrid(angle_grid_ini,area_grid_ini);
zg_s = polyvaln(p_sand,[xg(:),yg(:)]);
zg_g = polyvaln(p_gravel,[xg(:),yg(:)]);
surf(xg,yg,reshape(zg_g,size(xg)),'FaceLighting','gouraud',...
    'SpecularColorReflectance',0,...
    'SpecularExponent',5,...
    'SpecularStrength',0.2,...
    'DiffuseStrength',1,...
    'AmbientStrength',0.4,...
    'AlignVertexCenters','on',...
    'LineWidth',0.1,...
    'FaceAlpha',0.3,...
    'FaceColor',[0.07 0.6 1],...
    'EdgeAlpha',0.1);

surf(xg,yg,reshape(zg_s,size(xg)),'FaceLighting','gouraud',...
    'SpecularColorReflectance',0,...
    'SpecularExponent',5,...
    'SpecularStrength',0.2,...
    'DiffuseStrength',1,...
    'AmbientStrength',0.4,...
    'AlignVertexCenters','on',...
    'LineWidth',0.1,...
    'FaceAlpha',0.3,...
    'FaceColor',[0.8500 0.3250 0.0980],...
    'EdgeAlpha',0.1);

scatter3(DATA_S(:,1),DATA_S(:,2),SAND,'ro','filled')
scatter3(DATA_G(:,1),DATA_G(:,2),GRAVEL,'bo','filled')
scatter3(DATA_AQ1(:,1),DATA_AQ1(:,2),AQ1,100,'d','MarkerEdgeColor','k','MarkerFaceColor',[0 .75 .75])
scatter3(DATA_AQ2(:,1),DATA_AQ2(:,2),AQ2,100,'MarkerEdgeColor','k','MarkerFaceColor','r')
scatter3(DATA_AQ1(:,1),DATA_AQ1(:,2),Predicted_AQ1,100,'d','MarkerEdgeColor','k','MarkerFaceColor','k')
scatter3(DATA_AQ2(:,1),DATA_AQ2(:,2),Predicted_AQ2,100,'MarkerEdgeColor','k','MarkerFaceColor','y')
set(gca,"FontSize",12)
title('Polynomial surface fit to gravel and sand data, with validations data and its predicitons','FontSize',18,Interpreter='latex')
xlabel('Angle of anchor [\textsuperscript{o}]','FontSize',14,Interpreter='latex')
xlim([-5 45])
ylim([2500 4500])
zlim([0 1200])
ylabel('Sub Area (mm\textsuperscript{2})','FontSize',14,Interpreter='latex')
zlabel('Mean Force (g)','FontSize',14,Interpreter='latex')
grid on
legend('POLYFIT SAND','POLYFIT GRAVEL','Sand Data','Gravel n\textsuperscript{o}1 data','AQ1 data','AQ2 data','Predicted AQ1','Predicted AQ2','FontSize',13,Interpreter='latex')

% %DIF_AQ1
% DIF_AQ1= [AQ1-Predicted_AQ1]./AQ1*100;
% figure
% view(3)
% hold on
% scatter3(DATA_AQ1(:,1),DATA_AQ1(:,2),AQ1,'bo','filled')
% scatter3(DATA_AQ1(:,1),DATA_AQ1(:,2),Predicted_AQ1,'ro','filled')
% stem3(DATA_AQ1(:,1),DATA_AQ1(:,2), max([Predicted_AQ1 AQ1],[],2))
% for i=1:size(DIF_AQ1,1)
%     text(DATA_AQ1(i,1)-0.2,DATA_AQ1(i,2)-10, mean([Predicted_AQ1(i); AQ1(i)])-(abs(Predicted_AQ1(i)-AQ1(i)))*0.2 ,['+',num2str(round(DIF_AQ1(i),2)) '\%'],'HorizontalAlignment','left','VerticalAlignment','bottom',Interpreter="latex")
% end
% for i=1:size(DIF_AQ1,1)
%     text(DATA_AQ1(i,1),DATA_AQ1(i,2),AQ1(i)+10,[num2str(round(AQ1(i),2))],'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex")
% end
% for i=1:size(DIF_AQ1,1)
%     text(DATA_AQ1(i,1),DATA_AQ1(i,2),Predicted_AQ1(i)-20,[num2str(round(Predicted_AQ1(i),2))],'HorizontalAlignment','center','VerticalAlignment','top',Interpreter="latex")
% end
% title('Difference between predicted data and experimental data for aquarium sand n\textsuperscript{o}1','FontSize',16,Interpreter='latex')
% subtitle('Difference in \% between the two points','FontSize',12,Interpreter='latex')
% xlabel('Angle of anchor [\textsuperscript{o}]','FontSize',12,Interpreter='latex')
% xlim([-5 45])
% ylabel('Sub Area (mm\textsuperscript{2})','FontSize',12,Interpreter='latex')
% zlabel('Mean Force (g)','FontSize',12,Interpreter='latex')
% grid on
% legend('Experimental data ','Model predicted data','FontSize',12,Interpreter='latex')
% 
% %DIF_AQ2
% DIF_AQ2= [AQ2-Predicted_AQ2]./Predicted_AQ2*100;
% figure
% view(3)
% hold on
% scatter3(DATA_AQ2(:,1),DATA_AQ2(:,2),AQ2,'bo','filled')
% scatter3(DATA_AQ2(:,1),DATA_AQ2(:,2),Predicted_AQ2,'ro','filled')
% stem3(DATA_AQ2(:,1),DATA_AQ2(:,2), max([Predicted_AQ2 AQ2],[],2))
% for i=1:size(DIF_AQ2,1)
%     text(DATA_AQ2(i,1)+1,DATA_AQ2(i,2)-10, mean([Predicted_AQ2(i); AQ2(i)])-(abs(Predicted_AQ2(i)-AQ2(i)))*0.2 ,[num2str(round(DIF_AQ2(i),2)) '\%'],'HorizontalAlignment','left','VerticalAlignment','bottom',Interpreter="latex")
% end
% for i=1:size(DIF_AQ2,1)
%     text(DATA_AQ2(i,1),DATA_AQ2(i,2),AQ2(i)-10,[num2str(round(AQ2(i),2))],'HorizontalAlignment','center','VerticalAlignment','top',Interpreter="latex")
% end
% for i=1:size(DIF_AQ2,1)
%     text(DATA_AQ2(i,1),DATA_AQ2(i,2),Predicted_AQ2(i)+30,[num2str(round(Predicted_AQ2(i),2))],'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex")
% end
% title('Difference between predicted data and experimental data for aquarium sand n\textsuperscript{o}2','FontSize',16,Interpreter='latex')
% subtitle('Difference in \% between the two points','FontSize',12,Interpreter='latex')
% xlabel('Angle of anchor [\textsuperscript{o}]','FontSize',12,Interpreter='latex')
% xlim([-5 45])
% ylabel('Sub Area (mm\textsuperscript{2})','FontSize',12,Interpreter='latex')
% zlabel('Mean Force (g)','FontSize',12,Interpreter='latex')
% grid on
% legend('Experimental data','Model predicted data','FontSize',12,Interpreter='latex')

%%%PLOT DIF AQ1 AND AQ2
DIF_AQ1= abs(AQ1-Predicted_AQ1)./max([Predicted_AQ1 AQ1],[],2)*100
DIF_AQ2= abs(AQ2-Predicted_AQ2)./max([Predicted_AQ2 AQ2],[],2)*100
figure 
hold on 
view(2)
plot(DATA_AQ1(1:5,1),DIF_AQ1(1:5),'-d') 
plot(DATA_AQ1(1:5,1),DIF_AQ1((1:5)+5),'-d')
plot(DATA_AQ2(1:5,1),DIF_AQ2(1:5),'-d') 
plot(DATA_AQ2(1:5,1),DIF_AQ2((1:5)+5),'-d')
title('Relative Percentage Difference for validation media','FontSize',16,Interpreter='latex')
xlabel('Angle of anchor [\textsuperscript{o}]','FontSize',12,Interpreter='latex')
 xlim([-1 41])
ylabel('RPD (\%)','FontSize',12,Interpreter='latex')

set(gca, 'YGrid', 'on', 'XGrid', 'off')
legend('AQ1 2900mm\textsuperscript{2}','AQ1 3700mm\textsuperscript{2}','AQ2 2900mm\textsuperscript{2}','AQ2 3700mm\textsuperscript{2}','FontSize',12,Interpreter='latex')


%%%EXPORT 

TABLE_RESULTS_FORCE= round([AQ1 DIF_AQ1 Predicted_AQ1 AQ2 DIF_AQ2 Predicted_AQ2],2)
TABLE_RESULTS_FORCE =TABLE_RESULTS_FORCE'

