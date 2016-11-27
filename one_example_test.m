clc;
clear;
close all;
% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
i = 30;
I = ISBI_Train{i, 1};

% I = imread('EDF0_7/EDF001.png');
figure, imshow(I);

% figure, imshow(I);
outimage = nuclei_segmentation(I, 0, 0.25, 0.25);
Dice = DiceSimilarity(outimage, train_Nuclei{i,1});
figure, imshow(outimage);



% out_reshape = reshape(outimage, [512*512, 1]);
% gt_reshape = reshape(train_Nuclei{30,1}, [512*512, 1]);
% [h,p,ci,stats] = ttest(out_reshape, gt_reshape);

% cc = bwconncomp(outimage{30,1},4);
% array = getfield(cc, 'PixelIdxList');
% length = getfield(cc, 'NumObjects');
% sizes = zeros(1,length);
% for i = 1:length
%     size_of_ele = size(array{1,i});
%     
%     sizes(i) = size_of_ele(1);
% end
% 
% sizes = sort(sizes);
% 
% OUT_LIAER_TH = 0.05;
% low_th = sizes(ceil(length*OUT_LIAER_TH));
% high_th = sizes(ceil(length*(1-OUT_LIAER_TH)));



    