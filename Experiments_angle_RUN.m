function [Results_V2, F_max] = Experiments_angle_RUN(data_pure)
%Run script for Load Cell recordings, during the slopes evaluation of the robots.
%Before loading CSV files, make sure no text is written inside, only
%numbers, prefill manually the Modele (=1 for reducing area mechanism, =2
%for angle changing mechanism), the behaviour (=1 for ascent, =2 for
%descent), how did the anchor react (=1 stayed embedded, =2 disembeds) and
%the anfle of the slope done by the table. [Modele, Behaviour, anchor,
%angle] 
%Make sure to clean afterwards the data after visualisation, to get an clean curve.

data=replace_nan(data_pure);%to supress Nans
Results=[];LC=[];Mo=[];
Modele = data(:,1);
Behaviour = data(:,2);
Anchor = data(:,3);
Angle = data(:,4);
Load_value = data(:,5:end);%values of load cell
Results=data(:,1:4);%[Modele, Behaviour, anchor,angle] 
Maxima_all = [];
for i=1:size(data,1)
    Maxima=[];%clear
    Y=Load_value(i,:);
        %%% SUPPRESS OUTLIERS
        TF2 = isoutlier(Y,'mean');
        Y=Y(~TF2);
    [TF, P] = islocalmax(Y,'MinProminence',50);%compute the maxima based on values to only have fewer maximum
    Maxima=max(Y(TF));
    X_Maxima=find(Y==Maxima);
    %LOCALISATION OF Maximum force
    % This section (line 31 to 70) is to be put in comment while running RUN_SCRIPT_LC_ENC, to avoid multiple plots appearing on screen
      figLCValue=figure;
      hold on
      if Modele(i)==1
            string1 = ['Tether tension - Reducing area mechanism'];
      end 
      if Modele(i)==2
            string1 = ['Tether tension - Angle changing mechanism'];
      end

      if Behaviour(i)==1
        string2 = [' Ascent on slope angle = ',num2str(Angle(i)),'\textsuperscript{o}'];
      end 
      if Behaviour(i)==2
        string2 = [' Descent on slope angle = ',num2str(Angle(i)),'\textsuperscript{o}'];
      end 

      string3 = ['Max Tether tension (g) : ',num2str(round(Maxima,0))];

      if Anchor(i)==1
        string4 = ['Embedded during the operation' ];
      end
       if Anchor(i)==2
        string4 = ['Disembedded during the operation'];
      end
   
      plot(Y)
      plot(X_Maxima,Maxima,'r*')
      hold off
      ylabel('Tether tension (g)','interpreter','latex','FontSize',14);
      [t,s]=title(string1,{string2, string3, string4},Interpreter="latex");
      t.FontSize = 20;
      s.FontSize = 12;
      t.FontWeight = 'bold';
      s.FontAngle = 'italic';
      set(gca, 'YGrid', 'on', 'XGrid', 'off')
      %Range of static within the first 20mm
      x_line=xline(X_Maxima,'r-.',{'Maximum','tether tension'},Interpreter="latex",FontSize=12);
      x_line.LabelVerticalAlignment = 'bottom';
      x_line.LabelHorizontalAlignment = 'center';
      set(gca,'xtick',[])

Maxima_all=[Maxima_all Maxima];

end
F_max = Maxima_all;
Results_V2= [Modele Behaviour Angle Anchor F_max'];%results + maximum of maxima

end