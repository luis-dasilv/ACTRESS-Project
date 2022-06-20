%%%%%%%%%%% CALIBRATION 
clc; close all; clear all;
data_pure=readmatrix('data/LC-value-enc.csv');
data=replace_nan(data_pure);
Results=[];LC=[];Mo=[];
Ad_Weight = data(:,1);
angle = data(:,2);
Modele = data(:,3);
Sub_Area = data(:,4);
Load_value = data(:,5:end);
calibration_factor=[];

for i=1:size(data,1)
    Y=Load_value(i,:);
    [LC,Mo]=cleaning(Y,i);
    Mo
    max(Mo)
    min(Mo)
    plot(Mo)
    calibration_factor=[calibration_factor 284/(max(Mo)-min(Mo))]
    
end