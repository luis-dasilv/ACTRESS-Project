%%% Script used for own investigation, not presented in the report. 

clc ;close all;clear all;

%%% DATAS FROM LITERATURE
    load('data25.mat');
    tetha_OG=table2array(data25(:,1));
    lift_OG=table2array(data25(:,2));
    % coef_5=table2array(data25(:,4));
    % coef_3=table2array(data25(:,5));
    % coef_30=table2array(data25(:,6));

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

%%%% ROOTS INVESTIGATION Of P
    r3 = abs(roots(p_3));    %108.5°
    r5 = abs(roots(p_5));    %110°
    r7 = abs(roots(p_7));    %106.7°---------- SELECTED
    r9 = abs(roots(p_9));    %107.3°
    
    hold on
    title('EXPLANATION : Interpolations functions from original datas')
    plot(tetha_OG,lift_OG,'r*')      %%% POINTS FROM LITTERATURE
    plot(tetha_OG,lift_OG.*0,'b')    %%% LINE AT X=0
    plot(x,y_3)                      %%% PLOT DEGREE 3
    
    plot(x,y_5)                      %%% PLOT DEGREE 5
    plot(x,y_7)                      %%% PLOT DEGREE 7
    plot(x,y_9)                      %%% PLOT DEGREE 7
    legend('original value','','degree 3','degree 5','degree 7','degree 9','FontWeight','bold')
    hold off


%%%%%%% REAL DATAS vs INTERPOLATION DEGREE 7
    figure
    hold on
    title('EXPLANATION : Interpolations functions from original datas')
    plot(tetha_OG,lift_OG,'r*')      %%% POINTS FROM LITTERATURE
    plot(tetha_OG,lift_OG.*0,'b')    %%% LINE AT X=0
    plot(x,y_7)                      %%% PLOT DEGREE 7
    legend('original value','','degree 7','FontWeight','bold')
    title('EXPLANATION : Real Datas VS Interpolation degree 7')
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
    title('EXPLANATION : Shift of X according to strength para')
    subtitle('g(x) = x + para * sin(x)')
    legend({'para = - 100% * 180/pi','para = - 66% * 180/pi','para = - 33% * 180/pi','para = 33% * 180/pi','para = 66% * 180/pi','para = 100% * 180/pi','para = 120% * 180/pi','real x'},'Location','southeast','FontWeight','bold')
    hold off


%%%% HOW MUCH DOES IT SHIFT F(x)
    figure
    grid on
    hold on 
    title('EXPLANATION : Shifted behaviour functions F(G(x))')
    subtitle({'G(x) = x + para * sin(x)';'F(x) = 2.897e-14 * x^7  + -1.949e-11 * x^6 + 5.303e-09 * x^5 + -7.493e-07 * x^4 + 5.89e-05 * x^3 + -0.003 * x^2 +0.053 * x^1 + -0.019'},'FontSize',9 )
    for i=1:length(set_para)
    x_shift=set_para(i).*sin(x.*2.*pi./(180*2))+x;
    y_7_shift = polyval(p_7,x_shift);
    plot(x,y_7_shift)
    end
    
    x_trem = 1.2*para.*sin((x).*pi./(180))+x;   %%% 120%*EXTREME
    y_7_shift_trem = polyval(p_7,x_trem);
    plot(x,y_7_shift_trem,'r','LineWidth',2.0)
    plot(x,y_7,'k','LineWidth',2.0)             %% NORMAL 0%
    legend({'para = - 100% * 180/pi','para = - 66% * 180/pi','para = - 33% * 180/pi','para = 33% * 180/pi','para = 66% * 180/pi','para = 100% * 180/pi', 'para = 120% * 180/pi','real x'},'FontWeight','bold')
    hold off

