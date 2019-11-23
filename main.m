%
%    Este é o arquivo principal deste trabalho
%    A estrutura sugerida é: 
%    - Code
%       - main.m
%       - freq_dom_filter.m
%    - Roi_Recort_bisque_Benigna
%    - Roi_Recort_bisque_Maligna
%

%% Limpando imagens abertas anteriormente
clc;
clear all;
close all;

%% Função principal
%% Carregando imagens e fazendo verificação de folders
benignFolder = '../Roi_Recort_bisque_Benigna';
if ~isdir(benignFolder)
    sprintf('Este diretório não existe, por favor, siga a estrutura sugerida!');
    return;
else 
    benignFolder = dir(benignFolder);
end

malignFolder = '../Roi_Recort_bisque_Maligna';
if ~isdir(malignFolder)
    sprintf('Este diretório não existe, por favor, siga a estrutura sugerida!');
    return;
else 
    malignFolder = dir(malignFolder);
end

benignImage = benignFolder(3);
benignImage = imread(strcat(benignImage.folder, '/', benignImage.name));
malignImage = malignFolder(3);
malignImage = imread(strcat(malignImage.folder, '/', malignImage.name));



%openImage(benignImage(:,:,1), 'Benign Red')
%openImage(benignImage(:,:,2), 'Benign Green')
%openImage(benignImage(:,:,3), 'Benign Blue')
%openImage(rgb2gray(benignImage), 'Benign Greyscale')


%openImage(malignImage(:,:,1), 'Malign Red')
%openImage(malignImage(:,:,2), 'Malign Green')
%openImage(malignImage(:,:,3), 'Malign Blue')
%openImage(rgb2gray(malignImage), 'Malign Greyscale')

% imshowpair(malignImage, benignImage, 'montage');


%% Filtragem de frequência nas imagens
for i = 3:3 %length(malignFolder)
    benignImage = benignFolder(i);
    benignImage = imread(strcat(benignImage.folder, '/', benignImage.name));
    filteredBenignImage = freq_dom_filter(rgb2gray(benignImage));
    filteredRedBenignImage = freq_dom_filter(benignImage(:,:,1));
    openTwoImages(rgb2gray(benignImage), filteredBenignImage, 'Greyscale Benign', 'FilteredGreyscale Benign');
    openTwoImages(benignImage(:,:,1), filteredRedBenignImage, 'Red Channel Benign', 'Filtered Red Channel Benign');
end
    
%% Função de abrir imagem
function [] = openImage(image, imageTitle)
    figure; imshow(image); title(imageTitle);
end

function [] = openTwoImages(image1, image2, title1, title2)
    figure;
    subplot(1,2,1);
    imshow(image1);
    title(title1);
    subplot(1,2,2);
    imshow(image2);
    title(title2);
end
