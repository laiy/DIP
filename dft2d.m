function out_image = dft2d(originalImage, flags)
    out_image = [];
    [height, width] = size(originalImage);
    if (flags == 0)
        mid = zeros(height,width);
        for x = 1 : height
            for y = 1 : width            
                mid(x, y) = double(originalImage(x, y)) * ((-1) ^ (x + y));
            end
        end
        temp = [];
        for u = 1 : height
            n = [0 : width - 1];
            k = [0 : width - 1];
            constWN = exp(-1j * 2 * pi / width);
            NK = n' * k;
            constWNNK = constWN .^ NK;
            XK = mid(u, :) * constWNNK;
            temp = [temp; XK];
        end
        temp = temp.';
        for u = 1 : width
            n = [0 : height - 1];
            k = [0:height-1];
            constWN = exp(-1j * 2 * pi / height);
            NK=k' * n;
            constWNNK=constWN .^ NK;
            XK=temp(u, :) * constWNNK;
            out_image = [out_image XK.'];
        end
        showImage = zeros(height, width);
        for x = 1 : height
            for y = 1 : width
                showImage(x, y) = abs(out_image(x, y));
            end
        end
        minimum = min(showImage(:));
        showImage = showImage - minimum;
        showImage = 255 * (showImage ./ max(max(showImage)));
        for x = 1 : height
            for y = 1 : width
                showImage(x, y) = (255 / log(256)) * log(1 + showImage(x, y));
            end
        end
        figure;
        imshow(uint8(showImage));
    else
        temp = [];
        originalImage = originalImage.';
        for u = 1 : width
            n=[0 : height - 1];           
            k = n;
            constWN = exp(1j * 2 * pi / height);          
            NK = k'*n;
            constWNNK = constWN .^ (NK);
            XK = (originalImage(u, :) * constWNNK) /width;
            temp = [temp XK.'];
        end
        for u = 1 : height
            n = [0 : width - 1];           
            k = n;
            constWN = exp(1j * 2 * pi / width);          
            NK=n' * k;
            constWNNK = constWN .^ (NK);          
            XK = (temp(u, :) * constWNNK) / height;
            out_image = [out_image; XK];
        end
        for x = 1 : height
            for y = 1 : width            
                out_image(x, y) = real(out_image(x, y)) * ((-1) ^ (x + y));
            end
        end
        imshow(uint8(out_image))
    end
end
