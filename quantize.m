function quantize(imagePath, levels)
    originalImage = imread(imagePath);
    [height, width] = size(originalImage);
    for i = 1 : height
        for j = 1 : width
            interval = 256 / (levels - 1);
            number = floor(originalImage(i, j) / interval);
            if (originalImage(i, j) - number * interval) > ((number + 1) * interval - originalImage(i, j))
                originalImage(i, j) = (number + 1) * interval;
            else
                originalImage(i, j) = number * interval;
            end
        end
    end
    imshow(uint8(originalImage));