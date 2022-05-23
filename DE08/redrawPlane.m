function redrawPlane(Plane, v_Plane,v_AlphaPlane, PlanePlot)
% global Plane mode;        
        angle = -140;
%         if (mode == 3)
%             angle = -150;
%             v_Plane = flip(v_Plane, 2);
%             v_AlphaPlane = flip(v_AlphaPlane, 2);
%         end
        try
            [img, alpha] = rolate(v_Plane,v_AlphaPlane, angle);
        catch Me
            disp(' Exception in DrawPlane!');
        end
        
        PlanePlot.CData = img;
        PlanePlot.AlphaData = alpha;
        
        try
            PlanePlot.XData = Plane(1,1)- 50;
            PlanePlot.YData = Plane(1,2)- 50;
        catch Me
            disp('Plane draw err ');
            disp(Plane(1,1));
            disp(Plane(1,2));
        end

        
        
end