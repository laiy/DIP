function histogram_equalization(imagePath)
    originalImage = imread(imagePath);
    [height, width] = size(originalImage);
    histogram_equalized_image = zeros(height,width);
    pixels_array = zeros(1,256);
    for i = 1 : height
        for j = 1 : width
            pixels_array(originalImage(i, j) + 1) = pixels_array(originalImage(i, j) + 1) + 1;
        end
    end
    figure();
    subplot(2, 2, 1);
    imshow(originalImage);
    subplot(2, 2, 2);
    bar(pixels_array);
    for i = 1 : 256
            pixels_array(i) = pixels_array(i) / (width * height * 1.0);
    end
    cdf_pixels = zeros(1,256);
    for i = 1 : 256
        if i == 1
            cdf_pixels(i) = pixels_array(i);
        else
            cdf_pixels(i) = cdf_pixels(i - 1) + pixels_array(i);
        end
    end
    cdf_pixels = uint8(cdf_pixels .* 255);
    for i = 1 : height
        for j = 1 : width
            histogram_equalized_image(i, j) = cdf_pixels(originalImage(i, j) + 1);
        end
    end
    for i = 1 : height
        for j = 1 : width
            pixels_array(histogram_equalized_image(i, j) + 1) = pixels_array(histogram_equalized_image(i, j) + 1) + 1;
        end
    end
    subplot(2, 2, 3);
    imshow(uint8(histogram_equalized_image));
    subplot(2, 2, 4);
    bar(pixels_array);
end