% %%%% TAYLOR DEVELOPMENT OF G(X) = SIN(X) + X FOR ALGEBRAIC RESOLUTION
% %TAYLOR AROUND POINT : sin(x)=sin(a)+cos(a)(x-a)-sin(a)(x-a).^2/2
% a = 107 * pi/180 ;%Taylor development around this point for 
% x_shift_taylor = para.*(sin(a) + cos(a)*(x.*pi./(180)-a) - sin(a)*(x.*pi./(180)-a).^2/factorial(2))+x;
% 
% figure;
% grid on
% hold on
% plot(x,x,'k','LineWidth',2.0)
% x_shift = para.*sin((x).*pi./(180))+x; %%% G(x) 
% plot(x,x_shift)
% x_shift_taylor = para.*(sin(a) + cos(a)*(x.*pi./(180)-a) - sin(a)*(x.*pi./(180)-a).^2/factorial(2))+x;
% plot(x,x_shift_taylor)
% title('Taylor approximation of x + sin(x)')
% legend({'x','x+sin(x)','taylor : sin(x)=sin(a)+cos(a)(x-a)-sin(a)(x-a)^2'},'Location','southeast')
% hold off



%FIRST MODEL PREDICTION
%WHERE IS THE SWITCH ANGLE FOR YOUR MEDIA : 
    density_grav= 1282 ;%kg/m^3
    density_sand = 1005 ;
    Theta_switch_grav = 40+90 ;
    Theta_switch_sand = 25+90 ;
    YOUR_DENSITY= 1200;
    %%% LINEAR INTERPOLATION
    YOUR_THETA_SWITCH = (Theta_switch_grav-Theta_switch_sand)/(density_grav-density_sand).*(YOUR_DENSITY-density_sand)+Theta_switch_sand;
    density=500:1500;
    
    %%% PLOTTING FIRST MODEL PREDICTION
    figure
    hold on
    plot(density,(Theta_switch_grav-Theta_switch_sand)/(density_grav-density_sand).*(density-density_sand)+Theta_switch_sand)
    plot(YOUR_DENSITY,YOUR_THETA_SWITCH,'ro')
    text6=['YOUR DENSITY = ' num2str(YOUR_THETA_SWITCH)];
    xline(YOUR_DENSITY,'-r',text6,'LabelVerticalAlignment','bottom')
    text7=['YOUR THETA SWITCH = ',num2str(YOUR_THETA_SWITCH)];
    yline(YOUR_THETA_SWITCH,'-r',text7,'LabelHorizontalAlignment','left')
    xline(density_grav,':','Density Gravel n°1','LabelVerticalAlignment','bottom');
    xline(density_sand,':','Density Sand','LabelVerticalAlignment','bottom')
    yline(Theta_switch_sand,':','Switch angle Sand','LabelHorizontalAlignment','left')
    yline(Theta_switch_grav,':','Switch angle Gravel n°1','LabelHorizontalAlignment','left')
    xlabel('Density [kg/m^3]') 
    ylabel('Switch angle') 
    title('Switch angle prediction Linear Prediction, based on 2 points')



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
    title('RESULTS VS SHIFTED')
    text=['Parameter Results : ',num2str(round(YOUR_PARA*pi/180*100,1)),'% * 180/pi'];
    subtitle({'G(x) = x + para * sin(x)';'F(x) = 2.897e-14 * x^7  + -1.949e-11 * x^6 + 5.303e-09 * x^5 + -7.493e-07 * x^4 + 5.89e-05 * x^3 + -0.003 * x^2 +0.053 * x^1 + -0.019';text},'FontSize',9 )
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
    text2=['Para = ',num2str(round(YOUR_PARA*pi/180*100,1)),'% * 180/pi'];
    legend({'para = - 100% * 180/pi','para = - 66% * 180/pi','para = - 33% * 180/pi','para = 33% * 180/pi','para = 66% * 180/pi','para = 100% * 180/pi','Real x', text2},'FontWeight','bold')
    hold off


%%%%%REAL PREDICTION
YOUR_THETA=90+10; %ANGLE ANCHOR

