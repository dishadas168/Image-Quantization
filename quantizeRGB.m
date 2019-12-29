%Given an RGB image, this function quantizes the 3-dimensional RGB space, 
%and maps each pixel in the input image to its nearest k-means center. 
%That is, the RGB value at each pixel is replaced with its nearest cluster’s 
%average RGB value. origImg and outputImg are MxNx3 matrices of type uint8, 
%k specifies the number of colors to quantize to, and meanColors is a k x 3 
%array of the k centers.

function [ outputImg, meanColors ] = quantizeRGB( origImg, k )

origImg = double(origImg);

[h w d] = size(origImg);

rim = origImg(:,:,1);
gim = origImg(:,:,2);
bim = origImg(:,:,3);

input = zeros((h*w),3);

input(:,1) = rim(:);
input(:,2) = gim(:);
input(:,3) = bim(:);

[idx, C] = kmeans(input, k);
meanColors = round(C);

outputImg = zeros(h,w,d);
idx = uint8(idx);
sim = reshape(idx, [h w]);
for i= 1:h
    for j= 1:w
        outputImg(i,j,:) = meanColors(sim(i,j),:);
    end
end

outputImg = uint8(outputImg);

end

