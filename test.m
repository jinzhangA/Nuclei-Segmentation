load('isbi_train.mat');
load('isbi_train_GT.mat');
i = 23;
I = ISBI_Train{i, 1};

% I = imread('EDF0_7/EDF001.png');
GT = train_Nuclei{i,1};
CC = bwconncomp(GT);
list = CC.PixelIdxList;
for k=1:length(list)
    disp(list{k});
end