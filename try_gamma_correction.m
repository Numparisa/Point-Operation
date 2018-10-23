clear all; clc;
I0 = imread('alpaca.jpg');
I = rgb2gray(I0);
In = double(I);

gamma =2;
If = In.^gamma;
%power function
for i = 1:size(I,1)
    for j = 1:size(I,2)
        Io(i,j) = round((If(i,j)*255) / (255^gamma));
    end
end
Io = uint8(Io);
subplot(2,1,2);imshow(Io);title('output')
subplot(2,1,1);imshow(I);title('input')
figure;
subplot(2,1,1);histogram(I);title('Input')
subplot(2,1,2);histogram(Io);title('Output')
