function [data_tmp] = replace_nan(data_tmp)
for i=1:size(data_tmp,1)
    for j=1:size(data_tmp,2)
        if isnan(data_tmp(i,j))==1
            data_tmp(i,j)=0;
        end
    end
end
