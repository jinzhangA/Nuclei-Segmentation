clc;
clear;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
% I = imread('EDF000.png');
% figure, imshow(I);

I = ISBI_Train{5, 1};
I_1 = imhmin(I,40);

I_2 = imhmin(I,100);
I_subs =  I_2 - I_1;

I_ce = I - I_subs;
% imshow(I_ce);

se = strel('disk',3);
I_open = imopen(I,se);
H = imhmin(I_open,30);
Cnp = I_ce+H;
% figure, imshow(Cnp);


Cnp_ce = imadjust(Cnp);
% figure, imshow(Cnp_ce);
Cnp_ce_inverse = 255 - Cnp_ce;
M_d = imdilate(Cnp_ce_inverse,se);
% figure, imshow(M_d);

level = graythresh(M_d);
BW = im2bw(M_d,level);
% figure, imshow(BW);

small_removed = bwareaopen(BW, 80);
% figure, imshow(small_removed);

large_kept = bwareaopen(small_removed, 600);

cleaned = small_removed-large_kept;
% cleaned = small_removed;
figure, imshow(cleaned);
save('testout','cleaned');
GT=train_Nuclei{5, 1};
save('GT', 'GT');




