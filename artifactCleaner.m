function [I] = artifactCleaner(filename, j)

grayImage = imread(filename, j);
grayImage = imsharpen(grayImage);
avgBrightness = mean2(grayImage);

mask = grayImage > avgBrightness * 5;


props = regionprops(logical(mask), 'Area');
allAreas = sort([props.Area]);

mask = bwareaopen(mask, 25);

mask = imclearborder(mask);

se = strel('octagon', 9);
mask = imdilate(mask, se);


grayImage(mask) = avgBrightness * 3;
I = grayImage * 5;

