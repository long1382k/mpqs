function [v_ImageC,v_AlphaC,v_ImageC,v_AlphaC]=LoadImageC()

[v_ImageC, ~, v_AlphaC]	= imread('images/Car.png');
v_ImageC = imresize(v_ImageC, [300 200], 'lanczos3' );
v_AlphaC = imresize(v_AlphaC, [300 200], 'lanczos3' );
