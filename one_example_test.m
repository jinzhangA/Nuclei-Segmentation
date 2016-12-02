clc;
clear;
close all;
% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
i = 23;
I = ISBI_Train{i, 1};

I = imread('EDF0_7/EDF003.png');
figure, imshow(I);
GT = train_Nuclei{i,1};
% figure, imshow(I);
outimage = nuclei_segmentation(I, 10000, 0.3, 0.25);
% [Dice_pixel, Precision_pixel, Recall_pixel, Dice_object, Precision_object, Recall_object] ...
%     = Evaluation( outimage, GT);
figure, imshow(outimage);
% figure, imshow(GT);



    