figure
grid on
hold on
plot(x,y_7,'k','LineWidth',2.0,'Color',a(end-1,:))             %% NORMAL 0%
lineanddot(0,theta_p7,a(end-1,:));
plot(x,y_7_RESULTS,'LineWidth',2.0,'Color',a(end,:))
lineanddot(YOUR_PARA,theta_p7,a(end,:));
title('Prediction of behaviour','FontSize',20)
xline(YOUR_THETA,'-b','ANGLE OF ANCHOR','LabelVerticalAlignment','bottom','LineWidth',2.0,'LabelHorizontalAlignment','left')

if YOUR_THETA_SWITCH<theta_p7
    fprintf('For density mass of Granular media = %d, anchor will dive in with anchor angle of %d, because switch angle is %.2f \n',YOUR_DENSITY,YOUR_THETA,round(solve_para(YOUR_PARA,theta_p7),2))
    text_sub=['\color{red}For density mass of Granular media = ', num2str(YOUR_DENSITY), ', anchor will dive IN '];
    text_sub2=['with anchor angle of ',num2str(YOUR_THETA) ,' because switch angle is ', num2str(round(solve_para(YOUR_PARA,theta_p7),2))];
    subtitle({text_sub,text_sub2})

else
    fprintf('For density mass of Granular media = %d, anchor will dive OUT with anchor angle of %d, because switch angle is %.2f \n',YOUR_DENSITY,YOUR_THETA,round(solve_para(YOUR_PARA,theta_p7),2))
    text_sub=['\color{darkgreen}For density mass of Granular media = ', num2str(YOUR_DENSITY), ', anchor will dive IN '];
    text_sub2=['with anchor angle of ',num2str(YOUR_THETA) ,' because switch angle is ', num2str(round(solve_para(YOUR_PARA,theta_p7),2))];    
    subtitle({text_sub,text_sub2})
end


%____________________________________________


%%%%%PREDICTION FROM 3D POLYFIT

% SAND
    load("DATA_SAND.mat")
    load("DATA_GRAVELN1.mat")
    ANGLES_S = DATA_SAND(1,:)';
    AREAS_S = DATA_SAND(2,:)';
    DATA_S =[ANGLES_S,AREAS_S]
    SAND = DATA_SAND(3,:)';
    
    figure
    stem3(ANGLES_S,AREAS_S,SAND,'o')
    title("Static Horizontal Anchoring Force on Sand")
    xlabel('Angle of anchor [°]')
    xlim([-5 45])
    ylabel('Sub Area [mm^2]')
    zlabel('Mean Force [g]')
    grid on
    
    p_sand = polyfitn(DATA_S,SAND,1)    %POLYFITN

