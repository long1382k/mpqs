function blueDeployingDefensive(mode)
global kB ObstaclesNumB ObstaclesB BluesNum MaxBlueNum;   

if (mode == 0)
    disp('----------------- mode 0 ----------------');
    for IndexB = 1 : 8
        ObstaclesB( IndexB ,(1:3)) = [-250,80,0];
    end
%     for IndexB = 9 : 13
%         ObstaclesB( IndexB ,(1:3)) = [-250,80,0];
%     end
    for IndexB = 14 : MaxBlueNum + 1
        ObstaclesB( IndexB ,(1:3)) = [-250,-80,0];
    end
    %Quan xanh canh gac
%     ObstaclesB(1, 1:3) = [  50   50      0     ];
%     ObstaclesB(2, 1:3) = [-200 50         0     ];
%     ObstaclesB(3, 1:3) = [50 -300         0   ];
    ObstaclesB(1, 1:4) = [  50   50      0     0];
    ObstaclesB(3, 1:4) = [100 0         0    0 ];
    ObstaclesB(2, 1:4) = [150 -150         0  0 ];
%     ObstaclesB(4, 1:4) = [-100 -200         0  0 ];
end

%% trien khai 50% doi hinh` phong thu
if (mode == 1)
    disp('----------------- mode 1 ----------------');
ObstaclesB(1, 1:4) = [-265.1934  -87.9227         0         0];
ObstaclesB(2, 1:4) = [-212.1547 -118.8406         0         0];
ObstaclesB(3, 1:4) = [-178.2689 -171.0145         0         0];
ObstaclesB(4, 1:4) = [-159.1160 -223.1884         0         0];
ObstaclesB(5, 1:4) = [-134.0700 -271.4976         0         0];
ObstaclesB(6, 1:4) = [-114.9171 -344.9275         0         0];
ObstaclesB(7, 1:4) = [210  20         0         0];
ObstaclesB(8, 1:4) = [200  0         0         0];
% ObstaclesB(1, 1:4) = [-50 -350         0         0];
% ObstaclesB(2, 1:4) = [-100 -250        0         0];
% ObstaclesB(3, 1:4) = [-150 -150         0         0];
% ObstaclesB(4, 1:4) = [-200 -100         0         0];
% ObstaclesB(5, 1:4) = [-250 -50       0         0];
% ObstaclesB(6, 1:4) = [-300 -50         0         0];
% ObstaclesB(7, 1:4) = [-250  -250        0         0];
% ObstaclesB(8, 1:4) = [-100   -200  0         0];
end

% %% Quan xanh chi vien
% if (mode == 2)
%     disp('----------------- mode 2 ----------------');
% ObstaclesB(9, 1:4) = [-192.1547 -98.8406         0         0];
% ObstaclesB(10, 1:4) = [-158.2689 -151.0145         0         0];
% ObstaclesB(11, 1:4) = [-139.1160 -203.1884         0         0];
% ObstaclesB(12, 1:4) = [-114.0700 -251.4976         0         0];  
% ObstaclesB(13, 1:4) = [-94.9171 -324.9275         0         0];
% end
% 
% if (mode == 3)
%     disp('----------------- mode 3 ----------------');
% ObstaclesB(14, 1:4) = [-319.7053  -70.5314         0         0];
% ObstaclesB(15, 1:4) = [-319.7053  -80.5314         0         0];
% ObstaclesB(16, 1:4) = [-265.1934  -87.9227         0         0];
% ObstaclesB(17, 1:4) = [-212.1547 -118.8406         0         0];
% ObstaclesB(18, 1:4) = [-178.2689 -171.0145         0         0];
% ObstaclesB(19, 1:4) = [-159.1160 -223.1884         0         0];
% ObstaclesB(20, 1:4) = [-134.0700 -271.4976         0         0]; 
% end
