function  out_image  = baseline_segmentation( in_image )

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
H = imhmin(I_open, 20);
Cnp = I_ce+H;
% figure, imshow(Cnp);
% title('Cn');

Cnp_inverse = 255 - Cnp;
M_d = imdilate(Cnp_inverse,se);

% figure, imshow(M_d);
% title('M_d');

level = graythresh(M_d);
BW_1 = im2bw(M_d,level);
out_image = BW_1;
% figure, imshow(BW_1);
% title('BW_1');