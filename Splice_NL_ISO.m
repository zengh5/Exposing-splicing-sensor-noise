% Demo for "Exposing Image splicing with inconsistent sensor noise levels" 
% (submitted to Multimedia Tools and Applications)
% Last updated: 20190726 by Hui Zeng
% Fig.6 (c), (d) of the paper.
clc,clear,close all,
addpath('function');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B = 64;
spliced = imread('sample/1088_800.tif');
[M, N] = size(spliced);
figure,imshow(spliced,'border','tight');
I = double(spliced);
% Ensure the width and the height of the test image being multiples of B.
I = I(1:floor(M/B)*B,1:floor(N/B)*B);
[M N] = size(I);
 for i = 1 : M/B
      for j = 1 : N/B
         Ib = I((i-1)*B+1:i*B,(j-1)*B+1:j*B);
         [label64(i,j), Noise_64(i,j)] =  PCANoiseLevelEstimator(Ib,5);
         meanIb(i,j) = mean2(Ib);
      end
 end
%% For some abnormal blocks, e.g., saturated patches, the estimation
%% result is unreliable. We set the lable ==1 in estimation and always
%% take these blocks as original in splicing localization. 
valid = find(label64==0);
re = ones(numel(label64),1);

%% the result of ref. [16] of the paper
[u, re2]  = KMeans(Noise_64(valid),2);
re(valid) = re2(:,2);
result = (reshape(re,size(Noise_64)));
dethighlightHZ(I,B,result');    % red result

%% the result of the proposed method
%% The estimated noise level of a block is weighted first by its 
%% gray value, and then used for splicing localization.
attenfactor = model(meanIb);
Noise_64c = Noise_64.*attenfactor;
[u3, re3]  = KMeans(Noise_64c(valid),2);
re(valid) = re3(:,2);
result_proposed = (reshape(re,size(Noise_64c)));
dethighlightHZ(I,B,result_proposed');
