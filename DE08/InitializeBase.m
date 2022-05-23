function [BasesPlot]=InitializeBase()
global EnvironmentWidth;
angle = 0;

%background
[v_ImageBF, ~, v_AlphaBF]	= imread('images/map2.png');
v_ImageBF = imresize(v_ImageBF, [EnvironmentWidth*2 EnvironmentWidth*2], 'lanczos3' );
v_AlphaBF = imresize(v_AlphaBF, [EnvironmentWidth*2 EnvironmentWidth*2], 'lanczos3' );
[img, alpha] = rolate(v_ImageBF,v_AlphaBF, angle);
BasesPlot= image(-EnvironmentWidth, -EnvironmentWidth, img);
BasesPlot.AlphaData = alpha;  

% %% someth
% angle = -180;
% [v_ImageBR, ~, v_AlphaBR]	= imread('images/base1.png');
% v_ImageBR = imresize(v_ImageBR, [200 160], 'lanczos3' );
% v_AlphaBR = imresize(v_AlphaBR, [200 160], 'lanczos3' );
% % v_ImageBR = flip(v_ImageBR, 2);
% % v_AlphaBR = flip(v_AlphaBR, 2);
% 
% [img, alpha] = rolate(v_ImageBR,v_AlphaBR, angle);
% BasesPlot = image(-400, -400, img);
% BasesPlot.AlphaData = alpha;
% 
% 
% angle = -180;
% [v_ImageBR, ~, v_AlphaBR]	= imread('images/base2.png');
% v_ImageBR = imresize(v_ImageBR, [180 140], 'lanczos3' );
% v_AlphaBR = imresize(v_AlphaBR, [180 140], 'lanczos3' );
% % v_ImageBR = flip(v_ImageBR, 2);
% % v_AlphaBR = flip(v_AlphaBR, 2);
% 
% [img, alpha] = rolate(v_ImageBR,v_AlphaBR, angle);
% BasesPlot = image(-400, 2, img);
% BasesPlot.AlphaData = alpha;

end