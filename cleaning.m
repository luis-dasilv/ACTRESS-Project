function [LC,Mo] = cleaning(Y,i)
%%%%Cleaning and separation of vector Y, in Load Cell value and encoder value.
%%%%Suppession of outliers. 

%ERASE ZEROS AT THE END of csv, because tests were of different lengths
sizeO=size(Y,2);
for j=flip(1:size(Y,2))
    if Y(j)==0
        Y(j)=[];
    else
        a=sizeO-j;
        break
    end
end

%%%% SEPARE TIME AND MOTION COMPONENT
LC=[];Mo=[];
for s1=1:floor(size(Y,2)/2)
    LC=[LC Y(:,2*s1-1)];
    Mo=[Mo Y(:,2*s1)];
    %Mo=0.0793.*Mo;

end
%fprintf('LC and Mo components separed \n')

%%% SUPPRESS OUTLIERS
TF2 = isoutlier(LC,'mean');
LC=LC(~TF2);
Mo=Mo(~TF2);
TF3 = isoutlier(Mo,'mean');
LC=LC(~TF3);
Mo=Mo(~TF3);

end