function main()
%% global variables
global TimeSteps;
global Reds RedsNum Blues BluesNum;
global MaxRedNum MaxBlueNum;
global Targets;
global ImageWidth;

global Booms BoomsNum;
global RedsHP BluesHP;
global RedsPlot;
global ShootDistanceB ShootDistanceR AccuracyB AccuracyR;
global EnvironmentWidth; 
global kB ObstaclesNumB ObstaclesB;
global Obstacles;
global ObstaclesNum;
global hitB missB hitR missR;
global isAttacking;
global blueAlive;
global Plane PlanePlot mode Plane1 PlanePlot1;
isAttacking = 0;

hitB = 1;
missB = 1;
hitR = 1;
missR = 1;

SET_GLOBAL_VARIABLES()

AccuracyB =0.8; % do chinh xac
AccuracyR =0.75;

BluesNum = 15; % ( so quan xanh )
Blues(1:BluesNum, 10) = 2.5; %set max force


RedsNum = 5; % Choose number of Reds to demo ( so quan do )
% RNums = RedsNum;
Reds(1,10) = 1; % set max speed of 1-st Boid
Reds(2:RedsNum, 10) = 2.5;
Wingspan = ImageWidth;

[RedsHP]=InitializeHP(RedsNum,MaxRedNum,Reds);
[BluesHP]=InitializeHP(BluesNum,MaxBlueNum,Blues);

% Number of Reds on the top of Arc-formation
NumberRedsOnTop = 8;
% Number of Reds on the the branch of Arc-formation
NumberRedsOnBranch = 12;
%Angle at top of Arc-formation
% ( góc trên cùng cua hình vòng cung)
Alpha_Arc_Formation = 11*pi/9;
% Distance beside leader in the Arc-formation
% ( kho?ng cách bên c?nh ng??i ??u trong ??i hình vòng cung)
D_Beside = Wingspan*(4 + pi)/8 + 10;
% Distance behind leader in the Arc-formation
% ( kho?ng cách phía sau ng??i ??u trong ??i hình vòng cung)
D_Behind = Wingspan*(4 + pi)/(8*tan(Alpha_Arc_Formation/2)) - 60;

%% load sound
[bomb,gunR,gunB,airplane,planeBoom,soundtrack, bombFs,gunFsR,gunFsB,airplaneFs, planeBoomFs,soundtrackFs]=loadSound();
%% first draw
% [v_Image,v_Alpha,RedsPlot,fHandler] = InitializeGraphics();
InitializeGraphicN();
InitializeBase();

%% Load characters image and first draw into map ( tai hinh nhan vat va lan dau tien vao ban do)
[v_ImageR,v_AlphaR,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE]=LoadImageCharacter();
% [v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6]=LoadImageRock();
[v_ImageBoom,v_AlphaBoom,v_ImageN,v_ImagePlaneBoom, v_AlphaN,v_ImageEmpty,v_AlphaEmpty, v_AlphaPlaneBoom]=LoadImageBoom();
[v_Plane,v_AlphaPlane, v_Plane1,v_AlphaPlane1] = LoadImagePlane();
% [v_ImageC,v_AlphaC,v_ImageC,v_AlphaC]=LoadImageCar();
[v_ImageFR,v_AlphaFR,v_ImageFB,v_AlphaFB]=LoadImageFlag();


%% create plot
% [BoomsPlot]=InitializeBoom(v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,Booms,BoomsNum);
[RedsPlot]=InitializeBoid(v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsNum,Reds);
[BluesPlot]=InitializeBoid(v_ImageB,v_AlphaB,v_ImageE,v_AlphaE,BluesNum,Blues);
% InitializeRock(v_ImageS1,v_AlphaS1,v_ImageS2,v_AlphaS2,v_ImageS3,v_AlphaS3,v_ImageS4,v_AlphaS4,v_ImageS5,v_AlphaS5,v_ImageS6,v_AlphaS6)
% [PlanePlot]=InitializePlane(v_Plane,v_AlphaPlane);
InitializeBase2(); % tao can cu quan su




