function img = preprocess(img)
lvl = graythresh(img);
img = im2bw(img, lvl);
img = imresize(double(img),[100,100]);
img=double(img);
end