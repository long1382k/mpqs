function SET_GLOBAL_VARIABLES()
global BaseB BaseR EnvironmentWidth ;
global Reds RedsNum MaxRedNum RedsHP DieRNum;
global Blues BluesNum MaxBlueNum BlueHP DieBNum;
global Plane Plane1;
global TimeSteps;
global SpeedCorrection AlignmentRange CohesionRange;;
global Obstacles ObstaclesNumB ObstaclesB;
global ObstaclesNum;
global Targets TargetsNum;
global SaveMousePosition;
global saveText;
global FleeDistance SafeDistance;
global ImageWidth;
global Booms BoomsNum;
global RedsHP;
global BloodPos;
global SizeHPBar;
global ShootDistanceB ShootDistanceR;
global deviationXB deviationYB deviationXR deviationYR;
global AccuracyB AccuracyR;
TargetsNum = 1;
SizeHPBar=1;
BloodPos=25;
ObstaclesNumB = 15;
ObstaclesB = [0 0 0 0];
AccuracyB =0.8; % do chinh xac
AccuracyR =0.6;
ShootDistanceB = 200; 
ShootDistanceR = 200;
EnvironmentWidth = 400;
AlignmentRange = EnvironmentWidth/5; % set alignment range
CohesionRange = EnvironmentWidth/4; % set cohesion range
SpeedCorrection = 100;
TimeSteps = 500000;
FleeDistance = 80;
ImageWidth = EnvironmentWidth/10;
SafeDistance = EnvironmentWidth/20; % set separation range
%% set Obstacles
ObstaclesNum = 6;
Obstacles=zeros(ObstaclesNum,4);
Obstacles(1,1) = -300;
Obstacles(1,2) = -150;

%% Plane
Plane = zeros(1,15);
Plane(1,1) = 400;
Plane(1,2) = -300;
Plane(1,4:5) = 400; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Plane(1,10) = 4;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Plane(1,11) = 0.2; % set maxforce
Plane(1,13) = 200; % set max see ahead
Plane(1,14) = 10; % set max avoid force


Plane1 = zeros(1,15);
Plane1(1,1) = -400;
Plane1(1,2) = 100;
Plane1(1,4:5) = 400; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Plane1(1,10) = 4;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Plane1(1,11) = 0.2; % set maxforce
Plane1(1,13) = 200; % set max see ahead
Plane1(1,14) = 10; % set max avoid force


%% List of Reds
MaxRedNum = 20;
RedsNum = 10;

Reds = zeros(MaxRedNum,15); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision avoidance)
%}
Reds(:,1) = EnvironmentWidth/4*(rand([MaxRedNum,1]))+300; % set random position
Reds(:,2) = EnvironmentWidth/4*(rand([MaxRedNum,1]))+270; % set random position
%Reds(:,1:2) = 2; % set random position EnvironmentWidth*(2*rand([RedsNum,2])-1)
Reds(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Reds(:,10) = 4;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Reds(:,11) = 0.2; % set maxforce
Reds(:,13) = 200; % set max see ahead
Reds(:,14) = 10; % set max avoid force
Reds(:,15) = 100; % set blood

%% List of Blues
MaxBlueNum = 20;
BluesNum = 5;

Blues = zeros(MaxBlueNum,15); % initialize boids matrix
%{1-3 position, 4-6 velocity, 7-9 accelaration, 10 maxspeed, 11 maxforce, 12 angle,
% 13 max see ahead (for collision avoidance), 14 max avoid force (collision avoidance)
%}
%Blues(:,1:2) = EnvironmentWidth*(2*rand([BluesNum,2])-1); % set random positionB
% Blues(:,1) = EnvironmentWidth/4*(rand([MaxBlueNum,1])); % set random position
% Blues(:,2) = EnvironmentWidth/4*(rand([MaxBlueNum,1])); % set random position
% Blues(:,1) = -400; % set random position
% Blues(:,2) = -400; % set random position


Blues(1:8,1) = 80; 
Blues(1:8,2) = -150; 

Blues(1,1) = 180;
Blues(1,2) = -50;
Blues(2,1) = 100;
Blues(2,2) = -250;
Blues(3,1) = -50;
Blues(3,2) = -50;
% Blues(4,1) = -200;
% Blues(4,2) = -250;

Blues(9:13,1) = -500; 
Blues(9:13,2) = 500; 

% Blues(14:MaxBlueNum,1) = -100;
% Blues(14:MaxBlueNum,2) = -450; 
Blues(14:MaxBlueNum,1) = -400;
Blues(14:MaxBlueNum,2) = -400; 

Blues(:,4:5) = 200; %200*(2*rand([BoidsNum,2])-1); % set random velocity
Blues(:,10) = 4;%*(rand([BoidsNum,1]) + 0.2); % set maxspeed
Blues(:,11) = 0.2; % set maxforce
Blues(:,13) = 200; % set max see ahead
Blues(:,14) = 10; % set max avoid force
Blues(:,15) = 120; % set blood
% Blues(1,15) = 10000; % set blood


%% Targets data. The targets may be leaders, persuaders... that the flock of agents want to follow.
%List of targets
Targets = zeros(TargetsNum,14);
Targets(:,1:2) = rand([TargetsNum,2])-1; % set random position
Targets(:,4:5) = 2*(2*rand([TargetsNum,2])-1); % set random velocity
Targets(:,10) = 2; % set maxspeed
Targets(:,11) = 20; % set maxforce
Targets(:,13) = 160; % set max see ahead
Targets(:,14) = 2; % set max avoid force

%% Obstacles
Obstacles(1:ObstaclesNum, 4) = 60;
Obstacles(1,1) = 0;
Obstacles(1,2) = 300;
Obstacles(2,1) = -200;
Obstacles(2,2) = 150;
Obstacles(3,1) = -240;
Obstacles(3,2) = -250;
Obstacles(4,1) = 300;
Obstacles(4,2) = 100;
Obstacles(5,1) = 300;
Obstacles(5,2) = -250;
% Obstacles(6,1) = 100;
% Obstacles(6,2) = 0;
% Obstacles(7,1) = 50;
% Obstacles(7,2) = 100;

%% Boom
 BoomsNum= 5;
 Booms = zeros(BoomsNum,4);
 Booms( :,4) = 1;
 Booms(1,1)= -50; Booms(1,2)= -100;
 Booms(2,1)= 0; Booms(2,2)= 100;
 Booms(3,1)= 100; Booms(3,2)= -300;
 Booms(4,1)= -200; Booms(4,2)= 0;
 Booms(5,1)= -100; Booms(5,2)= 200;
 Booms(6,1)= 100; Booms(6,2)= -100;
 Booms(7,1)= 200; Booms(7,2)= 50;

end