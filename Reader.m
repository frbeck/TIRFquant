function [smoothf4, smoothf3, smoothf2, smoothf1, f] = Reader(filename, thresh, i, n)
f = [];
if n == 1
    
    info = imfinfo(filename);
    numframe = length(info);

elseif n == 2
    
    filename = [thresh.fileStartB, num2str(i), thresh.fileEndB];
    info = imfinfo(filename);
    numframe = length(info);
    
end
    
    

[~, ratioInit] = cellMask(filename, 1, thresh);

for j = 1 : numframe
    
    
    [meanRatio] = cellMask(filename, j, thresh);
    normRatio = meanRatio./ratioInit;
    
    f = [f, normRatio];
end

smoothf1 = filloutliers(f, 'linear', 'percentiles', [10 90]);
smoothf2 = smoothdata(smoothf1, 'sgolay');
smoothf3 = smoothdata(smoothf2, 'loess', 200);
smoothf4 = smoothdata(smoothf1, 'movmean', 100);

x = 1:numframe;

close all
hold on

scatter(x, smoothf1);
scatter(x, smoothf4);

hold off

end