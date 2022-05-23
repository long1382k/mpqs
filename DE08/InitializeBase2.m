function [BasesPlot]=InitializeBase2()
global EnvironmentWidth;

%% someth
angle = -180;
[v_ImageBR, ~, v_AlphaBR]	= imread('images/HB.png');
v_ImageBR = imresize(v_ImageBR, [200 200], 'lanczos3' );
v_AlphaBR = imresize(v_AlphaBR, [200 200], 'lanczos3' );
% v_ImageBR = flip(v_ImageBR, 2);
% v_AlphaBR = flip(v_AlphaBR, 2);

[img, alpha] = rolate(v_ImageBR,v_AlphaBR, angle);
BasesPlot = image(0, -200, img);
BasesPlot.AlphaData = alpha;


angle = -180;
[v_ImageBR, ~, v_AlphaBR]	= imread('images/HR.png');
v_ImageBR = imresize(v_ImageBR, [180 180], 'lanczos3' );
v_AlphaBR = imresize(v_AlphaBR, [180 180], 'lanczos3' );
% v_ImageBR = flip(v_ImageBR, 2);
% v_AlphaBR = flip(v_AlphaBR, 2);

[img, alpha] = rolate(v_ImageBR,v_AlphaBR, angle);
BasesPlot = image(230, 230, img);
BasesPlot.AlphaData = alpha;

end