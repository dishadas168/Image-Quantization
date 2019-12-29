%Given an image, this function computes and displays two histograms of its 
%hue values. The first histogram uses equally-spaced bins (uniformly dividing 
%up the hue values), and the second histogram use bins defined by the k cluster 
%center memberships (i.e., all pixels belonging to hue cluster i go to the 
%i-th bin, for i=1,...k).
%im is an MxNx3 matrix represeting an RGB image, and histEqual and histClustered are
%the two output histograms.

function [ histEqual, histClustered ] = getHueHists( im, k )

origImg = rgb2hsv(im);
orig = origImg(:,:,1);
figure;


origImg = im2double(origImg);

[h w d] = size(origImg);

him = origImg(:,:,1);

input = zeros((h*w),1);

input = him(:);

histEqual = histogram(input);
title('HistEqual');
xlabel('Hue Values');
ylabel('Frequency');
histEqual.BinWidth = 0.01;
histEqual.NumBins = k;
savefig('histEqual.fig');

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

figure;
histClustered = histogram(outputImg(:,:,1));
%histClustered.NumBins = k;
title('HistClustered');
xlabel('Hue Values');
ylabel('Frequency');
savefig('histClustered.fig');

end

