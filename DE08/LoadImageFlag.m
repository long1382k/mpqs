function [v_ImageFR,v_AlphaFR,v_ImageFB,v_AlphaFB]=LoadImageFlag()

[v_ImageFR, ~, v_AlphaFR]	= imread('images/FlagR.png');
v_ImageFR = imresize(v_ImageFR, [100 400], 'lanczos3' );
v_AlphaFR = imresize(v_AlphaFR, [100 400], 'lanczos3' );

[v_ImageFB, ~, v_AlphaFB]	= imread('images/FlagB.png');
v_ImageFB = imresize(v_ImageFB, [100 400], 'lanczos3' );
v_AlphaFB = imresize(v_AlphaFB, [100 400], 'lanczos3' );