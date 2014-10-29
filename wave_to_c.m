% Read wave file and storage it in C Format array
% xiahouzuoxin
% 2014.03.03

clc;
clear;

% ѡ���ȡ�ļ�
[fname, pname] = uigetfile( ...
       {'*.wav';'*.*'}, ...
        'Pick a file');

[testcase fs nbits] = wavread(fullfile(pname, fname));
sound(testcase,fs);  

N = 1024;    % ��ȡ��Ƶ����
Sn = 1;      % ��Ƶ�����׵�ַƫ��������1��ʼ

% ��ʽ�����
fid = fopen('testcase.h','w+');
fprintf(fid, '#ifndef _TESTCASE_H\n');
fprintf(fid, '#define _TESTCASE_H\n\n');

fprintf(fid,'float testcase[] = {\n');
for i = Sn:Sn+N-1
    fprintf(fid,'%.4f,', testcase(i,1));
    if mod(i,10)==0
        fprintf(fid,'\n');
    end
end
% fprintf(fid,'%.4f', testcase(N,1));
fprintf(fid,'\n};\n');
fprintf(fid,'\n#endif\n');

fclose(fid);
