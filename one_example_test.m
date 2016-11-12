clc;
clear;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
I = imread('EDF000.png');
figure, imshow(I);

% I = ISBI_Train{20, 1};
% figure, imshow(I);
outimage{30,1} = nuclei_segmentation(I);