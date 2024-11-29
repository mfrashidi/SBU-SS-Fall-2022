clear all;
close all;
clc;

horizontal_edge = [[-1,-1,-1]; [0,0,0]; [1,1,1]];
               
vertical_edge = [[-1,0,1]; [-1,0,1]; [-1,0,1]];

sharpening = [[0,-1,0]; [-1,5,-1]; [0,-1,0]];

weighted_averaging_3x3 = (1/16)*[[1, 2, 1]; [2, 4, 2]; [1, 2, 1]];

robert_x = [[1, 0]; [0, -1]]; 

robert_y = [[0, +1]; [-1, 0]];

averaging_2x2 = (1/4)*[[1, 1]; [1, 1]];

l1_filters = cat(3, horizontal_edge, vertical_edge, sharpening, weighted_averaging_3x3);

l2_filters = cat(3, robert_x, robert_y, averaging_2x2);

img = imread('/Users/mfrashidi/Documents/Signals and Systems/Assignments/#3 (CA-Project)/Signals and System Final Project/Image Processing/images/andrew.jpeg');

[~, ~, number_of_l1_filters] = size(l1_filters);
[~, ~, number_of_l2_filters] = size(l2_filters);
columns = max(number_of_l1_filters, number_of_l2_filters);

subplot(2, columns + 1, 1)
imshow(img)
title("Original Image")

layer_one_output = conv2D(img, l1_filters, 1, 'same');

for i = 1:number_of_l1_filters
    subplot(2, number_of_l1_filters + 1, i + 1)
    imshow(uint8(255 * mat2gray(layer_one_output(:,:,i))))
    title(sprintf('Filter #%d', i))
end

subplot(2, columns + 1, number_of_l1_filters + 2)
imshow(img)
title("Original Image")

layer_two_output = conv2D(layer_one_output, l2_filters, 2, 'valid');

for i = 1:number_of_l2_filters
    subplot(2, columns + 1, number_of_l1_filters + 2 + i)
    imshow(uint8(255 * mat2gray(layer_two_output(:,:,i))))
    title(sprintf('Filter #%d', i))
end

% imwrite(feature_map, '/Users/mfrashidi/Documents/Signals and Systems/Assignments/#3 (CA-Project)/images/filtered_img.jpeg')