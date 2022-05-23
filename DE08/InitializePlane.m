function [PlanePlot]=InitializePlane(Plane, v_Plane,v_AlphaPlane)
angle = -150;
% if (mode == 3)
%     angle = -140;
%     v_Plane = flip(v_Plane, 2);
%     v_AlphaPlane = flip(v_AlphaPlane, 2);
% end
[img, alpha] = rolate(v_Plane,v_AlphaPlane, angle);
PlanePlot = image(Plane(1,1), Plane(1,2), img);
PlanePlot.AlphaData = alpha;

% if (mode == 2)
%     Plane(1,1) = 400;
%     Plane(1,2) = -300;
%     PlanePlot = image(Plane(1,1), Plane(1,2), img);
%     PlanePlot.AlphaData = alpha;
% else
%     Plane(1,1) = -400;
%     Plane(1,2) = 100;
%     PlanePlot = image(Plane(1,1), Plane(1,2), img);
%     PlanePlot.AlphaData = alpha;
% end