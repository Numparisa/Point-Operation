clear; clc;
%try by myself
I0 = imread('alpaca.jpg');
I = rgb2gray(I0);

fre = zeros(256,1);
prob_freq = zeros(256,1);
cum_hist = zeros(256,1);
I2 = uint8( zeros( size(I,1), size(I,2))) ;
prob_cum = zeros(256,1);

for i=1:size(I,1)
    for j=1:size(I,2)
        number = I(i,j);
        fre (number+1) = fre( number+1) +1;
        prob_freq (number+1) = fre( number+1) / ( size(I,1)*size(I,2) );
    end
end

cum_hist(1) = fre(1); 
for i = 2:256
    cum_hist(i) = fre(i)+cum_hist(i-1);
end 
for i = 1:256
    prob_cum(i) = round (cum_hist(i) * 255 / (size(I,1)*size(I,2)) );
end
for i=1:size(I,1)
    for j = 1:size(I,2)
        I2(i,j) = prob_cum( I(i,j) +1 );
    end
end

fre2 = zeros(256,1);
prob_freq2 = zeros(256,1);
cum_hist2 = zeros(256,1);

for i=1:size(I2,1)
    for j=1:size(I2,2)
        number2 = I2(i,j);
        fre2 (number2+1) = fre2( number2+1) +1;
        prob_freq2 (number2+1) = fre2( number2+1) / ( size(I2,1)*size(I2,2) );
    end
end

cum_hist2(1) = fre2(1); 
for i = 2:256
    cum_hist2(i) = fre2(i)+cum_hist2(i-1);
end 


figure;
subplot(2,1,1);imshow(I);title('original');
subplot(2,1,2);imshow(I2);title('output image');

figure;
subplot(4,1,1);histogram(I);title('before');
subplot(4,1,2);plot(prob_cum);title('cumulative of before');
subplot(4,1,3);histogram(I2);title('after equalization');
subplot(4,1,4);plot(cum_hist2);title('cumulative of after')