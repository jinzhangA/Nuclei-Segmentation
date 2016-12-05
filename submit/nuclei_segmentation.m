function  out_image  = nuclei_segmentation( in_image, is_large, OUT_LIAER_TH_LOW, OUT_LIAER_TH_HIGH, DISTANCE)

%% Preprocessing
% Contrast enhancement
I = in_image;
I_1 = imhmin(I,20);
I_2 = imhmin(I,60);

I_subs =  I_2 - I_1;
I_ce = I - I_subs;

% get the region of 
se = strel('disk',1);
I_open = imopen(I,se);
H = imhmin(I_open, 10);
Cnp = I_ce+H;
% figure, imshow(Cnp);
% title('Cn');

Cnp_inverse = 255 - Cnp;
M_d = imdilate(Cnp_inverse,se);

% figure, imshow(M_d);
% title('M_d');

level = graythresh(M_d);
BW_1 = im2bw(M_d,level);
% figure, imshow(BW_1);
% title('BW_1');
cc = bwconncomp(BW_1,4);
length = getfield(cc, 'NumObjects');

sizes = cellfun(@numel,cc.PixelIdxList);

sizes = sort(sizes);

low_th = sizes(ceil(length*OUT_LIAER_TH_LOW));
high_th = sizes(ceil(length*(1-OUT_LIAER_TH_HIGH)));

if length >= is_large
    small_removed = bwareaopen(BW_1, low_th);
    large_kept = bwareaopen(small_removed, high_th+1);
    cleaned = small_removed - large_kept;
else
    small_removed = bwareaopen(BW_1, low_th);
    cleaned = small_removed;
end

% Smooth the boundary
se = strel('disk',1);
cleaned = imdilate(cleaned,se);

% figure, imshow(cleaned);
% title('cleaned');
%% Refinement of Nuclei Boundary Area

% M_g = |I_ce - I_dilate|
Cnp = imadjust(Cnp);
% figure, imshow(Cnp);
Cnp_inverse = 255 - Cnp;
se = strel('disk',2);
M_d = imdilate(Cnp_inverse,se);
M_d = imadjust(M_d);
% figure, imshow(M_d);
% title('M_d');
% figure, imshow(I_ce);
% title('I_ce');
M_g = uint8(abs(double(I_ce)-double(M_d)));

% Inverse M_g to the result similar to the paper
M_g = 255-M_g;
% figure, imshow(M_g);
% title('M_g');

% Contrast enhancement
M_g_ce = imadjust(M_g, [0.3; 0.7], []);
% figure, imshow(M_g_ce);
% title('M_g_ce');


% % Apply global thresholding
BW_2 = imbinarize(M_g_ce,0.8);
% figure, imshow(BW_2);
% title('BW_2');
BW_2 = distance_based_cleaning(BW_2, cleaned, DISTANCE);
% figure, imshow(BW_2);
% title('BW2_cleaned');
se = strel('disk',3);
BW_2 = imclose(BW_2, se);
% 
% % Figure 3(c)
joined_image = or(cleaned,BW_2);
if length >= is_large
    cleaned_small_joined_image = bwareaopen(joined_image, low_th);
    cleaned_large_kept = bwareaopen(cleaned_small_joined_image, high_th+1);
    cleaned_joined_image = cleaned_small_joined_image - cleaned_large_kept;
    se = strel('disk',5);
    out_image = imclose(cleaned_joined_image, se);
else
    cleaned_small_joined_image = bwareaopen(joined_image, low_th);
%     out_image = cleaned_small_joined_image;
    se = strel('disk',5);
    out_image = imclose(cleaned_small_joined_image, se);
end
