function out_image = filter2d_freq(imagePath, filter)
    originalImage = imread(imagePath);
    [height, width] = size(originalImage);
    [filterHeight, filterWidth] = size(filter);
    if (mod(height + filterHeight - 1, 2) == 1)
        finalHeight = height + filterHeight;
    else
        finalHeight = height + filterHeight - 1;
    end
    if (mod(width + filterWidth - 1, 2) == 1)
        finalWidth = width + filterWidth;
    else
        finalWidth = width + filterWidth - 1;
    end
    exPic = zeros(finalHeight, finalWidth);
    exFilter = zeros(finalHeight, finalWidth);
    out_image = zeros(height, width);
    result = zeros(finalHeight, finalWidth);
    for x = 1 : finalHeight
        for y = 1 : finalWidth
            if (x >= 1 &&  x <= height && y >= 1 && y <= width)
                exPic(x, y) = originalImage(x, y);
            end
        end
    end
    Fpic = dft2d(exPic, 0);
    for x = 1 : finalHeight
        for y = 1 : finalWidth
            if (x >= 1 &&  x <= filterHeight && y >= 1 && y <= filterWidth)
                exFilter(x, y) = filter(x, y);
            end
        end
    end
    Ffil = dft2d(exFilter, 0);
    result = Ffil .* Fpic;
    result = dft2d(result, 1);
    for x = 1 : height
        for y = 1 : width
            out_image(x, y) = result(x, y);
        end
    end
    figure;
    imshow(uint8(out_image));
end
