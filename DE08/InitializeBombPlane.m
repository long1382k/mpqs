function [BombsPlot]=InitializeBombPlane(v_ImageN,v_AlphaN,X, Y)
global EnvironmentWidth;
global ImageWidth;
global Booms;

axis([-EnvironmentWidth EnvironmentWidth -EnvironmentWidth EnvironmentWidth]);
            angle = -180;	% imrotate rotates ccw  
             img_i = imrotate(v_ImageN, angle);
            alpha_i = imrotate(v_AlphaN, angle); 
            BombsPlot = image(X, Y, img_i);
            BombsPlot.AlphaData = alpha_i;   

end