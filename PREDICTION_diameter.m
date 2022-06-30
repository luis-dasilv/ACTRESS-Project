function [YOUR_PARA,YOUR_FORCE,YOUR_BEHAVIOUR,YOUR_THETA_SWITCH] = PREDICTION(YOUR_AREA,YOUR_ANGLE,YOUR_GRAIN)
%%%Function used for predicition of values, based on grain diameter. 
%%% DATAS FROM LITERATURE
data25= [0.3095 1.7025 2.9407 3.7145 5.2623 6.8100 7.5838 8.8220 11.4531 16.5606 19.9656 24.7635 30.4901 ...
    38.3835 43.6457 48.4437 54.1702 60.8255 67.1711 73.3620 79.8624 85.2794 91.4703 97.6612 105.3998 ...
    100.6019 93.7919 108.9596 115.4600 120.5675 112.0550 125.8298 130.6277  136.1995 140.6879 145.0215 ...
    150.2837 154.9269 159.1058 163.5942 167.4635 170.5589 173.1900 175.0473 177.6784 179.3809; ...
    0.0080 0.0570 0.0949 0.1365 0.1855 0.2327 0.2715 0.3260 0.3473 0.3621 0.3713 0.3565 ...
    0.3381 0.3242 0.3085 0.2826 0.2595 0.2364 0.2031 0.1652 0.1319 0.1005 0.0727 0.0394 ...
    0.0145 0.0274 0.0589 -0.0022 -0.0271 -0.0465 -0.0160 -0.0622 -0.0743 -0.0826 -0.0872 -0.0928 ...
    -0.0992 -0.1020 -0.1029 -0.1002 -0.1011 -0.0928 -0.0770 -0.0595 -0.0410 -0.0262]';

tetha_OG=data25(:,1);
lift_OG=data25(:,2);

YOUR_ANGLE = YOUR_ANGLE+90;%%CORRECTION FROM CONVENTION

%%%%%POLYFIT FROM DATAS THETA_OG AND LIFT_OG
x=(0:(180*5))./5;
p_3 = polyfit(tetha_OG,lift_OG,3);%POLYNOMIAL DEGREE 3
y_3 = polyval(p_3,x);           %POINTS FROM THESE POLYNOMIALS DEGREE 3
p_5 = polyfit(tetha_OG,lift_OG,5);%POLYNOMIAL DEGREE 5
y_5 = polyval(p_5,x);           %POINTS FROM THESE POLYNOMIALS DEGREE 5
p_7 = polyfit(tetha_OG,lift_OG,7);%POLYNOMIAL DEGREE 7
y_7 = polyval(p_7,x);           %POINTS FROM THESE POLYNOMIALS DEGREE 7
p_9 = polyfit(tetha_OG,lift_OG,9);%POLYNOMIAL DEGREE 9
y_9 = polyval(p_9,x);           %POINTS FROM THESE POLYNOMIALS DEGREE 9

%%%% ROOTS INVESTIGATION OF POLYNOMIALS
r3 = abs(roots(p_3));    %108.5°
r5 = abs(roots(p_5));    %110°
r7 = abs(roots(p_7));    %106.7°---------- SELECTED
r9 = abs(roots(p_9));    %107.3°

%%%% VISUALISATION OF MANY DEGREE INTERPOLATIONS
hold on
title('EXPLANATION : Interpolations functions from original datas',Interpreter='latex',FontSize=16)
plot(tetha_OG,lift_OG,'r*')      %%% POINTS FROM LITTERATURE
plot(tetha_OG,lift_OG.*0,'b')    %%% LINE AT X=0
plot(x,y_3)                      %%% PLOT DEGREE 3
plot(x,y_5)                      %%% PLOT DEGREE 5
plot(x,y_7)                      %%% PLOT DEGREE 7
plot(x,y_9)                      %%% PLOT DEGREE 7
legend('original value','','degree 7','FontWeight','bold',Interpreter='latex')
hold off

%%%%%%% REAL DATAS vs INTERPOLATION DEGREE 7
figure
hold on
set(gca,"FontSize",14)
title('EXPLANATION : Interpolations functions from original datas',Interpreter='latex')
plot(tetha_OG,lift_OG,'r*')      %%% POINTS FROM LITTERATURE
plot(tetha_OG,lift_OG.*0,'b')    %%% LINE AT X=0
plot(x,y_7)                      %%% PLOT DEGREE 7
xline(106.7,':',{'Zero of degree 7';' interpolation'},'LabelVerticalAlignment','top',Interpreter='latex',FontSize=14)
xline(106.7,'.','106.7\textsuperscript{o}','LabelVerticalAlignment','top','LabelHorizontalAlignment','left','FontWeight','bold',Interpreter='latex',FontSize=14)
legend('original value','','degree 7','FontWeight','bold','Location','southwest',Interpreter='latex',FontSize=14)
title({'EXPLANATION :'; 'Real Datas VS Interpolation degree 7'},Interpreter='latex',FontSize=16)

