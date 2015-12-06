function out_image = fft2d(imagePath, flags)
    if (flags == 0)
        originalImage = imread(imagePath);
    else
        originalImage = imagePath;
    end
    [height, width] = size(originalImage);
    out_image = [];
    MH = nextpow2(height);
    MH = 2 ^ MH;
    MW = nextpow2(width);
    MW = 2 ^ MW;
    if (flags == 0)
        mid = zeros(MH, MW);
        for x = 1 : height
            for y = 1 : width            
                mid(x, y) = double(originalImage(x, y)) * ((-1) ^ (x + y));
            end
        end
        temp = [];
        M = nextpow2(width);
        N = 2 ^ M;
        for u = 1 : MH
            A = mid(u, :);
            J = 0;
            for I = 0 : N - 1 
                if I < J
                    T = A(I + 1);
                    A(I + 1) = A(J + 1);
                    A(J + 1) = T;
                end
                K = N / 2;
                while(J >= K)
                    J = J - K;
                    K = K / 2;
                end
                J = J + K;
            end
            WN = exp(-1j * 2 * pi / N);
            for L = 1 : M
                B = 2 ^ (L - 1);
                for R = 0 : B - 1
                    P = 2 ^ (M - L) * R;
                    for K = R : 2 ^ L : N - 2;
                        T = A(K + 1) + A(K + B + 1) * WN ^ P;
                        A(K + B + 1) = A(K + 1) - A(K + B + 1) * WN ^ P;
                        A(K + 1) = T;
                    end
                end
            end
            temp = [temp; A];
        end
        M = nextpow2(height);
        N = 2 ^ M;
        temp = temp.';
        for u = 1 : MW
            A = temp(u, :);
            J = 0;
            for I = 0 : N - 1 
                if I < J
                    T = A(I + 1);
                    A(I + 1) = A(J + 1);
                    A(J + 1) = T;
                end
                K = N / 2;
                while(J >= K)
                    J = J - K;
                    K = K / 2;
                end
                J = J + K;
            end 
            WN = exp(-1j * 2 * pi / N);
            for L = 1 : M
                B = 2 ^ (L - 1);
                for R = 0 : B - 1
                    P = 2 ^ (M - L) * R;
                    for K= R : 2 ^ L : N - 2;
                        T = A(K + 1) + A(K + B + 1) * WN ^ P;
                        A(K + B + 1) = A(K + 1) - A(K + B + 1) * WN ^ P;
                        A(K + 1) = T;
                    end
                end
            end
            out_image = [out_image A.']; 
        end
        showImage = zeros(MH, MW);
        for x = 1 : MH
            for y = 1 : MW
                showImage(x, y) = abs(out_image(x, y));
            end
        end
        showImage = showImage - min(showImage(:));
        showImage = 255 * (showImage ./ max(max(showImage)));
        for x = 1 : MH
            for y = 1 : MW
                showImage(x, y) = (255 / log(256)) * log(1 + showImage(x, y));
            end
        end
        figure;
        imshow(uint8(showImage));
    else
        temp = [];
        M = nextpow2(width);
        N = 2 ^ M;
        for u = 1 : MH
            A = originalImage(u, :);
            J = 0;
            for I = 0 : N - 1 
                if I < J
                    T = A(I + 1);
                    A(I + 1) = A(J + 1);
                    A(J + 1) = T;
                end
                K = N / 2;
                while(J >= K)
                    J = J - K;
                    K = K / 2;
                end
                J = J + K;
            end
            WN = exp(-1j * 2 * pi / N);
            for L = 1 : M
                B = 2 ^ (L - 1);
                for R = 0 : B - 1
                    P = 2 ^ (M - L) * R;
                    for K= R : 2 ^ L : N - 2;
                        T = A(K + 1) + A(K + B + 1) * WN ^ (-P);
                        A(K + B + 1) = A(K + 1) - A(K + B + 1) * WN ^ (-P);
                        A(K + 1) = T;
                    end
                end
            end
            A = A * (1 / N);
            temp = [temp; A];
        end
        M = nextpow2(height);
        N = 2 ^ M;
        temp = temp.';
        for u = 1 : MW
            A = temp(u, :);
            J = 0;
            for I = 0 : N-1 
                if I < J
                    T = A(I + 1);
                    A(I + 1) = A(J + 1);
                    A(J + 1) = T;
                end
                K = N / 2;
                while(J >= K)
                    J = J - K;
                    K = K / 2;
                end
                J = J + K;
            end 
            WN = exp(-1j * 2 * pi / N);
            for L = 1 : M
                B = 2 ^ (L - 1);
                for R = 0 : B - 1
                    P = 2 ^ (M - L) * R;
                    for K= R : 2 ^ L : N - 2;
                        T = A(K + 1) + A(K + B + 1) * WN ^ (-P);
                        A(K + B + 1) = A(K + 1) - A(K + B + 1) * WN ^ (-P);
                        A(K + 1) = T;
                    end
                end
            end
            A = A * (1 / N);
            out_image = [out_image A.'];    
        end
        for x = 1 : MH
            for y = 1 : MW            
                out_image(x, y) = real(out_image(x, y)) * ((-1) ^ (x + y));
            end
        end
        imshow(uint8(out_image));
    end
end
