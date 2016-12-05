clc;
clear;
close all;

load('isbi_train.mat');
load('isbi_train_GT.mat');
load('isbi_test90.mat')
load('isbi_test90_GT.mat')
% I = imread('EDF000.png');
% figure, imshow(I);

% size_of_dataset = size(train_Nuclei);
size_of_dataset = size(test_Nuclei);

size_of_dataset = size_of_dataset(1);
outimage=cell(size_of_dataset,1);

Dice_pixel_result = [];
Precision_pixel_result = [];
Recall_pixel_result = [];

Dice_object_result = [];
Precision_object_result = [];
Recall_object_result = [];

for i=1:size_of_dataset
%     I = ISBI_Train{i, 1};
    I = ISBI_Test90{i, 1};

%     out = nuclei_segmentation(I, 10000, 0.25, 0, 2);
    out = baseline2(I);
    outimage{i, 1} = out;
    [Dice_pixel, Precision_pixel, Recall_pixel, Dice_object, Precision_object, Recall_object ]...
        = Evaluation( out, test_Nuclei{i,1});
    Dice_pixel_result = [Dice_pixel_result Dice_pixel];
    Precision_pixel_result = [Precision_pixel_result Precision_pixel];
    Recall_pixel_result = [Recall_pixel_result Recall_pixel];
    
    Dice_object_result = [Dice_object_result Dice_object];
    Precision_object_result = [Precision_object_result Precision_object];
    Recall_object_result = [Recall_object_result Recall_object];
    
end

mean_Dice_pixel = mean(Dice_pixel_result);
mean_Precision_pixel = mean(Precision_pixel_result);
mean_Recall_pixel = mean(Recall_pixel_result);

mean_Dice_object = mean(Dice_object_result);
mean_Precision_object = mean(Precision_object_result);
mean_Recall_object = mean(Recall_object_result);