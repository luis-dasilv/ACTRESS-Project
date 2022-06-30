%Principal script used to load each CSV data of each slope angle by calling
%Experiments_angle_RUN function. Print maximum tether tension for each
%ascent/Descent procedure, for both mechanism on several angles (20 to 50).

clear all; close all; clc;

[R1_20,F1_20]= Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-1-20.csv'));disp('LC-value-1-20.csv OK')%reading matrix CSV

[R1_30,F1_30]= Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-1-30.csv'));disp('LC-value-1-30.csv OK')%reading matrix CSV

[R1_40,F1_40]= Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-1-40.csv'));disp('LC-value-1-40.csv OK')%reading matrix CSV

[R1_50,F1_0]= Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-1-50.csv'));disp('LC-value-1-50.csv OK')%reading matrix CSV

[R2_20,F2_20] = Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-2-20.csv'));disp('LC-value-2-20.csv OK')%reading matrix CSV

[R2_30,F2_30] = Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-2-30.csv'));disp('LC-value-2-30.csv OK')%reading matrix CSV

[R2_40,F2_40] = Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-2-40.csv'));disp('LC-value-2-40.csv OK')%reading matrix CSV

[R2_50,F2_50] = Experiments_angle_RUN(readmatrix('Evaluation experiments/LC-value-2-50.csv'));disp('LC-value-2-50.csv OK')%reading matrix CSV


R1=[R1_20; R1_30; R1_40; R1_50]
R2=[R2_20; R2_30; R2_40; R2_50]

R1_A=[];
R1_D=[];
R2_A=[];
R2_D=[];

M_R1_A=[];
M_R1_D=[];
M_R2_A=[];
M_R2_D=[];

for i = 1:40
    if R1(i,2)==1
        R1_A=[R1_A;R1(i,:)];
    end
    if R1(i,2)==2
        R1_D=[R1_D;R1(i,:)];
    end
    if R2(i,2)==1
        R2_A=[R2_A;R2(i,:)];
    end
    if R2(i,2)==2
        R2_D=[R2_D;R2(i,:)];
    end
end

for i = 0:3
     M_R1_A=[M_R1_A ;mean(R1_A((1:5)+5*i,:))]
     M_R1_D=[M_R1_D ;mean(R1_D((1:5)+5*i,:))]
     M_R2_A=[M_R2_A ;mean(R2_A((1:5)+5*i,:))]
     M_R2_D=[M_R2_D ;mean(R2_D((1:5)+5*i,:))]
end

R1_A
R1_D
R2_A
R2_D
M_R1_A
M_R1_D
M_R2_A
M_R2_D

figure 
hold on 
plot(M_R1_A(:,3),M_R1_A(:,5),'-o')
plot(M_R1_D(:,3),M_R1_D(:,5),'-o')
plot(M_R2_A(:,3),M_R2_A(:,5),'-o')
plot(M_R2_D(:,3),M_R2_D(:,5),'-o')
angle=(200:600)./10;
plot(angle,sin(angle*pi/180)*840)

title("Tether tension in inspection of robot functions",FontSize=18,Interpreter="latex")
ylabel('Tether tension (g)',FontSize=14,Interpreter="latex")
xlim([19 51])
xlabel('Slope angle (\textsuperscript{o})',FontSize=14,Interpreter="latex")
legend('Area reducing - Rappelling up','Area reducing - Rappelling down','Angle changing - Rappelling up','Angle changing - Rappelling down','Expected tether tension (no friction, no inertia)',Interpreter="latex",FontSize=12)

grid on
