function filter2d(imagePath, filter)
    originalImage = imread(imagePath);
    lens = size(filter);
    [height, width] = size(originalImage);
    temp_image = zeros(height + (lens(1) - 1), width + (lens(1) - 1));
    filteredImage = zeros(height, width);
    figure();
    subplot(1, 2, 1);
    imshow(originalImage);
    for i =  1: height
        for j =  1 : width
            temp_image(i + (lens(1) - 1) / 2, j + (lens(1) - 1) / 2) = originalImage(i, j);
        end
    end
    for i = (lens(1) - 1) / 2 + 1: height + (lens(1)- 1) / 2
        for j = (lens(1) - 1) / 2 + 1 : width + (lens(1) - 1) / 2
            filteredImage(i - (lens(1) - 1) / 2, j - (lens(1) - 1) / 2) = sum(sum(temp_image(i - (lens(1) - 1) / 2 : i + (lens(1) - 1) / 2, j - (lens(1) - 1) / 2 : j + (lens(1) - 1) / 2) .* filter));
        end
    end
    subplot(1, 2, 2);
    imshow(uint8(filteredImage));
    %mask = originalImage - uint8(filteredImage);
    %imshow(uint8(originalImage + 1.2 .* mask));
end