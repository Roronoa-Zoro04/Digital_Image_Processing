% Created on 26/01/25
% Created by Samar Patel, BT22ECE075
% Bit Plane Slicing

clc;
clear;
close all;

[fileName, filePath] = uigetfile('*.*', 'Select a File');

if fileName == 0
    disp('No file selected. Exiting.');
    return;
end

image = imread(fullfile(filePath, fileName));

% Convert the image to grayscale (if it's not already)
if size(image, 3) == 3
    image_gray = rgb2gray(image);
else
    image_gray = image;
end

% Figure to display the original and grayscale image
figure;
subplot(1, 2, 1), imshow(image); xlabel("Original Image");
subplot(1, 2, 2), imshow(image_gray); xlabel("Grayscale Image");

% Get the binary representation of the grayscale image
image_bin = dec2bin(image_gray, 8); % 8-bit representation of each pixel

% Create a figure to display the bit planes
figure;
bit_plane_images = zeros([size(image_gray), 8]); % Store bit plane images
for bit = 0:7
    % Extract the bit plane (start from the least significant bit)
    bit_plane = image_bin(:, 8-bit) - '0';  % Convert char to numeric
    
    % Reshape the bit plane to image dimensions
    bit_plane_image = reshape(bit_plane, size(image_gray));
    bit_plane_images(:,:,bit+1) = bit_plane_image; % Store for later use
    
    % Display each bit plane as a binary image (0 and 1)
    subplot(2, 4, bit+1), imshow(bit_plane_image);
    xlabel(['Bit Plane ', num2str(bit)]);
end

% Remove the MSB (bit plane 7) and reconstruct the image using the remaining 7 planes
reconstructed_image = zeros(size(image_gray));
for bit = 0:6 % Exclude MSB (bit plane 7)
    reconstructed_image = reconstructed_image + (bit_plane_images(:,:,bit+1) * 2^bit);
end
reconstructed_image = uint8(reconstructed_image); % Convert back to uint8

% Display the comparison of the grayscale image and reconstructed image
figure;
subplot(1, 2, 1), imshow(image_gray); xlabel("Grayscale Image");
subplot(1, 2, 2), imshow(reconstructed_image); xlabel("Reconstructed Image without MSB");
