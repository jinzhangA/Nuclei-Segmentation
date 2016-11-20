clc;
clear;

% load('isbi_test90_GT.mat');
load('isbi_train.mat');
load('isbi_train_GT.mat');
% I = imread('EDF000.png');
% figure, imshow(I);
% 

size_of_dataset = size(train_Nuclei);
size_of_dataset = size_of_dataset(1);
outimage=cell(size_of_dataset,1);

size_start = 3;
size_end = 30;


Dice_results_is_large = zeros(1,size_end-size_start);
j = 1;

for is_large = size_start:size_end
    Dice_result = zeros(1,size_of_dataset);
    for i=1:size_of_dataset
        I = ISBI_Train{i, 1};
        outimage = nuclei_segmentation(I, is_large, 0.3, 0.1);
        Dice = DiceSimilarity(outimage, train_Nuclei{i,1});
        Dice_results(i) = Dice;
    end
    mean_Dice_results = mean(Dice_results)
    Dice_results_is_large(j) = mean(Dice_results);
    j = j + 1;
end



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



    