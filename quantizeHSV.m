%Given an RGB image, this function converts it to HSV, and quantizes the 
%1-dimensional Hue space. Each pixel in the input image is mapped to its 
%nearest quantized Hue value, while keeping its Saturation and Value channels 
%the same as the input. The quantized output is converted back to RGB color space.
%origImg and outputImg are MxNx3 matrices of type uint8, k specifies the number of
%clusters, and meanHues is a k x 1 vector of the hue centers.

function [ outputImg, meanHues ] = quantizeHSV(origImg, k )

origImg = rgb2hsv(origImg);
origImg = im2double(origImg);

[h w d] = size(origImg);

him = origImg(:,:,1);

input = zeros((h*w),1);

input = him(:);
input = round(input*10000);

[idx, C] = kmeans(input, k);
meanHues = round(C);
meanHues = double(meanHues/10000);


outputImg = zeros(h,w,d);
idx = uint8(idx);

sim = reshape(idx, [h w]);
for i= 1:h
    for j= 1:w
        outputImg(i,j,1) = meanHues(sim(i,j));
        outputImg(i,j,2) = origImg(i,j,2);
        outputImg(i,j,3) = origImg(i,j,3);
    end
end

outputImg = hsv2rgb(outputImg);
outputImg = im2uint8(outputImg);

end

