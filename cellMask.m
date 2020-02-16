
function [meanRatio, ratioInit] = cellMask(filename, j, thresh)

    [I] = artifactCleaner(filename, j);

    [~,threshold] = edge(I,'sobel');
    BWs = edge(I,'sobel',threshold * thresh.fudgeFactor);
    
    se90 = strel('line',3,90);
    se0 = strel('line',3,0);
    BWsdil = imdilate(BWs,[se90 se0]);

    BWdfill = imfill(BWsdil,'holes');

    BWnobord = imclearborder(BWdfill,4);

    seD = strel('diamond', thresh.cleaning);
    BWfinal = imerode(BWnobord,seD);
    BWfinal = imerode(BWfinal,seD);
    
    r = [];
    [L, num] = bwlabel(BWfinal);
    for k = 1 : num
        singleCell = ismember(L, k);
        cellSize = cell2mat(struct2cell(regionprops(singleCell, 'area')));
        
        if cellSize>4000
            trueCell(k) = 1;
            cellMembrane = boundarymask(singleCell, 8);
            se = strel('diamond', thresh.membraneField);
            membraneMask = imdilate(cellMembrane, se);
          
            imshow(labeloverlay(I, membraneMask));
            [ratio, ~, ~] = regionQuant(I, k, membraneMask, singleCell);
            
            
            r = [r, ratio];
            
            
        else 
            clear singleCell
            trueCell(k) = 0;
        end
        
    end
    
    cleanr = rmoutliers(r, 'percentiles', [10 90]);

    meanRatio = mean(cleanr);
    ratioInit = mean(cleanr);
    disp(meanRatio);
    sumTrueCell = sum(trueCell);
    disp(sumTrueCell)