% Gravel
    load("DATA_GRAVELN1.mat")
    ANGLES_G = DATA_GRAVELN1(1,:)';
    AREAS_G = DATA_GRAVELN1(2,:)';
    DATA_G=[ANGLES_G,AREAS_G]
    GRAVEL= DATA_GRAVELN1(3,:)';
    
    figure
    stem3(ANGLES_G,AREAS_G,GRAVEL,'o')
    title("Static Horizontal Anchoring Force on Gravel")
    xlabel('Angle of anchor [°]')
    xlim([-5 45])
    ylabel('Sub Area [mm^2]')
    zlabel('Mean Force [g]')
    grid on

    p_gravel = polyfitn(DATA_G,GRAVEL,1) %POLYFITN



    figure
    hold on
    view(3)
    % Evaluate on a grid and plot
    angle_grid_ini= 0:45;
    area_grid_ini = 0:500:4500;
    [xg,yg]=meshgrid(angle_grid_ini,area_grid_ini);
    zg_s = polyvaln(p_sand,[xg(:),yg(:)]);
    zg_g = polyvaln(p_gravel,[xg(:),yg(:)]);
    surf(xg,yg,reshape(zg_s,size(xg)),'FaceLighting','gouraud',...
    'SpecularColorReflectance',0,...
    'SpecularExponent',5,...
    'SpecularStrength',0.2,...
    'DiffuseStrength',1,...
    'AmbientStrength',0.4,...
    'AlignVertexCenters','on',...
    'LineWidth',0.2,...
    'FaceAlpha',0.2,...
    'FaceColor',[0.07 0.6 1],...
    'EdgeAlpha',0.2);

    surf(xg,yg,reshape(zg_g,size(xg)),'SpecularExponent',1,...
    'SpecularStrength',1,...
    'DiffuseStrength',1,...
    'AmbientStrength',0.4,...
    'FaceColor',[0.5 0.5 .5],...
    'AlignVertexCenters','on',...
    'LineWidth',0.2,...
    'EdgeAlpha',1)
    
    scatter3(DATA_S(:,1),DATA_S(:,2),SAND,'ro','filled')
    scatter3(DATA_G(:,1),DATA_G(:,2),GRAVEL,'bo','filled')
 
    title('Polynomial surface fit to gravel and sand datas','FontSize',15)
    xlabel('Angle of anchor [°]')
    xlim([-5 45])
    ylabel('Sub Area [mm^2]')
    zlabel('Mean Force [g]')
    grid on
    




    %%%%%%%% PREDICTION
    YOUR_ANGLE = 20
    YOUR_AREA = 3000
    YOUR_DENSITY = 1200;
    zg_s_predicted = polyvaln(p_sand,[YOUR_ANGLE,YOUR_AREA])
    zg_g_predicted = polyvaln(p_gravel,[YOUR_ANGLE,YOUR_AREA])
    h=gca;
    plot3([YOUR_ANGLE YOUR_ANGLE], [YOUR_AREA YOUR_AREA], [0 2000], 'g','LineWidth',2,'HandleVisibility','off')
    scatter3(YOUR_ANGLE,YOUR_AREA,zg_s_predicted,'g','filled','LineWidth',0.5,'HandleVisibility','off')
    scatter3(YOUR_ANGLE,YOUR_AREA,zg_g_predicted,'g','filled','LineWidth',0.5,'HandleVisibility','off')
    
    density_grav= 1282 ;%kg/m^3
    density_sand = 1005 ;


    %%% LINEAR INTERPOLATION
    YOUR_FORCE = (zg_g_predicted-zg_s_predicted)/(density_grav-density_sand).*(YOUR_DENSITY-density_sand)+zg_s_predicted;
    scatter3(YOUR_ANGLE,YOUR_AREA,YOUR_FORCE,'g','filled','LineWidth',2,'HandleVisibility','on')
    legend('POLYFIT SAND','POLYFIT GRAVEL','SAND','GRAVEL','Predicted force')
    density=500:1500;
    
    %%% PLOTTING FIRST MODEL PREDICTION
    figure
    hold on
    plot(density,(zg_g_predicted-zg_s_predicted)/(density_grav-density_sand).*(density-density_sand)+zg_s_predicted)
    plot(YOUR_DENSITY,YOUR_FORCE,'ro')
    text6=['YOUR DENSITY = ' num2str(YOUR_DENSITY)];
    xline(YOUR_DENSITY,'-r',text6,'LabelVerticalAlignment','bottom')
    text7=['YOUR FORCE = ',num2str(YOUR_FORCE)];
    yline(YOUR_FORCE,'-r',text7,'LabelHorizontalAlignment','left')
    xline(density_grav,':','Density Gravel n°1','LabelVerticalAlignment','bottom');
    xline(density_sand,':','Density Sand','LabelVerticalAlignment','bottom')
    yline(zg_s_predicted,':','Predicted Force Sand','LabelHorizontalAlignment','left')
    yline(zg_g_predicted,':','Predicted force Gravel n°1','LabelHorizontalAlignment','left')
    xlabel('Density [kg/m^3]') 
    ylabel('Rectraction force [gr]') 
    title('Rectraction force Linear Prediction, based on 2 points')



    
    %%  0.50402*X1^3 + 1.3927*X1^2*X2 - 0.017552*X1^2 + 1.3798*X1*X2^2 + 0.081473*X1*X2 + 1.2726*X1 + 0.43959*X2^3 + 0.087656*X2^2 + 1.2254*X2 + 0.96196




