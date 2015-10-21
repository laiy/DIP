function scale(imagePath, scaleWidth, scaleHeight)
    scaledImage = zeros(scaleHeight, scaleWidth);
    originalImage = imread(imagePath);
    [height, width] = size(originalImage);
    widthScaleRate = scaleWidth / width;
    heightScaleRate = scaleHeight / height;
    for i = 1 : scaleHeight
        for j = 1 : scaleWidth
            pixel = [i / heightScaleRate, j / widthScaleRate];
            if pixel(1) < 1
                pixel(1) = 1;
            end
            if pixel(2) < 1
                pixel(2) = 1;
            end
            y = pixel(1) - floor(pixel(1));
            x = pixel(2) - floor(pixel(2));
            leftTop = [floor(pixel(1)), floor(pixel(2))];
            rightTop = [floor(pixel(1)), ceil(pixel(2))];
            leftBottom = [ceil(pixel(1)), floor(pixel(2))];
            rightBottom = [ceil(pixel(1)), ceil(pixel(2))];
            scaledImage(i,j) = (1 - x) * (1 - y) * originalImage(leftTop(1), leftTop(2))+ ...
                  x * (1 - y) * originalImage(rightTop(1), rightTop(2))+ ...
                  (1 - x) * y * originalImage(leftBottom(1), leftBottom(2))+ ...
                  x * y * originalImage(rightBottom(1), rightBottom(2));
        end
    end
    imshow(uint8(scaledImage));