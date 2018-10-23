clear; clc;

I0 = imread('alpaca.jpg');
I = rgb2gray(I0);
I1 = imread('ref_image.jpg');
Ir = rgb2gray(I1);

freq = zeros(256,1);
prob_freq = zeros(256,1);
cum_hist = zeros(256,1);
% fre2 = zeros(256,1);
% prob_freq2 = zeros(256,1);
% cum_hist2 = zeros(256,1);
% prob_cum2 = zeros(256,1);
% I2 = uint8( zeros( size(I,1), size(I,2))) ;
%histogram equalization
for i=1:size(I,1)
    for j=1:size(I,2)
        number = I(i,j);
        freq(number+1) = freq(number+1) +1;
        prob_freq(number+1) = freq( number+1) / ( size(I,1)*size(I,2) );
    end
end
cum_hist(1) = freq(1); 
for i = 2:256
    cum_hist(i) = freq(i)+cum_hist(i-1);
end
    %cdf
for i = 1:256
    prob_cum(i,1) = round (cum_hist(i) * 255 / (size(I,1)*size(I,2)) );
end
%     %image after equlization
% for i=1:size(I,1)
%     for j = 1:size(I,2)
%         I2(i,j) = prob_cum( I(i,j) +1 );
%     end
% end
%     %histogram and its cumulative of image after equalization
% for i=1:size(I2,1)
%     for j=1:size(I2,2)
%         number2 = I2(i,j);
%         fre2 (number2+1) = fre2( number2+1) +1;
%         prob_freq2 (number2+1) = fre2( number2+1) / ( size(I2,1)*size(I2,2) );
%     end
% end
% cum_hist2(1) = fre2(1); 
% for i = 2:256
%     cum_hist2(i) = fre2(i)+cum_hist2(i-1);
% end 

%reference histogram
freq_ref = zeros(256,1);
prob_freq_ref = zeros(256,1);
cum_hist_ref = zeros(256,1);
% fre2_ref = zeros(256,1);
% prob_freq2_ref = zeros(256,1);
% cum_hist2_ref = zeros(256,1);
% I2r = uint8( zeros( size(Ir,1), size(Ir,2))) ;
    %histogram
for i=1:size(Ir,1)
    for j=1:size(Ir,2)
        number_ref = Ir(i,j);
        freq_ref(number_ref+1) = freq_ref(number_ref+1) +1;
        prob_freq_ref(number_ref+1) = freq_ref( number_ref +1) / ( size(Ir,1)*size(Ir,2) );
    end
end
    %cumulative histogram
cum_hist_ref(1) = freq_ref(1); 
for i = 2:256
    cum_hist_ref(i) = freq_ref(i)+cum_hist_ref(i-1);
end
    %cdf
for i = 1:256
    prob_cum_ref(i,1) = round (cum_hist_ref(i) * 255 / (size(Ir,1)*size(Ir,2)) );
end
% % for i=1:size(Ir,1)
% %     for j = 1:size(Ir,2)
% %         I2r(i,j) = prob_cum_ref( Ir(i,j) +1 );
% %     end
% % end
% % for i=1:size(I2,1)
% %     for j=1:size(I2,2)
% %         number2_ref = I2(i,j);
% %         fre2_ref (number2_ref +1) = fre2_ref( number2_ref +1) +1;
% %         prob_freq2_ref (number2_ref +1) = fre2_ref( number2_ref +1) / ( size(I2,1)*size(I2,2) );
% %     end
% % end
% % cum_hist2_ref(1) = fre2_ref(1); 
% % for i = 2:256
% %     cum_hist2_ref(i) = fre2_ref(i)+cum_hist2_ref(i-1);
% % end 
% % out = histeq(I,freq_ref);
% % subplot(1,3,1); imshow(I);
% % subplot(1,3,2); imshow(Ir);
% % subplot(1,3,3); imshow(out);
% % 

for i = 1:256
    M = abs(prob_cum(i) - prob_cum_ref(1));
    for j = 1:256
        Mn = abs(prob_cum(i) - prob_cum_ref(j));
        if M < Mn
            C(i,1) = j-1;
            break;
        elseif Mn == 255
            C(i,1) = j-1;
        end
        M = Mn;
    end
end
for i = 1:256
    prob_cum_new(i,1) = prob_cum(C(i,1));
end
% for i = 1:256
%     prob_cum_new(i,1) = round((cum_new(i,1)*255) / (size(I,2)*size(I,1)));
% end
for i = 1:size(I,1)
    for j = 1:size(I,2)
        Io(i,j) = prob_cum_new(I(i,j) + 1);
    end
end
Io = uint8(Io);
subplot(2,3,3);imshow(Io);title('output')
subplot(2,3,2);imshow(Ir);title('ref.')
subplot(2,3,1);imshow(I);title('input')
subplot(2,3,4);plot(freq);title('input histogram')
subplot(2,3,5);plot(freq_ref);title('ref. histogram')
subplot(2,3,6);histogram(Io);title('output histogram')