hold off


%%% SHIFTED PLOT, WE DO NOT SHIFT THE Y BUT WE SHIFTED THE X.
%%% F(x) ----> F(G(X))

para=180/pi;% MAXIMUM PARAMETERS TO HAVE ONLY DECREASING FUNCTIONS
set_para=(1:3)./3*para;
set_para= [-flip(set_para) set_para];% SET OF PARA -100% -66% -33% +33% +66% +100%
x_shift = para.*sin((x).*pi./(180))+x; %%% G(x)

%%%%  HOW DOES X IS SHIFTED
figure
grid on
hold on
for i=1:length(set_para)
    x_shift=set_para(i).*sin(x.*2.*pi./(180*2))+x;
    plot(x,x_shift)
end
plot(x,1.2*para.*sin((x).*pi./(180))+x,'r','LineWidth',2.0)%EXTREME 120%
plot(x,x,'k','LineWidth',2.0)               %NORMAL X
xlim([-20 200])
title('EXPLANATION : Shift of X according to strength para',Interpreter='latex',FontSize=16)
subtitle('g(x) = x + para * sin(x)',Interpreter='latex')
legend({'para = - 100\% * 180/pi','para = - 66\% * 180/pi','para = - 33\% * 180/pi','para = 33\% * 180/pi','para = 66\% * 180/pi','para = 100\% * 180/pi','para = 120\% * 180/pi','real x'},'Location','southeast','FontWeight','bold',Interpreter='latex')
hold off


%%%% HOW MUCH DOES IT SHIFT F(x)
figure
grid on
hold on
title('EXPLANATION : Shifted behaviour functions F(G(x))',Interpreter='latex',FontSize=16)
subtitle('G(x) = x + para * sin(x)','FontSize',9,Interpreter='latex' )
for i=1:length(set_para)
    x_shift=set_para(i).*sin(x.*2.*pi./(180*2))+x;
    y_7_shift = polyval(p_7,x_shift);
    plot(x,y_7_shift)
end
x_trem = 1.2*para.*sin((x).*pi./(180))+x;   %%% 120%*EXTREME
y_7_shift_trem = polyval(p_7,x_trem);
plot(x,y_7_shift_trem,'r','LineWidth',2.0)
plot(x,y_7,'k','LineWidth',2.0)             %% NORMAL 0%
legend({'para = - 100\% * 180/pi','para = - 66\% * 180/pi','para = - 33\% * 180/pi','para = 33\% * 180/pi','para = 66\% * 180/pi','para = 100\% * 180/pi', 'para = 120\% * 180/pi','real x'},'FontWeight','bold',Interpreter='latex')
hold off

%FIRST MODEL PREDICTION
%WHERE IS THE SWITCH ANGLE FOR YOUR MEDIA :
GRAIN_grav= 2 ;%mm
GRAIN_sand = 0 ;
Theta_switch_grav = 40+90 ;
Theta_switch_sand = 25+90 ;
%    YOUR_GRAIN= 1200;
%%% LINEAR INTERPOLATION
YOUR_THETA_SWITCH = (Theta_switch_grav-Theta_switch_sand)/(GRAIN_grav-GRAIN_sand).*(YOUR_GRAIN-GRAIN_sand)+Theta_switch_sand;
grain=(0:1000)./200;

%%% PLOTTING FIRST MODEL PREDICTION
figure
hold on
plot(grain,(Theta_switch_grav-Theta_switch_sand)/(GRAIN_grav-GRAIN_sand).*(grain-GRAIN_sand)+Theta_switch_sand)
plot(YOUR_GRAIN,YOUR_THETA_SWITCH,'ro')
plot(GRAIN_sand,Theta_switch_sand,'bo')
plot(GRAIN_grav,Theta_switch_grav,'bo')
text6=['YOUR GRAIN = ' num2str(YOUR_GRAIN)];
xline(YOUR_GRAIN,'-r',text6,'LabelVerticalAlignment','top',Interpreter='latex',FontSize=12)
text7=['YOUR THETA SWITCH = ',num2str(round(YOUR_THETA_SWITCH,0))];
yline(YOUR_THETA_SWITCH,'-r',text7,'LabelHorizontalAlignment','right',Interpreter='latex',FontSize=12)
xline(GRAIN_grav,':','Grain Gravel n\textsuperscript{o}1','LabelVerticalAlignment','top',Interpreter='latex',FontSize=12);
xline(GRAIN_sand,':','Grain Sand','LabelVerticalAlignment','top',Interpreter='latex',FontSize=12)
yline(Theta_switch_sand,':','Switch angle Sand','LabelHorizontalAlignment','right',Interpreter='latex',FontSize=12)
yline(Theta_switch_grav,':','Switch angle Gravel n\textsuperscript{o}1','LabelHorizontalAlignment','right',Interpreter='latex',FontSize=12)
xlabel('Grain diameter (mm)',Interpreter='latex',FontSize=14)
xlim([-0.1 5])
ylabel('Switch angle (deg)',Interpreter='latex',FontSize=14)
title('Switch angle prediction Linear Prediction',Interpreter='latex',FontSize=18)

