clear
clc

%// Image source: http:\\giantbomb.com
A = rgb2gray(imread('ATM_14_09_2016.jpg'));
B = rgb2gray(imread('ATM_15_09_2016.jpg'));
C = rgb2gray(imread('ATM_16_09_2016.jpg'));

ImageCell = {A;B;C};

figure;
subplot(131)
imshow(A)

subplot(132)
imshow(B)

subplot(133)
imshow(C)

FileName = 'UnicornAnimation.gif';

for k = 1:numel(ImageCell)

    if k ==1

%// For 1st image, start the 'LoopCount'.
        imwrite(ImageCell{k},FileName,'gif','LoopCount',Inf,'DelayTime',1);
    else
        imwrite(ImageCell{k},FileName,'gif','WriteMode','append','DelayTime',1);
    end

end