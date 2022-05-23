function TestAvoiddance()
global Reds RedsNum;
global EnvironmentWidth TimeSteps;
global Obstacles;
global ObstaclesNum;
global SaveMousePosition;

SET_GLOBAL_VARIABLES()


[fHandler]=InitializeGraphicN();
InitializeBase()

%Load characters image and first draw into map
[v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageCharacter();
[RedsPlot]=InitializeBoid(v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsNum,Reds);

for i = 1:ObstaclesNum
    obstacle = Obstacles(i,:);
    %p_obstacle = plot(obstacle(1), obstacle(2), 'o','MarkerFaceColor','r','Color','r');
    plot(obstacle(1), obstacle(2), 'o','MarkerSize',obstacle(4), 'MarkerFaceColor','blue','Color','blue');
end

MousePosition = [0 0 0];
titleStr = 'Implementation of Collision Avoidance Behavior';
titleStr = [titleStr newline '(Use mouse to create a new obstacle)'];
title(titleStr);
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);

%Event Mouse click
    function cursorPosition = cursorClickCallback(o,e)
        p = get(gca,'CurrentPoint');
        cursorPosition(1:2) = p(1,1:2);
        cursorPosition(3) = 0;
        cursorPosition(4) = 40;
        MousePosition = cursorPosition;
        %Delete the old Target and Redraw a new Target
       % delete(SaveMousePosition);
        ObstaclesNum = ObstaclesNum + 1;
        Obstacles(ObstaclesNum, 1:4) = zeros(1, 4);       
        %Draw Circle - Targer      
        SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',EnvironmentWidth/20, 'MarkerFaceColor','blue','Color','blue');
        Obstacles(ObstaclesNum, 1:4) = MousePosition(1:4);       
    end

TimeSteps = 500000;
timeTick = 0;
while (timeTick < TimeSteps)
    for index = 1:RedsNum
        Reds = updateAtBoundary(Reds,index);
        %Steering Force
        CurrentRed = Reds(index, :);
        force = steer_collision_avoidance(CurrentRed);
%         force = steer_seek(CurrentRed, Target);
        Reds(index,:) = applyForce(CurrentRed, 5*force);
    end
    % redraw
    RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);
    timeTick = timeTick+1;

end

end