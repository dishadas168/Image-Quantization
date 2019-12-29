%This function computes the SSD error (sum of squared error) between the original
%RGB pixel values and the quantized values.
%origImg and quantizedImg are both RGB images, and error is a scalar giving 
%the total SSD error across the image.

function [ error ] = computeQuantizationError( origImg, quantizedImg )

[h w d] = size(origImg);
orig = double(origImg(:));
q = double(quantizedImg(:));
err = orig - q;
err = int64(err).^2;
error = sum(sum(err));

end

