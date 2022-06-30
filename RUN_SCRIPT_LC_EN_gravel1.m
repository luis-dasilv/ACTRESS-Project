%Principal script used to load each CSV data of each anchor configuration for grvael n°1 media, by calling RUN_LC_EN function. Calls 
% plotting_box_LC_EN to plot boxplot for gravel n°1 media. Plots 3D regrouped mean anchoring force for all configurations with 
% clustering behaviour

clear all; close all; clc;

[R1_0,F1_0,E1_0,D1_0] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-1-0-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-1-0.csv OK')
[R1_10,F1_10,E1_10,D1_10]= RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-1-10-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-1-10.csv OK')
[R1_20,F1_20,E1_20,D1_20]= RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-1-20-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-1-20.csv OK')
[R1_30,F1_30,E1_30,D1_30]= RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-1-30-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-1-30.csv OK')
[R1_40,F1_40,E1_40,D1_40]= RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-1-40-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-1-40.csv OK')
[R2_0,F2_0,E2_0,D2_0] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-2-0-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-2-0.csv OK')
[R2_10,F2_10,E2_10,D2_10] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-2-10-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-2-10.csv OK')
[R2_20,F2_20,E2_20,D2_20] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-2-20-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-2-20.csv OK')
[R2_30,F2_30,E2_30,D2_30] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-2-30-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-2-30.csv OK')
[R2_40,F2_40,E2_40,D2_40] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-2-40-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-2-40.csv OK')
[R3_0,F3_0,E3_0,D3_0] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-3-0-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-3-0.csv OK')
[R3_10,F3_10,E3_10,D3_10] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-3-10-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-3-10.csv OK')
[R3_20,F3_20,E3_20,D3_20] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-3-20-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-3-20.csv OK')
[R3_30,F3_30,E3_30,D3_30] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-3-30-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-3-30.csv OK')
[R3_40,F3_40,E3_40,D3_40] = RUN_LC_EN(readmatrix('data-gravel1/LC-value-enc-3-40-g1.csv'),'Gravel n\textsuperscript{o}1',1700);%reading matrix CSV
disp('LC-value-enc-3-40.csv OK')



%%%% X-AXIS
angle=[0 10 20 30 40];
area=[ 2500 3300 4100];
area_2500=[2500 2500 2500 2500 2500];
area_3300=[3300 3300 3300 3300 3300];
area_4100=[4100 4100 4100 4100 4100];

%%%Too big variables
F1_0(5)=[];
F1_10(5)=[];
D1_0(5)=[];
D1_10(5)=[];


%Regroup variables for plotting
F1=[F1_0 F1_10 F1_20 F1_30 F1_40];
F2=[F2_0 F2_10 F2_20 F2_30 F2_40];
F3=[F3_0 F3_10 F3_20 F3_30 F3_40];

F1_p=F1/2500;
F2_p=F2/3300;
F3_p=F3/4100;


F0 = [F1_0 F2_0 F3_0];
F10=[F1_10 F2_10 F3_10];
F20=[F1_20 F2_20 F3_20];
F30=[F1_30 F2_30 F3_30];
F40=[F1_40 F2_40 F3_40];

%%%%%Distance from stat Maxima and Dyn maxima, not discussed in report
D1=[D1_0 D1_10 D1_20 D1_30 D1_40];
D2=[D2_0 D2_10 D2_20 D2_30 D2_40];
D3=[D3_0 D3_10 D3_20 D3_30 D3_40];

%%%%%Difference in values from stat Maxima and Dyn maxima, not discussed in report
E1=[E1_0 E1_10 E1_20 E1_30 E1_40];
E2=[E2_0 E2_10 E2_20 E2_30 E2_40];
E3=[E3_0 E3_10 E3_20 E3_30 E3_40];

