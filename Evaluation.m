function [Dice_pixel, Precision_pixel, Recall_pixel, Dice_object, Precision_object, Recall_object]...
    = Evaluation( out_image, ground_truth )
CC_out = bwconncomp(out_image);
CC_out = CC_out.PixelIdxList;

CC_GT = bwconncomp(ground_truth);
CC_GT = CC_GT.PixelIdxList;
TP_object = 0;
FP_object = 0;
FN_object = 0;
OUT_object = length(CC_out);
GT_object = length(CC_GT);

TP_pixel = 0;
FP_pixel = 0;
FN_pixel = 0;
OUT_pixel = sum(sum(out_image));
GT_pixel = sum(sum(ground_truth));

for i = 1:length(CC_out)
    found = 0;
    for j = 1:length(CC_GT)
        TP = length(intersect(CC_out{i}, CC_GT{j}));
        if TP/length(CC_out{i}) > 0.6 && TP/length(CC_GT{j}) > 0.6
            TP_object = TP_object + 1;
            TP_pixel = TP_pixel + TP;
            FP_pixel = FP_pixel + length(setdiff(CC_out{i}, CC_GT{j}));
            FN_pixel = FN_pixel + length(setdiff(CC_GT{j}, CC_out{i}));
            found = 1;
            break;
        end
    end
    if found == 0
        FP_object = FP_object + 1;
%         FP_pixel = FP_pixel + length(CC_out{i});
    end 
end

for j = 1:length(CC_GT)
    found = 0;
    for i = 1:length(CC_out)
        TP = length(intersect(CC_out{i}, CC_GT{j}));
        if TP/length(CC_out{i}) > 0.6 && TP/length(CC_GT{j}) > 0.6
           
            found = 1;
            break;
        end
    end
    if found == 0
        FN_object = FN_object + 1;
        
    end 
end

% Object base
Precision_object = TP_object/(TP_object+FP_object);
Recall_object = TP_object/(TP_object+FN_object);
Dice_object = 2*TP_object/(OUT_object + GT_object);

Precision_pixel = TP_pixel/(TP_pixel+FP_pixel);
Recall_pixel = TP_pixel/(TP_pixel+FN_pixel);
Dice_pixel = 2*TP_pixel/(OUT_pixel + GT_pixel);

