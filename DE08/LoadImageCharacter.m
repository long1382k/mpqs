function [v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageCharacter()

global ImageWidth;
ImageWidth=50;
[v_ImageR, ~, v_AlphaR]	= imread('images/soldier10.png');
v_ImageR = imresize(v_ImageR, [ImageWidth 30], 'lanczos3' );
v_AlphaR = imresize(v_AlphaR, [ImageWidth 30], 'lanczos3' );


[v_ImageB, ~, v_AlphaB]	= imread('images/soldier09.png');
v_ImageB = imresize(v_ImageB, [ImageWidth 30], 'lanczos3' );
v_AlphaB = imresize(v_AlphaB, [ImageWidth 30], 'lanczos3' );

[v_ImageE, ~, v_AlphaE]	= imread('images/rip.png');
v_ImageE = imresize(v_ImageE, [ImageWidth ImageWidth], 'lanczos3' );
v_AlphaE = imresize(v_AlphaE, [ImageWidth ImageWidth], 'lanczos3' );

end