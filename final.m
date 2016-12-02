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

size_of_dataset = size(test_Nuclei);
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
    I = ISBI_Test90{i, 1};
    out = nuclei_segmentation(I, 20, 0.4, 0.1);
%     out = nuclei_segmentation(I, 10, 0.3, 0.1);

    outimage{i, 1} = out;
%     Dice = DiceSimilarity(out, train_Nuclei{i,1});
    [Dice_pixel, Precision_pixel, Recall_pixel, Dice_object, Precision_object, Recall_object ]...
        = Evaluation( out, test_Nuclei{i,1});
    Dice_pixel_result = [Dice_pixel_result Dice_pixel];
    Precision_pixel_result = [Precision_pixel_result Precision_pixel];
    Recall_pixel_result = [Recall_pixel_result Recall_pixel];
    
    Dice_object_result = [Dice_object_result Dice_object];
    Precision_object_result = [Precision_object_result Precision_object];
    Recall_object_result = [Recall_object_result Recall_object];
%     areas_of_out(i) = get_area(out);
%     areas_of_gt(i) = get_area(train_Nuclei{i,1});
%     figure;
%     subplot(2,1,1); imshow(out); 
%     subplot(2,1,2); imshow(train_Nuclei{i,1});
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

% [h,p,ci,stats] = ttest2(areas_of_out, areas_of_gt);










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



    