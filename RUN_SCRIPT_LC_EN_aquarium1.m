%Principal script used to load each CSV data of each anchor configuration for Sand Aquarium 1 media, by calling RUN_LC_EN function. Calls 
% plotting_box_LC_EN to plot boxplot for Sand Aquarium 1 media. Plo7_ts 3D regrouped mean anchoring force for all configurations with 
% clustering behaviour

clear all; close all; clc;

[R5_0,F5_0,E5_0,D5_0] = RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-5-0-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-5-0-a1.csv OK')
[R5_10,F5_10,E5_10,D5_10] = RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-5-10-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-5-10-a1.csv OK')
[R5_20,F5_20,E5_20,D5_20] = RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-5-20-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-5-20-a1.csv OK')
[R5_30,F5_30,E5_30,D5_30] = RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-5-30-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-5-30-a1.csv OK')
[R5_40,F5_40,E5_40,D5_40] = RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-5-40-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-5-40-a1.csv OK')

[R6_0,F6_0,E6_0,D6_0] = RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-6-0-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-6-0-a1.csv OK')
[R6_10,F6_10,E6_10,D6_10]= RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-6-10-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-6-10-a1.csv OK')
[R6_20,F6_20,E6_20,D6_20]= RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-6-20-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-6-20-a1.csv OK')
[R6_30,F6_30,E6_30,D6_30]= RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-6-30-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-6-30-a1.csv OK')
[R6_40,F6_40,E6_40,D6_40]= RUN_LC_EN(readmatrix('data-aquarium1/LC-value-enc-6-40-a1.csv'),'Sand Aquarium 1',1450);%reading matrix CSV
disp('LC-value-enc-6-40-a1.csv OK')





%%%% X-AXIS
angle=[0 10 20 30 40];
area=[ 2900 3700 ];
area_2900=[2900 2900 2900 2900 2900];
area_3700=[3700 3700 3700 3700 3700];
angle0=[0 0 0 0 0];
angle10=[10 10 10 10 10];
angle20=[20 20 20 20 20];
angle30=[30 30 30 30 30];
angle40=[40 40 40 40 40];
%%%Too big variables


%Regroup variables for plotting
F29=[F5_0 F5_10 F5_20 F5_30 F5_40];
F37=[F6_0 F6_10 F6_20 F6_30 F6_40];

F0 = [F5_0  F6_0];
F10= [F5_10 F6_10];
F20= [F5_20 F6_20];
F30= [F5_30 F6_30];
F40= [F5_40 F6_40];
 
%%%%%Distance from stat Maxima and Dyn maxima, not discussed in report
D1=[D6_0 D6_10 D6_20 D6_30 D6_40];
D2=[D5_0 D5_10 D5_20 D5_30 D5_40];


%%%%%Difference in values from stat Maxima and Dyn maxima, not discussed in report
E1=[E6_0 E6_10 E6_20 E6_30 E6_40];
E2=[E5_0 E5_10 E5_20 E5_30 E5_40];
    

%%%%%%PLOTTING BOX WITH PLOTTING_BOX_LC_EN FUNCTION,
plotting_box_LC_EN_val(F29,angle,2900,'Submerged Area : 2900mm\textsuperscript{2}','angle (\textsuperscript{o})','Aquarium Sand 1',1000)
plotting_box_LC_EN_val(F37,angle,3700,'Submerged Area : 3700mm\textsuperscript{2}','angle (\textsuperscript{o})','Aquarium Sand 1',1000)
plotting_box_LC_EN_val(F0,area,0,'angle 0\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Aquarium Sand 1',1000)
plotting_box_LC_EN_val(F10,area,10,'angle 10\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Aquarium Sand 1',1000)
plotting_box_LC_EN_val(F20,area,20,'angle 20\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Aquarium Sand 1',1000)
plotting_box_LC_EN_val(F30,area,30,'angle 30\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Aquarium Sand 1',1000)
plotting_box_LC_EN_val(F40,area,40,'angle 40\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Aquarium Sand 1',1000)

% 3D PLOT OF MEAN STATIC FORCE FOR ALL CONFIGURATIONS
figure
grid on
hold on