%% function Varible
lastRGunSound = -1;
lastBGunSound = -1;
% lastPlaneSound = 1;
mode = 0;
blueDeployingDefensive(mode);
% droppedBoom = 1;
% droppedBoom1 = 1;
% 
% timeDropBoom = 30;
% timeDropBoom1 = 30;

dropTime = 60;

nAppliedForce = [3 8 13 MaxBlueNum];
blueAlive = BluesNum;
% sound(soundtrack, soundtrackFs);
timeTick = 1;
while (timeTick < TimeSteps)
   
    %% update Blue alive
    blueAlive = 0;
    for i = 1 : BluesNum
        if (Blues(i, 15) > 0)
            blueAlive = blueAlive + 1;
        end
    end
%     disp(blueAlive);
    %% sorting
    sortByRedsHP();
    
    
    %% set mode
    if (blueAlive == BluesNum - 1 && mode ~= 1)
        mode = 1;
        blueDeployingDefensive(mode)
        
        
    end
%     if (blueAlive == BluesNum - 3 && mode ~= 2)
%         mode = 2;
%         droppedBoom = 0;
%         blueDeployingDefensive(mode)
%         [PlanePlot]=InitializePlane(Plane, v_Plane,v_AlphaPlane);
% %         sound(airplane, airplaneFs);
%         disp('Red: Tiep tuc tien cong!');
%         disp('Blue: Goi chi vien tu can cu khac, chi vien may bay nem bom');
%     end
%     
%     if (blueAlive == BluesNum - 7 && mode ~= 3)
% %         sound(planeBoom, planeBoomFs);
%         mode = 3;
%         droppedBoom1 = 0;
%         [PlanePlot1]=InitializePlane(Plane1, v_Plane1,v_AlphaPlane1);
% %         sound(airplane, airplaneFs);
%         blueDeployingDefensive(mode)
%         disp('Red: Tiep tuc tien cong!');
%         %disp('Blue: Tiep tuc goi chi vien, chi vien them may bay nem bom');
%     end
    
    
    
    %% Moving blue
     for BlueIndex = 1:nAppliedForce(mode + 1)
            Blues = updateAtBoundary(Blues,BlueIndex);
            CurrentBoid = Blues(BlueIndex, :);
%             see_force = steer_arrival(CurrentBoid, ObstaclesB(BlueIndex + 1,1:3));
            see_force = steer_seek(CurrentBoid, ObstaclesB(BlueIndex, 1:3));
%             force_avoid_dance = steer_collision_avoidance(CurrentBoid);\
            force_avoid_dance = 0;
            flk_force = steer_flock(CurrentBoid,Blues,BluesNum);
            force = 0.2*see_force + 0.1*force_avoid_dance + 0.1*flk_force;

            Blues(BlueIndex,:) = applyForce(CurrentBoid, force);
%              Blues(BlueIndex,:) = applyForce(CurrentBoid, see_force);
    end

    
    %% Moving Reds
%     disp(timeTick);
%      disp(RedsNum);
    if (timeTick < 230)
%     if (mode < 1)
        Reds(1,10) = 2.0;
        for index = 1:RedsNum-5                                       
            Reds = updateAtBoundary(Reds,index);
            %Steering Force
            CurrentBoid = Reds(index, :);
            seek_force = steer_seek(CurrentBoid, [-350 350 0]);
            separation_force = steer_separation(CurrentBoid);
            force = seek_force + 3*separation_force;
            Reds(index,:) = applyForce(CurrentBoid, force);
        end
    else
%         RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot); 
        % Moving the 1-st Boid (as a leader)
        MainTaget = [-200 -200 0 0 0 0];
        force = steer_arrival(Reds(1,:), MainTaget); %Move toward the mouse
        Reds(1,:) = applyForce(Reds(1,:), force);
       
        % Moving Reds
        Leader = Reds(1, :);      
        Alpha_Horizontal = CalculationHorizontalAngle(Leader);        
        [Reds, RedsIndex] = steer_Arrival_Formation_Arc(MainTaget, Reds, Leader, D_Behind, D_Beside,...
                        Alpha_Horizontal, NumberRedsOnTop, NumberRedsOnBranch);
    end
%     disp(timeTick);
%     disp(Reds);
%( danh cho may quan do o lai can cu)
    if (timeTick > 500)
