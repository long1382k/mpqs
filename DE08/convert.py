
import cv2
# import Image

im = cv2.imread('images/soldier04.png', cv2.IMREAD_COLOR)
im2 = cv2.cvtColor(im, cv2.COLOR_BGR2BGRA)
cv2.imshow('image', im)
im2 = cv2.resize(im2, (750,1000))
cv2.imwrite('images/soldier041.png', im2)

# Image.open('cartoon.jpg').convert('RGB').save('output.png')
cv2.waitKey(0)