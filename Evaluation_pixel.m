function [Dice, Precision, Recall ] = Evaluation_pixel( out_image, ground_truth )
[m ,n] = size(out_image);
TP = 0;
TN = 0;
FP = 0;
FN = 0;
OUT = 0;
GT = 0;
for i = 1:m*n
    if out_image(i) == 1
        OUT = OUT + 1;
    end
    if ground_truth(i) == 1
        GT = GT + 1;
    end 
    
    if out_image(i) == 1 && ground_truth(i) == 1
        TP = TP + 1;
    elseif out_image(i) == 0 && ground_truth(i) == 0
        TN = TN + 1;
    elseif out_image(i) == 1 && ground_truth(i) == 0
        FP = FP + 1;
    elseif out_image(i) == 0 && ground_truth(i) == 1
        FN = FN + 1;
    end
end
% fprintf('TP %d, TN %d, FP %d, FN %d', TP, TN, FP, FN);
Precision = TP/(TP+FP);
Recall = TP/(TP+FN);
Dice = 2*TP/(OUT + GT);

