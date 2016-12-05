clc;
clear;
close all;
% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
% i = 31;
i = 31;

I = ISBI_Train{i, 1};

base = baseline_segmentation(I);
figure, imshow(base);
title('base')

figure, imshow(I);
GT = train_Nuclei{i,1};
figure, imshow(I);
outimage = nuclei_segmentation(I, 10000, 0.25, 0, 2);
[Dice_pixel, Precision_pixel, Recall_pixel, Dice_object, Precision_object, Recall_object_base] ...
    = Evaluation( outimage, GT);
[Dice_pixel_base, Precision_pixel_base, Recall_pixel_base, Dice_object_base, Precision_object_base, Recall_object] ...
    = Evaluation( base, GT);
figure, imshow(outimage);
figure, imshow(GT);



    