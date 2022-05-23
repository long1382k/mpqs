function [Reds, RedsIndex]  = steer_Arrival_Formation_Arc(Target, Reds, Leader, D_Behind, D_Beside,...
                    Alpha_Horizontal, NumberRedsOnTop, NumberRedsOnBranch)
global RedsNum;

% Array of flags for Reds to mark what boid is arranged to the left or the right
% RedsFlag(i) = 1 means the Boid i-th was arranged to the left or the right
RedsFlag = zeros(1, RedsNum);
RedsFlag(1) = 1;

% Calculate the Weights for each Boid
WeightsMatrix = WeightFunction_Arrival_Formation_V(Target, Reds, RedsNum, Alpha_Horizontal, D_Behind, D_Beside);
RedsIndex(1) = 1;

[RightBesideLeader, LeftBesideLeader] = FindBesideLeader(Leader, Alpha_Horizontal, D_Behind, D_Beside);
[LeaderRight,RedsFlag,MinRightIndex] = NearestBoid(RightBesideLeader, RedsFlag);
RedsIndex(2) = MinRightIndex;
Weight = WeightsMatrix(MinRightIndex);
[LeaderRight,Reds] = Move_Arrival_Formations(Target, Weight, Reds, LeaderRight,Leader,RightBesideLeader, MinRightIndex);

[LeaderLeft,RedsFlag,MinLeftIndex] = NearestBoid(LeftBesideLeader, RedsFlag);
RedsIndex(3) = MinLeftIndex;
Weight = WeightsMatrix(MinLeftIndex);
[LeaderLeft, Reds] = Move_Arrival_Formations(Target, Weight, Reds,LeaderLeft,Leader,LeftBesideLeader,MinLeftIndex);

while (sum(RedsFlag) < RedsNum)    
    BoidIndex = sum(RedsFlag) + 1;
    D_Beside_tmp = D_Beside;
    D_Behind_tmp = D_Behind;
    if ((BoidIndex > NumberRedsOnTop) && (BoidIndex <= NumberRedsOnTop + 2*NumberRedsOnBranch))
        D_Behind_tmp = D_Behind + 10;
        D_Beside_tmp = D_Beside_tmp - 10;
    else
        if (BoidIndex >= NumberRedsOnTop + NumberRedsOnBranch)          
            D_Behind_tmp = D_Behind + 20;
        end
    end
    
    [RightBesideLeader, ~] = FindBesideLeader(LeaderRight, Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    [NearestRight, RedsFlag, MinRightIndex] = NearestBoid(RightBesideLeader, RedsFlag);
    RedsIndex(BoidIndex) =  MinRightIndex;  
    Weight = WeightsMatrix(MinRightIndex);
    [NearestRight, Reds] = Move_Arrival_Formations(Target, Weight, Reds, NearestRight,LeaderRight,RightBesideLeader, MinRightIndex);
    LeaderRight = NearestRight;
    
    [~, LeftBesideLeader] = FindBesideLeader(LeaderLeft, Alpha_Horizontal, D_Behind_tmp, D_Beside_tmp);
    [NearestLeft,RedsFlag,MinLeftIndex] = NearestBoid(LeftBesideLeader, RedsFlag);
    RedsIndex(BoidIndex + 1) =  MinLeftIndex;
    Weight = WeightsMatrix(MinLeftIndex);
    [NearestLeft, Reds] = Move_Arrival_Formations(Target, Weight, Reds, NearestLeft,LeaderLeft,LeftBesideLeader, MinLeftIndex);
    LeaderLeft = NearestLeft;
end
end