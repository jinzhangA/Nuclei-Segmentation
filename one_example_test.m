clc;
clear;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
% I = imread('EDF0_7/EDF001.png');
% % figure, imshow(I);

I = ISBI_Train{30, 1};
% figure, imshow(I);
outimage = nuclei_segmentation(I);
Dice = DiceSimilarity(outimage, train_Nuclei{30,1});

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



    