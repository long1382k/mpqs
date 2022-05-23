function [v_Plane,v_AlphaPlane, v_Plane1,v_AlphaPlane1] = LoadImagePlane()

[v_Plane, ~, v_AlphaPlane]	= imread('images/plane.png');
v_Plane = imresize(v_Plane, [100 100], 'lanczos3' );
v_AlphaPlane = imresize(v_AlphaPlane, [100 100], 'lanczos3' );
v_Plane1 = flip(v_Plane, 2);
v_AlphaPlane1 = flip(v_AlphaPlane, 2);