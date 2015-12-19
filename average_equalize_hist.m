function outimage = average_equalize_hist(imagePath)
    originalImage = imread(imagePath);
    R = originalImage(:, :, 1);
    G = originalImage(:, :, 2);
    B = originalImage(:, :, 3);
    NR = zeros(1,256);
    NG = zeros(1,256);
    NB = zeros(1,256);
    NA = zeros(1,256);
    [height,width] = size(R);
    NewR = zeros(height, width);
    NewG = zeros(height, width);
    NewB = zeros(height, width);
    for i = 1 : height
        for j = 1 : width
            NR(R(i, j) + 1) = NR(R(i, j) + 1) + 1;
            NG(G(i, j) + 1) = NG(G(i, j) + 1) + 1;
            NB(B(i, j) + 1) = NB(B(i, j) + 1) + 1;
        end
    end
    for i = 1 : 256
        NA(i) = (NR(i) + NG(i) + NB(i)) / 3;
        NA(i) = round(NA(i));
    end
    ProfPixA = zeros(1, 256);
    for i = 1 : 256
            ProfPixA(i) = NA(i) / (width * height * 1.0);
    end
    CuofPixA = zeros(1, 256);
    for i = 1 : 256
        if i == 1;
            CuofPixA(i) = ProfPixA(i);
        else
            CuofPixA(i) = CuofPixA(i - 1) + ProfPixA(i);
        end
    end
    CuofPixA = uint8(CuofPixA .* 255);
    for i = 1 : height
        for j = 1 : width
            NewR(i, j) = CuofPixA(R(i, j) + 1);
            NewG(i, j) = CuofPixA(G(i, j) + 1);
            NewB(i, j) = CuofPixA(B(i, j) + 1);
        end
    end
    NewR = uint8(NewR);
    NewG = uint8(NewG);
    NewB = uint8(NewB);
    outimage(:, :, 1) = NewR;
    outimage(:, :, 2) = NewG;
    outimage(:, :, 3) = NewB;
    outimage = uint8(outimage);
    figure;
    imshow(outimage);
end
