function noise_generator(imagePath, type, para1, para2)
    originalImage = imread(imagePath);
    [height, width, deep] = size(originalImage);
    image = zeros(height, width);
    for i = 1 : height
        for j = 1 : width
            image(i, j) = originalImage(i, j);
        end
    end
    out_image = zeros(height, width);
    if(type == 1)
        guss = para2 * randn(height, width) + para1;
        out_image = image + guss;
        out_image = uint8(out_image);
    else
        total = height * width;
        out_image = image;
        papper = round(rand() * total * para1);
        salt = round(rand() * total * para2);
        for i = 1 : papper
            out_image(round(rand() * total / width) + 1, mod(round(rand() * total), width) + 1) = 0;
        end
        for i = 1 : salt
            out_image(round(rand() * total / width) + 1, mod(round(rand() * total), width) + 1) = 255;
        end
        out_image = uint8(out_image);
    end
    imshow(out_image);
end
