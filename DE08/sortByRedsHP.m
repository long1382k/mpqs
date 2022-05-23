function sortByRedsHP()
global RedsNum Reds RedsPlot;

% if (RedsNum == 0)
%     return;
% end

redsNumN = RedsNum;
try
    while (Reds(redsNumN,15) <= 0)
        redsNumN = redsNumN - 1;
    end
catch me
%     disp('err');
    RedsNum = 1;
end
% disp('HP');
% disp(Reds(1, 15));
if (Reds(1, 15) <= 0 && RedsNum == 1)
%     disp('here');
    RedsNum = 0;
    return;
end

%truong hop leader bi hi sinh tim linh gan nhat lam leader
if (Reds(1, 15) <= 0)
    [index,tmpDist] = findTarget(Reds(1),redsNumN,Reds);
    temp = Reds(1,:);
    Reds(1,:) = Reds(index,:);
    Reds(index,:) = temp;
    tempP = RedsPlot(1);
    RedsPlot(1) = RedsPlot(index);
    RedsPlot(index) = tempP;
end


%Dua cac quan linh bi hy sinh ra cuoi array de khong phai tinh toan force
%cho cac quan linh nay nua va tu dong sap xep lai doi hinh vong cung
% for i = 2 : redsNumN - 1
%    if (Reds(i,15) <= 0)
%        temp = Reds(i,:);
%        tempP = RedsPlot(i);
%        for j = i : redsNumN - 1
%            try
%                Reds(j,:) =  Reds(j+1,:);
%                RedsPlot(j) = RedsPlot(j+1);
%            catch me
%                disp('exception in sortByRedHP function!!');
%            end
%        end
%        Reds(redsNumN,:) = temp;
%        RedsPlot(redsNumN) = tempP;
%        redsNumN = redsNumN - 1;
%        while (Reds(i,15) == 0)
%             i = i - 1;
%        end
%        i = i - 1;
%    end
% end

i = 2;
while i <= redsNumN - 1
   if (Reds(i,15) <= 0)
       temp = Reds(i,:);
       tempP = RedsPlot(i);
       for j = i : redsNumN - 1
           try
               Reds(j,:) =  Reds(j+1,:);
               RedsPlot(j) = RedsPlot(j+1);
           catch me
               disp('exception in sortByRedHP function!!');
           end
       end
       Reds(redsNumN,:) = temp;
       RedsPlot(redsNumN) = tempP;
       redsNumN = redsNumN - 1;
%        while (Reds(i,15) == 0)
%             i = i - 1;
%        end
%        i = i - 1;
   end
   if (Reds(i,15) ~= 0)
       i = i + 1;
   end
  
end

RedsNum = redsNumN;
Reds(1,10) = 1.0; % set max speed of 1-st Boid
Reds(2:RedsNum, 10) = 2.5;
     