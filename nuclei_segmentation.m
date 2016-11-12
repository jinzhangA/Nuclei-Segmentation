function  out_image  = nuclei_segmentation( in_image )

%% Preprocessing
I = in_image;
I_1 = imhmin(I,60);

I_2 = imhmin(I,115);
I_subs =  I_2 - I_1;

I_ce = I - I_subs;
% imshow(I_ce);

se = strel('disk',3);
I_open = imopen(I,se);
H = imhmin(I_open,30);
Cnp = I_ce+H;

Cnp = imadjust(Cnp);
% figure, imshow(Cnp_ce);
Cnp_inverse = 255 - Cnp;
M_d = imdilate(Cnp_inverse,se);

% figure, imshow(M_d);

level = graythresh(M_d);
BW_1 = im2bw(M_d,level);
% BW_1 = imbinarize(M_d,'adaptive');
% figure, imshow(BW);

small_removed = bwareaopen(BW_1, 15);
% figure, imshow(small_removed);

large_kept = bwareaopen(small_removed, 6000);
% figure, imshow(large_kept);

cleaned = xor(small_removed,large_kept);
% cleaned = small_removed;
% figure, imshow(cleaned);
out_image = cleaned;

%% Refinement of Nuclei Boundary Area

% M_g = |I_ce - I_dilate|
M_d = imadjust(M_d);
M_g = uint8(abs(double(I_ce)-double(M_d)));
% figure, imshow(M_g);

% Inverse M_g to the result similar to the paper
M_g = 255-M_g;

% Contrast enhancement
% ????????
% M_g = imadjust(M_g);
% figure, imshow(M_g_ce);

% Apply global thresholding
BW_2 = imbinarize(M_g,0.8);
% figure, imshow(BW);

% Figure 3(c)
joined_image = or(cleaned,BW_2);
% figure, imshow(joined_image);
cleaned_joined_image = bwareaopen(joined_image, 15);
% figure, imshow(cleaned_joined_image);
out_image = cleaned_joined_image;


% % WaterShed
% bw = cleaned_joined_image;
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
% % figure,imshow(bw3)
% out_image = bw3;
end

