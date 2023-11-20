% Autor: Erik Zamora Gómez
% Fecha 06/08/2015
% Este código es distribuido bajo la licencia CC BY-NC-SA
clc, clear all, close all

video = 'video5.mp4';   % Nombre del video
folder = 'liquid1';  % Nombre de la carpeta para almacenar las imágenes
NumeroImagenes = 30; %Núm1ero de imágenes a extraer

videoobj = VideoReader(video);

intervalo = round(linspace(1,videoobj.NumberOfFrames,NumeroImagenes));
for i=intervalo
    frame = read(videoobj,i);
    %namefile = [carpeta, '\ima', num2str(i), '.bmp'];
    namefile = [folder,'/', num2str(i), '1.jpg'];
    frame=imresize(frame,[224 224]);
    imwrite(frame,namefile)
end