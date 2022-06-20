clear all; close all; clc;

data_pure=readmatrix('data-aquarium2/LC-value-enc.csv');

data=replace_nan(data_pure);%to supress Nans
Results=[];LC=[];Mo=[];
Ad_Weight = data(:,1);
angle = data(:,2);
Modele = data(:,3);
Sub_Area = data(:,4);
Load_value = data(:,5:end);%values of load cell
Results=data(:,1:4);%[added_weight,angle,Modele,submerged Area]
Maxima_static=[];
Dis_Stat_Dyn=[];
cali_fac = 0.0793;%Calibration of used encoder
Ecart=[];

for i=1:size(data,1)
    Maxima=[];%clear
    Y=Load_value(i,:);
    [LC,Mo]=cleaning(Y,i);%TAKE OUT ZEROS, SEPARE, SUP OUTLIERS, Mo in mm

    %%CHECKING CONTINUITY OF FUNCTIONS, JUST FOR VISUALISATION
           figure ; plot(LC); title('CHECKING CONTINUITY FOR LC',num2str(i))
           figure ; plot (Mo); title('CHECKING CONTINUITY FOR Mo',num2str(i))

    [TF, P] = islocalmax(LC,'MinProminence',50);%compute the maxima based on values to only have fewer maximum
    if sum(TF)>0
        To_be_taken_out=zeros(1,size(TF,2));

        for m=1:size(TF,2)
            if LC(m) < 0.25*max(LC)
                TF(m) = 0;
            end
        end
        Maxima = LC(TF);
    end

    %LOCALISATION OF STATIC MAXIMUM, within the first 20 mm
    %Mo = movement, LC = Load Cell value
    index_min=find( LC > 50, 1);%Detection of start of plot
    Mo_min= Mo(index_min);
    Mo_max=Mo_min+25/cali_fac; %20mm * calibration factor
    index_max=find( Mo > Mo_max, 1)-1;
    LC(index_min:index_max);
    Max_static_LC=max(LC(index_min:index_max));
    Max_static_Mo=Mo(find(LC==Max_static_LC,1));

    Maxima_static=[Maxima_static ; Max_static_LC];

    Distance=max(Mo(find(LC==max(LC(TF))))-Max_static_Mo); %CALIBRATION FACTOR

    Dis_Stat_Dyn=[Dis_Stat_Dyn ; Distance];
    Ecart=[Ecart max(LC(TF))-Max_static_LC];

     %plotting values + maximum stat in green + maximum dyn in red. This
     %section (line 57 to 82) is to be put in comment while running
     %RUN_SCRIPT_LC_ENC, to avoid multiple plots appearing on screen
     figLCValue=figure;
     string1 = ['Retraction Load - Aquarium Sand n\textsuperscript{o}1'];
     %for the legend in the plot
     string2 = [' Angle = ',num2str(angle(i)),'\textsuperscript{o} , Sub Area = ',num2str(Sub_Area(i)),'mm\textsuperscript{2}'];
     string3 = ['Max Dyn value (g) : ',num2str(Maxima)];
     string4 = ['Max Stat value (g) : ',num2str(Max_static_LC)];
 
     plot(Mo*cali_fac,LC,Mo(TF)*cali_fac,LC(TF),'r*')
     hold on
     plot(Max_static_Mo*cali_fac,Max_static_LC,'g*')
     hold off
     ylabel('Weight (g)','interpreter','latex','FontSize',12);
     xlabel('Distance (mm)','interpreter','latex','FontSize',12)
     [t,s]=title(string1,{string2, string4, string3},Interpreter="latex");
     t.FontSize = 16;
     s.FontAngle = 'italic';
     if Max_static_LC==max(Maxima)%If max is the max static, then show in green the text
         s.Color = '#006321';
     end
     %Range of static within the first 20mm
     x_line=xline(Mo_min*cali_fac,'r-.',{'Range of','static'},Interpreter="latex",FontSize=12);
     x_line.LabelVerticalAlignment = 'Top';
     xline(Mo_max*cali_fac,'r-.',Interpreter="latex")
     %ylim([0 1600])

    for j=1:size(Maxima,2)%append all the computed maximas on the variable results
        Results(i,4+j)=Maxima(j);
    end

end
Ecart=max(Ecart) ;
Dis_Stat_Dyn=Dis_Stat_Dyn*cali_fac;
Results_V2= [Ad_Weight angle Modele Sub_Area max(Results(:,5:end),[],2) Maxima_static];%results + maximum of maxima
ForceH_anchor_static = (Results_V2(:,5)-Results_V2(:,1));%anchor force horizontally