%     if (mode < 1)
        Reds(1,10) = 2.0;
        for index = 1:RedsNum                                       
            Reds = updateAtBoundary(Reds,index);
            %Steering Force
            CurrentBoid = Reds(index, :);
            seek_force = steer_seek(CurrentBoid, [80 0 0]);
            separation_force = steer_separation(CurrentBoid);
            force = seek_force + 3*separation_force;
            Reds(index,:) = applyForce(CurrentBoid, force);
        end
    end
    
% %% Boom
%     AttackRed=zeros(1,RedsNum);  
%     for i=1:BoomsNum
%         if(Booms(i,4)>0)
%             [n]=findTargetBoom(Booms(i,:), 50);
%             if (n>0)
%               sound(bomb,bombFs);
%               for index = 1:n
%                 AttackRed(1,Targets(1,index))= AttackRed(1,Targets(1,index))+200;
%               end
%               Booms(i,4)=0;
%               RedrawBoom(Booms,BoomsNum,v_ImageBoom,v_AlphaBoom,v_ImageEmpty,v_AlphaEmpty,BoomsPlot);
%               [BombsPlot]=InitializeBomb(v_ImageN,v_AlphaN,i);
%               pause(0.3);
% %               sound(bomb,bombFs);
%               delete(BombsPlot);
%             end
%         end
%     end
%     
%     % update red
%     [RedsNum,Reds] = UpdateBoid(AttackRed,RedsNum,Reds); 
% %     RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);
% %     RedrawRedsHP();

  %% Blues attack Reds
    AttackRed=zeros(1,RedsNum);  
    for i=1:BluesNum
        if(Blues(i,15)>0)
            Blues = updateAtBoundary(Blues,i);
            CurrentBoid = Blues(i,:);
            [J,tmpDist]=findTarget(CurrentBoid,RedsNum,Reds);  
            if (J>0 && dist(Blues(i,:),Reds(J,:))<ShootDistanceB)
                % Shoot
                c2=line([Reds(J,1), Blues(i,1)-2],[Reds(J,2), Blues(i,2)],'Color','blue','LineStyle','-.');
                pause(0.02);
                delete(c2);
                if (randi(100) <= AccuracyB*100)
                    lastBGunSound = mod(lastBGunSound + 1, 3);
                    if (lastBGunSound == 0)
                        sound(gunR,gunFsR);
                    end
                    AttackRed(1,J)=AttackRed(1,J)+5;
                end
            end
        end
    end 
%     disp(AttackRed);
    [RedsNum,Reds] = UpdateBoid(AttackRed,RedsNum,Reds); 
%     RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot);
    RedrawRedsHP();
    
    %% Reds attack Blues
    AttackBlue=zeros(1,BluesNum);  
    for i=1:RedsNum
        if(Reds(i,15)>0)
            Reds = updateAtBoundary(Reds,i);
            CurrentBoid = Reds(i,:);
            [J,tmpDist]=findTarget(CurrentBoid,BluesNum,Blues);  
            if (J>0 && dist(CurrentBoid,Blues(J,:))<ShootDistanceR)
                % Shoot
                c2=line([Blues(J,1), Reds(i,1)-2],[Blues(J,2), Reds(i,2)],'Color','red','LineStyle','-.');
                pause(0.02);
                delete(c2);
                if ( randi(100) <= AccuracyR*100)
                    lastRGunSound = mod(lastRGunSound + 1, 3);
                    if (lastRGunSound == 0)
                        sound(gunR,gunFsR);
                    end
                    AttackBlue(1,J)=AttackBlue(1,J)+5;
                end              
            end
        end
    end 
    
