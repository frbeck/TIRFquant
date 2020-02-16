thresh.cleaning = 3;
thresh.membraneField = 3;
thresh.numVidA = 1;
thresh.numVidB = 0;
thresh.fudgeFactor = 0.7;
filename = 'filename.tif';

allf = [];
for i = 1:thresh.numVidA
    [smoothf4, smoothf3, smoothf2, smoothf1, f] = Reader(filename, thresh, i, 1);
end

for i = 1:thresh.numVidB
    [smoothf4, smoothf3, smoothf2, smoothf1, f] = Reader(filename, thresh, i, 2);
end


