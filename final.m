clc;
clear;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
% I = imread('EDF000.png');
% figure, imshow(I);
% 

size_of_dataset = size(train_Nuclei);
size_of_dataset = size_of_dataset(1);
outimage=cell(size_of_dataset,1);
for i=1:size_of_dataset
    I = ISBI_Train{i, 1};
    outimage{i,1} = nuclei_segmentation(I);
end



[meanDice70, ...
meanFNR70_object, ...
meanTPR70_pixel, ...
meanFPR70_pixel, ...
stdDice70, ...
stdTPR70_pixel, ...
stdFPR70_pixel, ...
stdFNo_70] ...
    = evaluateCytoSegmentation({train_Nuclei},{outimage});
    