%     disp(AttackBlue);
     [BluesNum,Blues] = UpdateBoid(AttackBlue,BluesNum,Blues); 
    RedrawBlueHP();

    %% Moving plane and drop boom
    if (mode >= 2)    
        tagetPlane = [-400 300 0];
        Pforce = steer_arrival(Plane, tagetPlane);
        if (dist(Plane(1, 1:3), tagetPlane) > 20)
            Plane = applyForce(Plane, 3*Pforce);
            redrawPlane(Plane, v_Plane,v_AlphaPlane, PlanePlot);
        else
            delete(PlanePlot);
            droppedBoom = 1;
        end
        
            timeDropBoom = mod(timeDropBoom + 1, dropTime);
            if (timeDropBoom == dropTime - 5 && droppedBoom == 0)
                sound(planeBoom, planeBoomFs);
            end
            
            if (timeDropBoom == 0 && droppedBoom == 0)
                 disp('plane0 droppedBoom!');
                %tha bom
                    idx = randi(RedsNum);
                    X = Reds(idx,1) + 100 - randi(200);
                    Y = Reds(idx,2) + 100 - randi(200);
%                     X = Reds(1,1) + 100 - randi(200);
%                     Y = Reds(1,2) + 100 - randi(200);
                    AttackRed=zeros(1,RedsNum);
                    [n]=findTargetBoom([X Y 0 1], 80);
                    if (n>0)
                      for index = 1:n
                        AttackRed(1,Targets(1,index))= AttackRed(1,Targets(1,index))+200;
                      end
                    end
                    [BombsPlot]=InitializeBombPlane(v_ImagePlaneBoom,v_AlphaPlaneBoom,X-50, Y-40);
                    pause(0.2);
                     sound(bomb,bombFs);
                    delete(BombsPlot);
                    [RedsNum,Reds] = UpdateBoid(AttackRed,RedsNum,Reds); 
                % ------------------------
            end

        if (mode == 3)
            tagetPlane1 = [200 -400 0];
            Pforce1 = steer_arrival(Plane1, tagetPlane1);
            if (dist(Plane1(1, 1:3), tagetPlane1) > 20)
                Plane1 = applyForce(Plane1, 3*Pforce1);
                redrawPlane(Plane1, v_Plane1,v_AlphaPlane1, PlanePlot1);
            else
                delete(PlanePlot1);
                droppedBoom1 = 1;
            end
            
            timeDropBoom1 = mod(timeDropBoom1 + 1, dropTime);
            if (timeDropBoom1 == dropTime - 5 && droppedBoom1 == 0)
                sound(planeBoom, planeBoomFs);
            end
            
            if (timeDropBoom1 == 0 && droppedBoom1 == 0)
                 disp('plane1 droppedBoom!');
                %tha bom
                    idx = randi(RedsNum);
                    X = Reds(idx,1) + 100 - randi(200);
                    Y = Reds(idx,2) + 100 - randi(200);
                    AttackRed=zeros(1,RedsNum);
                    [n]=findTargetBoom([X Y 0 1], 80);
                    if (n>0)
                      for index = 1:n
                        AttackRed(1,Targets(1,index))= AttackRed(1,Targets(1,index))+200;
                      end
                    end
                    [BombsPlot]=InitializeBombPlane(v_ImagePlaneBoom,v_AlphaPlaneBoom,X-50, Y-40);
                    pause(0.2);
                     sound(bomb,bombFs);
                    delete(BombsPlot);
                    [RedsNum,Reds] = UpdateBoid(AttackRed,RedsNum,Reds); 
                % ------------------------
            end

            
        end
        %Plane sound
        lastPlaneSound = mod(lastPlaneSound + 1, 50);
        if (lastPlaneSound == 0)
            disp('reload sound');
            sound(airplane, airplaneFs);
        end
    end
  
    
    %% drawing   
    RedrawBoid(Reds,RedsNum,v_ImageR,v_AlphaR,v_ImageE,v_AlphaE,RedsPlot); 
    RedrawBoid(Blues,BluesNum,v_ImageB,v_AlphaB,v_ImageE,v_AlphaE,BluesPlot);
%     disp(Reds(1:15, 15));
%     disp('----');
    timeTick = timeTick+1;
    
    %% check end battle
%     disp(RedsNum);
%     disp(blueAlive);
    if (RedsNum <= 0)
        InitializeFlag (v_ImageFB,v_AlphaFB);
        disp('Blue alvie')
        disp(blueAlive);
        break;
    end
    if (blueAlive <= 0 )
        InitializeFlag (v_ImageFR,v_AlphaFR);
        disp('Red alvie')
        disp(RedsNum);
        break;
    end
end


end