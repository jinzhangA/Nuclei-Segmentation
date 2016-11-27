clc;
clear;
close all;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
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
Dice_result = zeros(size_of_dataset,1);


for i=1:size_of_dataset
    I = ISBI_Train{i, 1};
    out = nuclei_segmentation(I, 10, 0.2, 0.1);
%     out = nuclei_segmentation(I, 10, 0.3, 0.1);

    outimage{i, 1} = out;
    Dice = DiceSimilarity(out, train_Nuclei{i,1});
    Dice_result(i) = Dice;
    areas_of_out(i) = get_area(out);
    areas_of_gt(i) = get_area(train_Nuclei{i,1});
end

mean_area_of_out = mean(areas_of_out);
std_area_of_out = std(areas_of_out);

mean_area_of_gt = mean(areas_of_gt);
std_area_of_gt = std(areas_of_gt);

mean_Dice = mean(Dice_result);

[h,p,ci,stats] = ttest(areas_of_out, areas_of_gt);










% size_start = 3;
% size_end = 30;
% Dice_results_is_large = zeros(1,size_end-size_start+1);
% j = 1;
% for is_large = size_start:size_end
%     Dice_result = zeros(1,size_of_dataset);
%     for i=1:size_of_dataset
%         I = ISBI_Train{i, 1};
%         outimage{i, 1} = nuclei_segmentation(I, is_large, 0.1, 0.5);
%         
%     end
%     [meanDice70, ...
%         meanFNR70_object, ...
%         meanTPR70_pixel, ...
%         meanFPR70_pixel, ...
%         stdDice70, ...
%         stdTPR70_pixel, ...
%         stdFPR70_pixel, ...
%         stdFNo_70] ...
%             = evaluateCytoSegmentation({train_Nuclei},{outimage});
%     meanDice70
%     Dice_results_is_large(j) = meanDice70;
%     j = j + 1;
% end

% [meanDice70, ...
% meanFNR70_object, ...
% meanTPR70_pixel, ...
% meanFPR70_pixel, ...
% stdDice70, ...
% stdTPR70_pixel, ...
% stdFPR70_pixel, ...
% stdFNo_70] ...
%     = evaluateCytoSegmentation({train_Nuclei},{outimage});



    