%SECOND MODEL PREDICTION
%WHAT IS YOUR PARA FOR A SWITCH ANGLE (COMPUTED BEFORE) ?
%PARA(THETA) BASED ON SOLUTIONS
%For degree 7th, we have our zero at 106.7*pi/180.
syms para_res x_res
theta_p7 = 106.7;
x_res=YOUR_THETA_SWITCH;
eqn = x_res + para_res*sin(x_res.*pi./(180)) == theta_p7;
YOUR_PARA = double(solve(eqn,para_res)); %YOUR_PARA


%%%% HOW MUCH DOES IT SHIFT F(x)
figure
grid on
hold on
title('RESULTS VS SHIFTED',Interpreter='latex',FontSize=16)
text=['Parameter Results : ',num2str(round(YOUR_PARA*pi/180*100,1)),'\%  * 180/pi'];
%'F(x) = 2.897e-14 * x^7  + -1.949e-11 * x^6 + 5.303e-09 * x^5 + -7.493e-07 * x^4 + 5.89e-05 * x^3 + -0.003 * x^2 +0.053 * x^1 + -0.019'
subtitle({'G(x) = x + para * sin(x)';text},'FontSize',9,Interpreter='latex' )
a=jet(length(set_para)+2);    %SET OF COLORS (parula,
for i=1:length(set_para)
    x_shift=set_para(i).*sin(x.*2.*pi./(180*2))+x;
    y_7_shift = polyval(p_7,x_shift);
    plot(x,y_7_shift,'color',a(i,:))
    %%%ROOTS
    lineanddot(set_para(i),theta_p7,a(i,:));

end
plot(x,y_7,'k','LineWidth',2.0,'Color',a(end-1,:))             %% NORMAL 0%
lineanddot(0,theta_p7,a(end-1,:));
x_RESULTS=YOUR_PARA.*sin(x.*2.*pi./(180*2))+x;      %% Results from prediction
y_7_RESULTS = polyval(p_7,x_RESULTS);
plot(x,y_7_RESULTS,'LineWidth',2.0,'Color',a(end,:))
lineanddot(YOUR_PARA,theta_p7,a(end,:));
text2=['Para = ',num2str(round(YOUR_PARA*pi/180*100,1)),'\% * 180/pi'];
legend({'para = - 100\%  * 180/pi','para = - 66\%  * 180/pi','para = - 33\%  * 180/pi','para = 33\%  * 180/pi','para = 66\%  * 180/pi','para = 100\%  * 180/pi','Real x', text2},'FontWeight','bold',Interpreter='latex')
hold off


%%%%%REAL PREDICTION
%YOUR_ANGLE=90+10; %ANGLE ANCHOR
figure
grid on
hold on
plot(x,y_7,'k','LineWidth',2.0,'Color',a(end-1,:))             %% NORMAL 0%
lineanddot(0,theta_p7,a(end-1,:));
plot(x,y_7_RESULTS,'LineWidth',2.0,'Color',a(end,:))
lineanddot(YOUR_PARA,theta_p7,a(end,:));
title('Prediction of behaviour','FontSize',16,Interpreter='latex')
xline(YOUR_ANGLE,'-b','ANGLE OF ANCHOR','LabelVerticalAlignment','bottom','LineWidth',2.0,'LabelHorizontalAlignment','left',Interpreter='latex')

if YOUR_THETA_SWITCH<YOUR_ANGLE
    text_sub=['For grain diameter of granular media = ', num2str(YOUR_GRAIN), 'mm, anchor will dive IN '];
    text_sub2=['with anchor angle of ',num2str(YOUR_ANGLE) ,' because switch angle is ', num2str(round(solve_para(YOUR_PARA,theta_p7),2))];
    subtitle({text_sub,text_sub2},Interpreter='latex')
    s.Color = '#FF0000';
    YOUR_BEHAVIOUR = 'IN';
else
    text_sub=['For grain diameter of granular media = ', num2str(YOUR_GRAIN), 'mm, anchor will dive OUT '];
    text_sub2=['with anchor angle of ',num2str(YOUR_ANGLE) ,' because switch angle is ', num2str(round(solve_para(YOUR_PARA,theta_p7),2))];
    s=subtitle({text_sub,text_sub2},Interpreter='latex');
    s.Color = '#006321';
    YOUR_BEHAVIOUR = 'OUT';
end


%________________________________________________________________________

% %%%%%ANCHORING FORCE PREDICTION FROM 3D POLYFIT
YOUR_GRAIN = 1.5;
YOUR_ANGLE = 10;
YOUR_AREA = 3300;
%%%%%PREDICTION FROM 3D POLYFIT

% SAND
load("DATA_SAND.mat")
ANGLES_S = DATA_SAND(1,:)';
AREAS_S = DATA_SAND(2,:)';
DATA_S =[ANGLES_S,AREAS_S];
SAND = DATA_SAND(3,:)';
p_sand = polyfitn(DATA_S,SAND,1);    %POLYFITN

% Gravel
load("DATA_GRAVELN1.mat")
ANGLES_G = DATA_GRAVELN1(1,:)';
AREAS_G = DATA_GRAVELN1(2,:)';
DATA_G=[ANGLES_G,AREAS_G];
GRAVEL= DATA_GRAVELN1(3,:)';
p_gravel = polyfitn(DATA_G,GRAVEL,1); %POLYFITN

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


title('Polynomial surface fit to gravel and sand datas','FontSize',16,Interpreter='latex')
xlabel('Angle of anchor [\textsuperscript{o}]',Interpreter='latex')
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter='latex')
zlabel('Mean Force (g)',Interpreter='latex')
grid on

