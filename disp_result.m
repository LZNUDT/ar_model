% Display or not

clc;
clear;
close all;

% ѡ���ȡ�ļ�
[fname, pname] = uigetfile( ...
       {'*.txt';'*.*'}, ...
        'Pick a file');
    
% ����ʽ������ʽ��test_mem_alloc.c�ж���õ�
tmp = load(fullfile(pname,fname));

N = tmp(1);
ORDER = tmp(2);
N_FFT = tmp(3);
x = tmp(4:4+N-1);
psd = tmp(4+N:end);
clear tmp;

% ԭʼ�ź�
figure,
plot(x);
title('Original Signal');grid on

% ����ضԱ�
% figure,
% r = xcorr(x, 'biased');
% subplot(2,1,1);plot(r);
% title('�����: Matlab����');grid on
% subplot(2,1,2);plot(x_cor);
% title('�����: C����');grid on

% AR������,��Ϊ�������ǶԳƵģ�����ֻ������һ��
figure,
xpsd = pyulear(x, ORDER, N_FFT);
xpsd=xpsd/max(xpsd);
% xpsd=10*log10(xpsd+0.000001);
subplot(2,1,1);plot(xpsd);grid on;
title('����Levension��AR�׹��ƣ�Matlab');grid on
psd = psd/max(psd);
% psd=10*log10(psd+0.000001);
subplot(2,1,2);plot(psd(1:N_FFT/2+1));
title('����Levension��AR�׹��ƣ�C');grid on

% Matlab��C��������ƫ��
err = sum((psd(1:N_FFT/2)-xpsd(1:N_FFT/2)).^2);
fprintf('%.4f\n', err);

% figure, 
% y = fft(x);
% plot(abs(y));



