function [ratio, membraneFlourescence, cytoplasmFlourescence] = regionQuant(I, k, mMask, singleCell)

mF = struct2array(regionprops(mMask, I, 'MeanIntensity'));
mA = struct2array(regionprops(mMask, 'Area'));
membraneFlourescence.k = [k, mF];

cF = struct2array(regionprops(singleCell, I, 'MeanIntensity'));
cA = struct2array(regionprops(singleCell, 'Area'));
cytoplasmFlourescence.k = [k, cF];

ctotal = cF*cA;
mtotal = mF*mA;

trueTotalF = ctotal - mtotal;
trueTotalA = cA - mA;

trueMeanCF = trueTotalF/trueTotalA;

ratio = mF/trueMeanCF;

end