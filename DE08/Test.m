function Test()
global Reds RedsNum;
global EnvironmentWidth TimeSteps;
SET_GLOBAL_VARIABLES()


[fHandler]=InitializeGraphicN();
InitializeBase()

%Load characters image and first draw into map
[v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageCharacter();
[RedsPlot]=InitializeBoid(v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsNum,Reds);

% X = [-400,200] ;
% Y = [-400,200] ;
% plot(X,Y,'.-r')

Target = [0 0 0];
titleStr = 'Implementation of Seek Behavior';
titleStr = [titleStr newline '(Use mouse to create a new target)'];
title(titleStr);
SaveTarget = plot(Target(1), Target(2), 'o','MarkerSize',10, 'MarkerFaceColor','r','Color','r');
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);

%Event Mouse click
    function cursorPosition = cursorClickCallback(o,e)
        p = get(gca,'CurrentPoint');
        cursorPosition(1:2) = p(1,1:2);
        cursorPosition(3) = 0;
        Target = cursorPosition;
        %Delete the old Target and Redraw a new Target
        delete(SaveTarget);
        %Draw Circle - Targer
        SaveTarget = plot(Target(1), Target(2), 'o','MarkerSize',10,'MarkerFaceColor','r','Color','r');
    end

TimeSteps = 500000;
timeTick = 0;
while (timeTick < TimeSteps)
    for index = 1:RedsNum
        Reds = updateAtBoundary(Reds,index);
        %Steering Force
        CurrentRed = Reds(index, :);
        force = steer_arrival(CurrentRed, Target);
%         force = steer_seek(CurrentRed, Target);
        Reds(index,:) = applyForce(CurrentRed, force);
    end
    % redraw
    RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);
    timeTick = timeTick+1;

end

end