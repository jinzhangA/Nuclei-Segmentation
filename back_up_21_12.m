function  out_image  = nuclei_segmentation( in_image, is_large, OUT_LIAER_TH_LOW, OUT_LIAER_TH_HIGH)

%% Preprocessing
I = in_image;
I_1 = imhmin(I,40);

I_2 = imhmin(I,60);
I_subs =  I_2 - I_1;

I_ce = I - I_subs;
% imshow(I_ce);

se = strel('disk',1);
I_open = imopen(I,se);
H = imhmin(I_open, 20);
Cnp = I_ce+H;
figure, imshow(Cnp);

Cnp = imadjust(Cnp);
% figure, imshow(Cnp_ce);
Cnp_inverse = 255 - Cnp;
M_d = imdilate(Cnp_inverse,se);

% figure, imshow(M_d);

level = graythresh(M_d);
BW_1 = im2bw(M_d,level);

cc = bwconncomp(BW_1,4);
length = getfield(cc, 'NumObjects');

sizes = cellfun(@numel,cc.PixelIdxList);

sizes = sort(sizes);

low_th = sizes(ceil(length*OUT_LIAER_TH_LOW));
high_th = sizes(ceil(length*(1-OUT_LIAER_TH_HIGH)));
disp(low_th);
disp(is_large);
disp(length);
if length >= is_large
    small_removed = bwareaopen(BW_1, low_th);
    large_kept = bwareaopen(small_removed, high_th);
    cleaned = small_removed - large_kept;
else
    small_removed = bwareaopen(BW_1, low_th);
    cleaned = small_removed;
end
% out_image = cleaned;
% figure, imshow(cleaned);
% title('cleaned');
%% Refinement of Nuclei Boundary Area
% 
% M_g = |I_ce - I_dilate|
M_d = imadjust(M_d);
M_g = uint8(abs(double(I_ce)-double(M_d)));
% figure, imshow(M_d);

% Inverse M_g to the result similar to the paper
M_g = 255-M_g;
% figure, imshow(M_g);

% Contrast enhancement
% ????????
% M_g = imadjust(M_g);
% figure, imshow(M_g_ce);

% Apply global thresholding
BW_2 = imbinarize(M_g,0.9);
% figure, imshow(BW);

% Figure 3(c)
joined_image = or(cleaned,BW_2);
figure, imshow(joined_image);
if length >= is_large
    cleaned_small_joined_image = bwareaopen(joined_image, low_th);
    cleaned_large_kept = bwareaopen(cleaned_small_joined_image, high_th);
    cleaned_joined_image = cleaned_small_joined_image - cleaned_large_kept;
    out_image = cleaned_joined_image;
    
else
    cleaned_small_joined_image = bwareaopen(joined_image, low_th);
    out_image = cleaned_small_joined_image;
end


% figure
% subplot(1,2,1); imshow(I);
% subplot(1,2,2); imshow(out_image);
% % % WaterShed
% bw = out_image;
% L = watershed(bw);
% bw2 = ~bwareaopen(~bw, 5);
% D = -bwdist(~bw);
% Ld = watershed(D);
% bw2 = bw;
% bw2(Ld == 0) = 0;
% % figure, imshow(bw2)
% mask = imextendedmin(D,2);
% 
% D2 = imimposemin(D,mask);
% Ld2 = watershed(D2);
% bw3 = bw;
% bw3(Ld2 == 0) = 0;
% figure,imshow(bw3)
% out_image = bw3;
end



clc;
clear;
close all;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
load('isbi_test90.mat')
load('isbi_test90_GT.mat')
% I = imread('EDF000.png');
% figure, imshow(I);

size_of_dataset = size(train_Nuclei);
size_of_dataset = size_of_dataset(1);
outimage=cell(size_of_dataset,1);



% size_start = 3;
% size_end = 30;


% Dice_results_is_large = zeros(1,size_end-size_start);
% j = 1;
% 
% for is_large = size_start:size_end
%     Dice_result = zeros(1,size_of_dataset);
%     for i=1:size_of_dataset
%         I = ISBI_Train{i, 1};
%         outimage = nuclei_segmentation(I, is_large, 0.3, 0.1);
%         Dice = DiceSimilarity(outimage, train_Nuclei{i,1});
%         Dice_results(i) = Dice;
%     end
%     mean_Dice_results = mean(Dice_results)
%     Dice_results_is_large(j) = mean(Dice_results);
%     j = j + 1;
% end


% perform T-test
areas_of_out = zeros(size_of_dataset, 1);
areas_of_gt = zeros(size_of_dataset, 1);
Dice_pixel_result = [];
Precision_pixel_result = [];
Recall_pixel_result = [];

Dice_object_result = [];
Precision_object_result = [];
Recall_object_result = [];

for i=1:size_of_dataset
    I = ISBI_Train{i, 1};
    out = nuclei_segmentation(I, 30, 0.3, 0.1);
%     out = nuclei_segmentation(I, 10, 0.3, 0.1);

    outimage{i, 1} = out;
%     Dice = DiceSimilarity(out, train_Nuclei{i,1});
    [Dice_pixel, Precision_pixel, Recall_pixel, Dice_object, Precision_object, Recall_object ]...
        = Evaluation( out, train_Nuclei{i,1});
    Dice_pixel_result = [Dice_pixel_result Dice_pixel];
    Precision_pixel_result = [Precision_pixel_result Precision_pixel];
    Recall_pixel_result = [Recall_pixel_result Recall_pixel];
    
    Dice_object_result = [Dice_object_result Dice_object];
    Precision_object_result = [Precision_object_result Precision_object];
    Recall_object_result = [Recall_object_result Recall_object];
%     areas_of_out(i) = get_area(out);
%     areas_of_gt(i) = get_area(train_Nuclei{i,1});
%     figure;
    subplot(2,1,1); imshow(out); 
    subplot(2,1,2); imshow(train_Nuclei{i,1});
end

% mean_area_of_out = mean(areas_of_out);
% std_area_of_out = std(areas_of_out);
% 
% mean_area_of_gt = mean(areas_of_gt);
% std_area_of_gt = std(areas_of_gt);

mean_Dice_pixel = mean(Dice_pixel_result);
mean_Precision_pixel = mean(Precision_pixel_result);
mean_Recall_pixel = mean(Recall_pixel_result);

mean_Dice_object = mean(Dice_object_result);
mean_Precision_object = mean(Precision_object_result);
mean_Recall_object = mean(Recall_object_result);









