function loseBlood(timeTick)
global Reds; 
global RedsNum; 
if mod(timeTick, 5) ~= 0
    return;
end
for RedsIndex = 1: RedsNum
    if Reds(RedsIndex,15) >= 0 
        Reds(RedsIndex,15) = Reds(RedsIndex,15) - 0.5;
    end
end
end
