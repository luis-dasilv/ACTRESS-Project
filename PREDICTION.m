function [YOUR_FORCE,YOUR_THETA_SWITCH] = PREDICTION(YOUR_AREA,YOUR_ANGLE,YOUR_GRAIN)
%%%SIMPLE PREDICTION FUNCTION, ALTERNATE VERSION OF PREDICTION_RETRACTION FUNCTION
%FIRST MODEL PREDICTION
%WHERE IS THE SWITCH ANGLE FOR YOUR MEDIA :
GRAIN_grav= 2;%mm
GRAIN_sand = 0;
Theta_switch_grav = 40+90;
Theta_switch_sand = 25+90;

YOUR_THETA_SWITCH = (Theta_switch_grav-Theta_switch_sand)/(GRAIN_grav-GRAIN_sand).*(YOUR_GRAIN-GRAIN_sand)+Theta_switch_sand;

% SAND
load("DATA_SAND.mat");
ANGLES_S = DATA_SAND(1,:)';
AREAS_S = DATA_SAND(2,:)';
DATA_S =[ANGLES_S,AREAS_S];
SAND = DATA_SAND(3,:)';
p_sand = polyfitn(DATA_S,SAND,1);    %POLYFITN

% Gravel
load("DATA_GRAVELN1.mat");
ANGLES_G = DATA_GRAVELN1(1,:)';
AREAS_G = DATA_GRAVELN1(2,:)';
DATA_G=[ANGLES_G,AREAS_G];
GRAVEL= DATA_GRAVELN1(3,:)';
p_gravel = polyfitn(DATA_G,GRAVEL,1);

%%%%%%%% PREDICTION
zg_s_predicted = polyvaln(p_sand,[YOUR_ANGLE,YOUR_AREA]);
zg_g_predicted = polyvaln(p_gravel,[YOUR_ANGLE,YOUR_AREA]);

%%% LINEAR INTERPOLATION
YOUR_FORCE = (zg_g_predicted-zg_s_predicted)/(GRAIN_grav-GRAIN_sand).*(YOUR_GRAIN-GRAIN_sand)+zg_s_predicted;


end