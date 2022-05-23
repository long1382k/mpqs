function Behavior__Arrival_Formation_Arc()
%% global variables
global TimeSteps;
global Reds RedsNum;
global Targets;
global SaveMousePosition;
global saveText;
global ImageWidth;
SET_GLOBAL_VARIABLES()


RedsNum = 7; % Choose number of Reds to demo
Reds(1,10) = 0.7; % set max speed of 1-st Boid
Reds(2:RedsNum, 10) = 2;
Wingspan = ImageWidth;

% Number of Reds on the top of Arc-formation
NumberRedsOnTop = 10;
% Number of Reds on the the branch of Arc-formation
NumberRedsOnBranch = 2;
%Angle at top of Arc-formation
Alpha_Arc_Formation = 11*pi/9;
% Distance beside leader in the Arc-formation
D_Beside = Wingspan*(4 + pi)/8 + 20;
% Distance behind leader in the Arc-formation
D_Behind = Wingspan*(4 + pi)/(8*tan(Alpha_Arc_Formation/2)) - 40;

%% first draw
% [v_Image,v_Alpha,RedsPlot,fHandler] = InitializeGraphics();
[fHandler]=InitializeGraphicN();
InitializeBase()

%Load characters image and first draw into map
[v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageCharacter();
[RedsPlot]=InitializeBoid(v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsNum,Reds);


%Initialize the first positon of Goal
% MousePosition = [250 300 0 0 0 0];
MousePosition = [-350 -350 0 0 0 0];
SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',5,'MarkerFaceColor','blue','Color','blue');
saveText = text(MousePosition(1) + 30, MousePosition(2)+ 10, 'Goal');
titleStr = 'Implementation of Arc-Formation and Arrival behavior';
titleStr = [titleStr newline '(Use mouse click to create a new goal)'];
title(titleStr);
set(fHandler, 'WindowButtonDownFcn',@cursorClickCallback);

%Event Mouse click
    function cursorPosition = cursorClickCallback(o,e)
        p = get(gca,'CurrentPoint');
        cursorPosition(1:2) = p(1,1:2);
        cursorPosition(3:6) = 0;
        MousePosition = cursorPosition;
        %Delete the old Target and Redraw a new Target
        delete(SaveMousePosition);
        %Draw Circle - Targer
        SaveMousePosition = plot(MousePosition(1), MousePosition(2), 'o','MarkerSize',5,'MarkerFaceColor','blue','Color','blue');
        delete(saveText);
        saveText = text(MousePosition(1) + 30, MousePosition(2)+ 10, 'Goal');
    end


%% FLOCK MOVE TO THE GOAL
% Generate random colors for drawing the footprints of Reds
% for BoidIndex = 1:RedsNum
%     randomColors(BoidIndex,1:3) = rand(1,3);
% end

timeTick = 1;
while (timeTick < TimeSteps)
    if (timeTick == 300)
        Reds(5,15) = 0;
%         RedsNum = 6;
    end
    

    %% Moving the 1-st Boid (as a leader)
    force = steer_arrival(Reds(1,:), MousePosition); %Move toward the mouse
    Reds(1,:) = applyForce(Reds(1,:), force);
    
    %% Moving Reds
    Leader = Reds(1, :);      
    Alpha_Horizontal = CalculationHorizontalAngle(Leader);        
    [Reds, RedsIndex] = steer_Arrival_Formation_Arc(MousePosition, Reds, Leader, D_Behind, D_Beside,...
                    Alpha_Horizontal, NumberRedsOnTop, NumberRedsOnBranch);
  
    RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);    
    % End of Moving Reds
    if (timeTick == 300)
        temp = Reds(5,:);
        Reds(5,:) = Reds(7,:);
        Reds(7,:) = temp;
        tempP = RedsPlot(5);
        RedsPlot(5) = RedsPlot(7);
        RedsPlot(7) = tempP;
        RedsNum = 6;
%         resetTeamPosition();
    end
    timeTick = timeTick+1;
end

end