stem3(angle,area_2900,mean(F29));
for i=1:size(mean(F29),2)
    text(angle(i),area_2900(i), mean(F29(:,i)),num2str(round(mean(F29(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
stem3(angle,area_3700,mean(F37));
for i=1:size(mean(F37),2)
    text(angle(i),area_3700(i), mean(F37(:,i)),num2str(round(mean(F37(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end

view(3);
DATA_SAND_AQ1=[angle angle; area_2900 area_3700 ;mean(F29) mean(F37)]
save('DATA_SAND_AQ1.mat','DATA_SAND_AQ1')
title("Static Horizontal Anchoring Force on Aquarium Sand n\textsuperscript{o}1",Interpreter="latex",FontSize=15)
xlabel('Angle of anchor (\textsuperscript{o})',Interpreter="latex",FontSize=13)
xlim([-5 45])
ylim([2500 4100])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex",FontSize=13)
zlabel('Mean Force (g)',Interpreter="latex",FontSize=13)
grid on


%%%% Clustering plot
In_out=[2 2 2 0 0;2 2 1 0 0];
In_out_axis_x=[angle;angle];
In_out_axis_y=[area_2900;area_3700];


for i=find(In_out==2)
    scatter3(In_out_axis_x(i),In_out_axis_y(i),0,'ro','filled',"SizeData",100)
end
for i=find(In_out==1)
    scatter3(In_out_axis_x(i),In_out_axis_y(i),0,'yo','filled',"SizeData",100)
end
for i=find(In_out==0)
    scatter3(In_out_axis_x(i),In_out_axis_y(i),0,'go','filled',"SizeData",100)
end
legend('2500mm\textsuperscript{2}','3300mm\textsuperscript{2}','Outward diving','','','','','Stable','','Inward diving',Interpreter="latex",FontSize=12)
hold off

%%%% EVALUATION OF THE DISTANCE BETWEEN THE STATIC MAXIMA (IN THE FIRST
%%%% 25MM) AND THE DYNAMIX MAXIMA, VS ANGLE AND AREA
figure
x_axis=[angle angle angle];
y_axis=[2500 2500 2500 2500 2500 3300 3300 3300 3300 3300 4100 4100 4100 4100 4100];
z_axis=[mean(D1) mean(D2) ];
hold on
stem3(angle,area_2900,mean(D1));
for i=1:size(mean(D1),2)
    text1=[num2str(round(mean(D1(:,i)),1))];
    text(angle(i),area_2900(i), mean(D1(:,i)),text1,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

stem3(angle,area_3700,mean(D2));
for i=1:size(mean(D2),2)
    text2=[num2str(round(mean(D2(:,i)),1))];
    text(angle(i),area_3700(i), mean(D2(:,i)),text2,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end


view(3);
title("Distance between Static maximum and Dynamic Maximum on Aquarium Sand 1",Interpreter="latex",FontSize=16)
xlabel('Angle of anchor (,Interpreter="latex")',Interpreter="latex")
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex")
zlabel('Mean Distance (mm)',Interpreter="latex")
grid on


%%% EVALUATION OF THE DIFFERENCE IN VALUES BETWEEN THE STATIC MAXIMA (IN THE FIRST
%%%% 25MM) AND THE DYNAMIX MAXIMA, VS ANGLE AND AREA, , not discussed in report
figure
x_axis=[angle angle ];
y_axis=[area_2900 area_3700];
z_axis=[E1 E2];
hold on
view(3)
stem3(angle,area_2900,E1)
for i=1:size(mean(D1),2)
    text1=[num2str(round(E1(i),1))];
    text(angle(i),area_2900(i), E1(i),text1,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

stem3(angle,area_3700,E2)
for i=1:size(mean(D2),2)
    text2=[ num2str(round(E2(i),1))];
    text(angle(i),area_3700(i), E2(i),text2,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end


view(3)
title("Difference between Static maximum and Dynamic Maximum on Sand Aquarium 1",Interpreter="latex",FontSize=16)
xlabel('Angle of anchor (\textsuperscript{o})',Interpreter="latex")
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex")
zlabel('Mean Difference (g)',Interpreter="latex")
grid on

%%% Variances analysis
fprintf('Standard deivation is %0.2f \n', mean([std(F29) std(F37) ]))




