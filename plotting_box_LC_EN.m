function plotting_box(F,I,text,texty,title1,maxy)
%%%% Plotting multiple boxplot in one plot, with help of boxplot matlab
%%%% Package https://ch.mathworks.com/matlabcentral/fileexchange/51134-boxplot

string1 = ['Static Horizontal Anchoring Force'];%(FOR AQ1 and AQ2)
%string1 = ['Static Horizontal Anchoring Force - ',title1]; %For other media
string2 = [title1,' - ', text];%for the legend in the plot (FOR AQ1 and AQ2)
%string2 = [text];%for the legend in the plot %For other %media
string3 = ['Mean value (g): ',num2str(round(mean(F,1),0))];
figure
boxplot(F,I)
[t,s]=title(string1, {string2, string3},Interpreter="latex");
set(gca,"FontSize",14)
title(string1,FontSize = 19)
s.FontSize = 16;
s.FontAngle = 'italic';
xlabel(texty,'FontSize',16,Interpreter="latex")
ylabel('Weight (g)','FontSize',16,Interpreter="latex"); 
set(gca, 'YGrid', 'on', 'XGrid', 'off')
hold on
plot(mean(F,1),'-d','MarkerSize', 9,'LineWidth',2)
ylim([0 maxy])
legend("Mean Load",'Location','southeast',Interpreter="latex",FontSize = 16)
hold off,