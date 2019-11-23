%
% Este arquivo cont�m as opera��es de filtragem no dom�nio da frequ�ncia
%

function [lowFilteredImage, highFilteredImage] = freq_dom_filter(image)
    imgSize = size(image);

    %% Defini��o dos "discos" de filtragem 
    [x,y] = freqspace([imgSize(1), imgSize(2)],'meshgrid');
    z = zeros(imgSize(1), imgSize(2));
    for i = 1:imgSize(1)
        for j = 1:imgSize(2)
            z(i,j) = sqrt(x(i,j).^2 + y(i,j).^2);
        end
    end
    
    lowPassFilter = zeros(imgSize(1),imgSize(2));
    lowPassLimit = 0.3;
    for i = 1:imgSize(1)
        for j = 1:imgSize(2)
            if z(i,j) <= lowPassLimit
                lowPassFilter(i,j) = 1;
            else
                lowPassFilter(i,j) = 0;
            end
        end
    end
    
    
    highPassFilter = zeros(imgSize(1),imgSize(2));
    highPassLimit = 0.35;
    for i = 1:imgSize(1)
        for j = 1:imgSize(2)
            if z(i,j) >= highPassLimit
                highPassFilter(i,j) = 1;
            else
                highPassFilter(i,j) = 0;
            end
        end
    end
    

    %% Transforma��o da imagem para o dom�nio da frequ�ncia
    fourierImage = fft2(image);
    shiftedFourierImage = fftshift(fourierImage);
    
    %% Filtro passa-alta
    highPassFilteredFourier = shiftedFourierImage .* highPassFilter;
    inversedShiftFourierHighPassImage = ifftshift(highPassFilteredFourier);
    highFilteredImage = uint8(ifft2(inversedShiftFourierHighPassImage));
    highFilteredImage = highFilteredImage + image;
    
    %% Filtro passa-baixa
    lowPassFilteredFourier = shiftedFourierImage .* lowPassFilter;
    inversedShiftFourierLowPassImage = ifftshift(lowPassFilteredFourier);
    lowFilteredImage = uint8(ifft2(inversedShiftFourierLowPassImage));    
    return 
end