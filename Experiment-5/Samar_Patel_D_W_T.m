% Created on 20/03/25
% Created by Samar Patel, BT22ECE075
% Discrete Wavelet Transform

clear all;
close all;
clc;

% Read the image using file selection dialog
[fileName, filePath] = uigetfile('*.*', 'Select a File');

if fileName == 0
    disp('No file selected. Exiting.');
    return;
end

img_color = imread(fullfile(filePath, fileName));

% Convert to grayscale for DWT processing
img_gray = rgb2gray(img_color);
img_gray = double(img_gray); % Convert to double precision

% Define Haar wavelet filters
LPF = [1/sqrt(2), 1/sqrt(2)]; % Low-pass filter
HPF = [-1/sqrt(2), 1/sqrt(2)]; % High-pass filter

% Row-wise Convolution and Downsampling
low_rows = conv2(img_gray, LPF, 'same'); % Low-pass
high_rows = conv2(img_gray, HPF, 'same'); % High-pass

low_rows_ds = low_rows(:, 1:2:end); % Downsample columns
high_rows_ds = high_rows(:, 1:2:end); % Downsample columns

% Column-wise Convolution and Downsampling
LL = conv2(low_rows_ds, LPF', 'same'); % Approximation
LH = conv2(low_rows_ds, HPF', 'same'); % Horizontal details
HL = conv2(high_rows_ds, LPF', 'same'); % Vertical details
HH = conv2(high_rows_ds, HPF', 'same'); % Diagonal details

LL = LL(1:2:end, :); % Downsample rows
LH = LH(1:2:end, :); % Downsample rows
HL = HL(1:2:end, :); % Downsample rows
HH = HH(1:2:end, :); % Downsample rows

% Display 
figure;
subplot(2,3,1); imshow(img_color); title('Original Image (Color)'); 
subplot(2,3,2); imshow(img_gray, []); title('Grayscale Image'); 
subplot(2,3,3); imshow(LL, []); title('LL (Approximation)');
subplot(2,3,4); imshow(LH, []); title('LH (Horizontal)');
subplot(2,3,5); imshow(HL, []); title('HL (Vertical)');
subplot(2,3,6); imshow(HH, []); title('HH (Diagonal)');