%%%%%%PLOTTING BOX WITH PLOTTING_BOX_LC_EN FUNCTION,
plotting_box_LC_EN(F1,angle,'Submerged Area : 2500mm\textsuperscript{2}','angle (\textsuperscript{o})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F2,angle,'Submerged Area : 3300mm\textsuperscript{2}','angle (\textsuperscript{o})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F3,angle,'Submerged Area : 4100mm\textsuperscript{2}','angle (\textsuperscript{o})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F0,area,'angle 0\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F10,area,'angle 10\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F20,area,'angle 20\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F30,area,'angle 30\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Gravel n\textsuperscript{o}1',1100)
plotting_box_LC_EN(F40,area,'angle 40\textsuperscript{o}', 'Submerged Area (mm\textsuperscript{2})','Gravel n\textsuperscript{o}1',1100)

% 3D PLOT OF MEAN STATIC FORCE FOR ALL CONFIGURATIONS
figure()
hold on
stem3(angle,area_2500,mean(F1));
for i=1:size(mean(F1),2)
    text(angle(i),area_2500(i), mean(F1(:,i)),num2str(round(mean(F1(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
stem3(angle,area_3300,mean(F2));
for i=1:size(mean(F2),2)
    text(angle(i),area_3300(i), mean(F2(:,i)),num2str(round(mean(F2(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
stem3(angle,area_4100,mean(F3));
for i=1:size(mean(F2),2)
    text(angle(i),area_4100(i), mean(F3(:,i)),num2str(round(mean(F3(:,i)),0)),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
view(3);
DATA_GRAVELN1=[angle angle angle; area_2500 area_3300 area_4100;mean(F1) mean(F2) mean(F3)]
save('DATA_GRAVELN1.mat','DATA_GRAVELN1')
title("Static Horizontal Anchoring Force on Gravel n\textsuperscript{o}1",Interpreter="latex",FontSize=18)
xlabel('Anchor angle (\textsuperscript{o})',Interpreter="latex",FontSize=14) 
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex",FontSize=14)
zlabel('Mean Force (g)',Interpreter="latex",FontSize=14)
grid on


%%%% Clustering plot
In_out=[2 2 2 2 1;2 2 2 2 1;2 2 2 1 1];
In_out_axis_x=[angle;angle;angle];
In_out_axis_y=[area_2500;area_3300;area_4100];

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


% 3D PLOT OF MEAN STATIC FORCE FOR ALL CONFIGURATIONS PRESSSSSSSURE
figure()
hold on
stem3(angle,area_2500,mean(F1_p));
for i=1:size(mean(F1_p),2)
    text(angle(i),area_2500(i), mean(F1_p(:,i)),num2str(round(mean(F1_p(:,i)*1000),0)/1000),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
stem3(angle,area_3300,mean(F2_p));
for i=1:size(mean(F2_p),2)
    text(angle(i),area_3300(i), mean(F2_p(:,i)),num2str(round(mean(F2_p(:,i)*1000),0)/1000),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
stem3(angle,area_4100,mean(F3_p));
for i=1:size(mean(F2_p),2)
    text(angle(i),area_4100(i), mean(F3_p(:,i)),num2str(round(mean(F3_p(:,i)*1000),0)/1000),'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex",FontSize=12);
end
view(3);
DATA_GRAVELN1_P=[angle angle angle; area_2500 area_3300 area_4100;mean(F1_p) mean(F2_p) mean(F3_p)]
save('DATA_GRAVELN1_p.mat','DATA_GRAVELN1_P')
title("Static Horizontal Anchoring Pressure on Gravel n\textsuperscript{o}1",Interpreter="latex",FontSize=18)
xlabel('Anchor angle (\textsuperscript{o})',Interpreter="latex",FontSize=14) 
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex",FontSize=14)
zlabel('Mean Pressure (gf/mm\textsuperscript{2})',Interpreter="latex",FontSize=14)
grid on


%%%% Clustering plot PRESSSSSSSURE
;

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
z_axis=[mean(D1) mean(D2) mean(D3)];
hold on
stem3(angle,area_2500,mean(D1));
for i=1:size(mean(D1),2)
    text1=[num2str(round(mean(D1(:,i)),1))];
    text(angle(i),area_2500(i), mean(D1(:,i)),text1,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

stem3(angle,area_3300,mean(D2));
for i=1:size(mean(D2),2)
    text2=[num2str(round(mean(D2(:,i)),1))];
    text(angle(i),area_3300(i), mean(D2(:,i)),text2,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

stem3(angle,area_4100,mean(D3));
for i=1:size(mean(D2),2)
    text3=[num2str(round(mean(D3(:,i)),1))];
    text(angle(i),area_4100(i), mean(D3(:,i)),text3,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

view(3);
title("Distance between Static maximum and Dynamic Maximum on Gravel n\textsuperscript{o}1",Interpreter="latex",FontSize=16)
xlabel('Anchor angle (,Interpreter="latex")',Interpreter="latex")
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex")
zlabel('Mean Distance (mm)',Interpreter="latex")
grid on



%%% EVALUATION OF THE DIFFERENCE IN VALUES BETWEEN THE STATIC MAXIMA (IN THE FIRST
%%%% 25MM) AND THE DYNAMIX MAXIMA, VS ANGLE AND AREA, , not discussed in report
figure
x_axis=[angle angle angle];
y_axis=[area_2500 area_3300 area_4100];
z_axis=[E1 E2 E3];
hold on
view(3)
stem3(angle,area_2500,E1)
for i=1:size(mean(D1),2)
    text1=[num2str(round(E1(i),1))];
    text(angle(i),area_2500(i), E1(i),text1,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

stem3(angle,area_3300,E2)
for i=1:size(mean(D2),2)
    text2=[ num2str(round(E2(i),1))];
    text(angle(i),area_3300(i), E2(i),text2,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end

stem3(angle,area_4100,E3)
for i=1:size(mean(D3),2)
    text3=[num2str(round(E3(i),1))];
    text(angle(i),area_4100(i), E3(i),text3,'HorizontalAlignment','center','VerticalAlignment','bottom',Interpreter="latex");
end
view(3)
title("Difference between Static maximum and Dynamic Maximum on gravel n\textsuperscript{o}1",Interpreter="latex",FontSize=16)
xlabel('Anchor angle (\textsuperscript{o})',Interpreter="latex")
xlim([-5 45])
ylabel('Sub Area (mm\textsuperscript{2})',Interpreter="latex")
zlabel('Mean Difference (g)',Interpreter="latex")
grid on



%ANALYSIS
F=[mean(F0,1)' mean(F10,1)' mean(F20,1)' mean(F30,1)' mean(F40,1)' ]

dif_per_area(1,:) = (F(2,:)-F(1,:))./F(1,:).*100;
dif_per_area(2,:) = (F(3,:)-F(2,:))./F(2,:).*100

mean(dif_per_area,2)


F_p=[mean(F1_p)' mean(F2_p)' mean(F3_p)'] 
dif_per_area_p(:,1) = (F_p(:,2)-F_p(:,1))./F_p(:,1).*100;
dif_per_area_p(:,2) = (F_p(:,3)-F_p(:,2))./F_p(:,2).*100;

mean(dif_per_area_p,1)

dif_per_angle(:,1) = (F(:,2)-F(:,1))./F(:,1).*100;
dif_per_angle(:,2) = (F(:,3)-F(:,2))./F(:,2).*100;
dif_per_angle(:,3) = (F(:,4)-F(:,3))./F(:,3).*100;
dif_per_angle(:,4) = (F(:,5)-F(:,4))./F(:,4).*100

mean(dif_per_angle)

%%% Variances analysis
mean([std(F1) std(F2) std(F3)])
fprintf('Standard deivation is %0.2f \n', mean([std(F1) std(F2) std(F3)]))

F_p
mean(F_p,1)
S = std(F_p,0,1)



