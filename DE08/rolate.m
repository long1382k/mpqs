function [img, alpha] = rolate(or_img, or_alpha, angle)
img = imrotate(or_img, angle);
alpha = imrotate(or_alpha, angle );
end