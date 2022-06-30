%Principal script used to load each CSV data of each anchor configuration for Sand Aquaquarium1arium 1 media, by calling RUN_LC_EN function. Calls 
% plotting_box_LC_EN to plot boxplot for Sand Aquarium 2 media. Plo7_ts 3D regrouped mean anchoring force for all configurations with 
% clustering behaviour

clear all; close all; clc;

[R5_0,F5_0,E5_0,D5_0] = RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-5-0-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-5-0-a2.csv OK')
[R5_10,F5_10,E5_10,D5_10] = RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-5-10-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-5-10-a2.csv OK')
[R5_20,F5_20,E5_20,D5_20] = RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-5-20-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-5-20-a2.csv OK')
[R5_30,F5_30,E5_30,D5_30] = RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-5-30-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-5-30-a2.csv OK')
[R5_40,F5_40,E5_40,D5_40] = RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-5-40-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-5-40-a2.csv OK')
[R6_0,F6_0,E6_0,D6_0] = RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-6-0-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-6-0-a2.csv OK')
[R6_10,F6_10,E6_10,D6_10]= RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-6-10-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-6-10-a2.csv OK')
[R6_20,F6_20,E6_20,D6_20]= RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-6-20-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-6-20-a2.csv OK')
[R6_30,F6_30,E6_30,D6_30]= RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-6-30-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-6-30-a2.csv OK')
[R6_40,F6_40,E6_40,D6_40]= RUN_LC_EN(readmatrix('data-aquarium2/LC-value-enc-6-40-a2.csv'),'Sand Aquarium 2',1250);%reading matrix CSV
disp('LC-value-enc-6-40-a2.csv OK')





%%%% X-AXIS
angle=[0 10 20 30 40];
area=[ 2900 3700 ];
area_2900=[2900 2900 2900 2900 2900];
area_3700=[3700 3700 3700 3700 3700];


%%%Too big variables


%Regroup variables for plotting
F1=[F5_0 F5_10 F5_20 F5_30 F5_40];
F2=[F6_0 F6_10 F6_20 F6_30 F6_40];



F0 = [F5_0  F6_0 ];
F10= [F5_10 F6_10  ];
F20= [F5_20 F6_20  ];
F30= [F5_30 F6_30  ];
F40= [F5_40 F6_40  ];

%%%%%Distance from stat Maxima and Dyn maxima, not discussed in report
D1=[D6_0 D6_10 D6_20 D6_30 D6_40];
D2=[D5_0 D5_10 D5_20 D5_30 D5_40];


%%%%%Difference in values from stat Maxima and Dyn maxima, not discussed in report
E1=[E6_0 E6_10 E6_20 E6_30 E6_40];
E2=[E5_0 E5_10 E5_20 E5_30 E5_40];


%%%%%%PLOTTING BOX WITH PLOTTING_BOX_LC_EN FUNCTION,
plotting_box_LC_EN_val(F1,angle,'Submerged Area : 2900mm\textsuperscript{2}','angle (\textsuperscript{o})','Sand Aquarium 2',800)
plotting_box_LC_EN_val(F2,angle,'Submerged Area : 3700mm\textsuperscript{2}','angle (\textsuperscript{o})','Sand Aquarium 2',800)
plotting_box_LC_EN_val(F0,area,'angle 0\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Sand Aquarium 2',800)
plotting_box_LC_EN_val(F10,area,'angle 10\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Sand Aquarium 2',800)
plotting_box_LC_EN_val(F20,area,'angle 20\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Sand Aquarium 2',800)
plotting_box_LC_EN_val(F30,area,'angle 30\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Sand Aquarium 2',800)
plotting_box_LC_EN_val(F40,area,'angle 40\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Sand Aquarium 2',800)

%3D PLOT OF MEAN STATIC FORCE FOR ALL CONFIGURATIONS
figure
hold on
grid on
stem3(angle,area_2900,mean(F1));
for i=1:size(mean(F1),2)
    text(angle(i),area_2900(i), mean(F1(:,i)),num2str(round(mean(F1(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
stem3(angle,area_3700,mean(F2));
for i=1:size(mean(F2),2)
    text(angle(i),area_3700(i), mean(F2(:,i)),num2str(round(mean(F2(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end

view(3);
DATA_SAND_AQ2=[angle angle; area_2900 area_3700 ;mean(F1) mean(F2)]
save('DATA_SAND_AQ2.mat','DATA_SAND_AQ2')
title("Static Horizontal Anchoring Force on Sand Aquarium n\textsuperscript{o}2",Interpreter="latex",FontSize=15)
xlabel('Angle of anchor (\textsuperscript{o})',Interpreter="latex",FontSize=13)
xlim([-5 45])
ylim([2500 4100])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex",FontSize=13)
zlabel('Mean Force (g)',Interpreter="latex",FontSize=13)
grid on


%%%% Clustering plot
In_out=[2 2 2 0 0;2 2 2 1 0];
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
title("Distance between Static maximum and Dynamic Maximum on Sand Aquarium 2",Interpreter="latex",FontSize=16)
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
grid on
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
title("Difference between Static maximum and Dynamic Maximum on Sand Aquarium 2",Interpreter="latex",FontSize=16)
xlabel('Angle of anchor (\textsuperscript{o})',Interpreter="latex")
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex")
zlabel('Mean Difference (g)',Interpreter="latex")
grid on


%ANALYSIS
F=[mean(F0,1)' mean(F10,1)' mean(F20,1)' mean(F30,1)' mean(F40,1)' ]

dif_per_area(1,:) = (F(2,:)-F(1,:))./F(1,:).*100;


mean(dif_per_area,2)

dif_per_angle(:,1) = (F(:,2)-F(:,1))./F(:,1).*100;
dif_per_angle(:,2) = (F(:,3)-F(:,2))./F(:,2).*100;
dif_per_angle(:,3) = (F(:,4)-F(:,3))./F(:,3).*100;
dif_per_angle(:,4) = (F(:,5)-F(:,4))./F(:,4).*100

mean(dif_per_angle)

%%% Variances analysis
fprintf('Standard deviation is %0.2f \n', mean([std(F1) std(F2) ]))


