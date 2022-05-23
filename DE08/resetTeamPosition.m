%% calculate agents' positions to move to each iteration
function resetTeamPosition()
global Reds RedsNum;
global Targets ImageWidth;
setappdata(0, 'OldTarget', Targets(1, 1:3));

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
Leader = Reds(1, :);

% Calculate the horizontal angle of the Leader
Alpha_Horizontal = CalculationHorizontalAngle(Leader);

%Find the RightBeside and LeftBeside positions of Leader
[RightBesidePosition, LeftBesidePosition] = FindBesideLeader(Leader, ...
                                    Alpha_Horizontal, D_Behind, D_Beside);

% Assign 2-nd Boid to the right of 1-st Boid
Reds(2, 1:6) = RightBesidePosition;
Reds(2,:) = applyForce(Reds(2,:), 0);
RightBesidePosition = Reds(2, :);

% Assign 3-rd boid to the left of of 1-st Boid
Reds(3, 1:6) = LeftBesidePosition;
Reds(3,:) = applyForce(Reds(3,:), 0);
LeftBesidePosition = Reds(3, :);

BoidIndex = 4;
while BoidIndex <= RedsNum    
    D_Beside_tmp = D_Beside;
    D_Behind_tmp = D_Behind;
%     if ((BoidIndex > NumberRedsOnTop) && (BoidIndex <= NumberRedsOnTop + 2*NumberRedsOnBranch))
%         D_Behind_tmp = D_Behind + 10;
%         D_Beside_tmp = D_Beside_tmp - 10;
%     else
%         if (BoidIndex >= NumberRedsOnTop + 2*NumberRedsOnBranch)            
%             D_Behind_tmp = D_Behind + 20;
%         end
%     end
    %Find the RightBeside position of RightBesidePosition (2-nd Boid)
    [RightBesidePosition, ~] = FindBesideLeader(RightBesidePosition, ...
                                    Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    Reds(BoidIndex, 1:6) = RightBesidePosition;
    RightBesidePosition = Reds(BoidIndex,:);
    Reds(BoidIndex,:) = applyForce(Reds(BoidIndex,:), 0);
    
    BoidIndex = BoidIndex + 1;
    [~, LeftBesidePosition] = FindBesideLeader(LeftBesidePosition, ...
                                    Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    Reds(BoidIndex, 1:6) = LeftBesidePosition;
    LeftBesidePosition = Reds(BoidIndex,:);
    Reds(BoidIndex,:) = applyForce(Reds(BoidIndex,:), 0);
    
    BoidIndex = BoidIndex + 1;
end
% RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);

end