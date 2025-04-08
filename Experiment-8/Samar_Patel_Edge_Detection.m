% Created by Samar Patel, BT22ECE075
% Edge Detection Without Using Standard Functions and Other Operators

clc; 
clear; 
close all;

% Read the input image
img = imread('Air_Pollution_Image_5.png');  % Replace with your image file
gray_img = rgb2gray(img);   % Convert to grayscale

% Display Original Image
figure;
imshow(img);
title('Original Image');

%% Edge Detection Without Using Standard Functions

% Define Sobel filters manually
Gx = [-1 0 1; -2 0 2; -1 0 1];  % Sobel operator for X direction
Gy = [-1 -2 -1; 0 0 0; 1 2 1];  % Sobel operator for Y direction

% Perform convolution manually
Ix = conv2(double(gray_img), Gx, 'same');  % Convolve with Gx
Iy = conv2(double(gray_img), Gy, 'same');  % Convolve with Gy

% Compute Gradient Magnitude
Gradient_Mag = sqrt(Ix.^2 + Iy.^2);  % Magnitude of the gradient

% Normalize the result (0-255)
Gradient_Mag = uint8(255 * (Gradient_Mag / max(Gradient_Mag(:))));

% Apply thresholding for edge detection
threshold = 50;  % You can adjust this value
Edge_Image = Gradient_Mag > threshold;

% Display Results for Manual Edge Detection
figure;
subplot(1,3,1), imshow(gray_img), title('Grayscale Image');
subplot(1,3,2), imshow(Gradient_Mag), title('Gradient Magnitude');
subplot(1,3,3), imshow(Edge_Image), title('Edge Detected Image (Manual)');

%% Edge Detection Using Standard Functions

% Apply Sobel edge detection
BW_sobel = edge(gray_img, 'sobel');
figure;
imshow(BW_sobel);
title('Sobel Edge Detection (Standard Function)');

% Apply Prewitt edge detection
BW_prewitt = edge(gray_img, 'prewitt');
figure;
imshow(BW_prewitt);
title('Prewitt Edge Detection (Standard Function)');

% Apply Roberts edge detection
BW_roberts = edge(gray_img, 'roberts');
figure;
imshow(BW_roberts);
title('Roberts Edge Detection (Standard Function)');

% Apply Canny edge detection
BW_canny = edge(gray_img, 'canny');
figure;
imshow(BW_canny);
title('Canny Edge Detection (Standard Function)');