%%%%%%%% PREDICTION
zg_s_predicted = polyvaln(p_sand,[YOUR_ANGLE,YOUR_AREA])
zg_g_predicted = polyvaln(p_gravel,[YOUR_ANGLE,YOUR_AREA])
plot3([YOUR_ANGLE YOUR_ANGLE], [YOUR_AREA YOUR_AREA], [0 2000], 'g','LineWidth',2,'HandleVisibility','off')
scatter3(YOUR_ANGLE,YOUR_AREA,zg_s_predicted,'gsquare','LineWidth',3,'HandleVisibility','off')
scatter3(YOUR_ANGLE,YOUR_AREA,zg_g_predicted,'gsquare','LineWidth',3,'HandleVisibility','off')
scatter3(DATA_S(:,1),DATA_S(:,2),SAND,'ro','filled')
scatter3(DATA_G(:,1),DATA_G(:,2),GRAVEL,'bo','filled')

%%% LINEAR INTERPOLATION
YOUR_FORCE = (zg_g_predicted-zg_s_predicted)/(GRAIN_grav-GRAIN_sand).*(YOUR_GRAIN-GRAIN_sand)+zg_s_predicted;
scatter3(YOUR_ANGLE,YOUR_AREA,YOUR_FORCE,'black','filled','LineWidth',3,'HandleVisibility','on')
legend('POLYFIT SAND','POLYFIT GRAVEL','SAND','GRAVEL','Predicted force')
grain=(0:1000)./200;

%%% PLOTTING FIRST MODEL PREDICTION
figure
hold on
plot(grain,(zg_g_predicted-zg_s_predicted)/(GRAIN_grav-GRAIN_sand).*(grain-GRAIN_sand)+zg_s_predicted)
plot(YOUR_GRAIN,YOUR_FORCE,'ro')
plot(GRAIN_sand,zg_s_predicted,'bo')
plot(GRAIN_grav,zg_g_predicted,'bo')
text6=['YOUR GRAIN = ' num2str(YOUR_GRAIN)];
xline(YOUR_GRAIN,'-r',text6,'LabelVerticalAlignment','top',Interpreter='latex',FontSize=12)
text7=['YOUR FORCE = ',num2str(round(YOUR_FORCE,0))];
yline(YOUR_FORCE,'-r',text7,'LabelHorizontalAlignment','right',Interpreter='latex',FontSize=12)
xline(GRAIN_grav,':','Grain Gravel n\textsuperscript{o}1','LabelVerticalAlignment','top',Interpreter='latex',FontSize=12);
xline(GRAIN_sand,':','Grain Sand','LabelVerticalAlignment','top',Interpreter='latex',FontSize=12)
yline(zg_s_predicted,':','Predicted Force Sand','LabelHorizontalAlignment','right',Interpreter='latex',FontSize=12)
yline(zg_g_predicted,':','Predicted force Gravel n\textsuperscript{o}1','LabelHorizontalAlignment','right',Interpreter='latex',FontSize=12)
xlabel('Grain diameter (mm)',Interpreter='latex',FontSize=14)
ylabel('Rectraction force (g)',Interpreter='latex',FontSize=14)
xlim([-0.1 5])
title('Rectraction force Linear Prediction',Interpreter='latex',FontSize=18)

end