% Find nearest boid of the Leader, MinIndex is index of Boid in the flock
% RedsFlag is a array to mark any boid is arranged to come to the desired point and do not need to be arrange
function [Nearest, RedsFlag, MinIndex] = NearestBoid(Leader, RedsFlag)
global RedsNum;
global Reds;
i = 1;
if (any(RedsFlag))
    while (i < RedsNum && RedsFlag(i) ~= 0)
        i = i + 1;
    end
end
d_min = dist(Leader(1:3), Reds(i,1:3));
while (d_min == 0 && i < RedsNum )
    i = i + 1;
    d_min = dist(Leader(1:3), Reds(i,1:3));
end

MinIndex = i;
for Index = 1:RedsNum
    if ((RedsFlag(Index) == 0) && Index ~= MinIndex)
        vhl_o_pos = Reds(Index,1:3);
        d = dist(Leader(1:3), vhl_o_pos);
        if (d > 0) && (d < d_min)
            d_min = d;
            MinIndex = Index;
        end
    end
end
Nearest = Reds(MinIndex, :);
RedsFlag(MinIndex) = 1;
end