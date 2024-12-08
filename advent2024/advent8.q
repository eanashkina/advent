system "c 300 300";
initialTable: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input8_2.txt;
width: first count each initialTable;
length: count initialTable;
initialTable: raze initialTable;
diffElements: `$distinct string initialTable;
diffElements: diffElements except `$".";

perm:{[N;l]$[N=1;l;raze .z.s[N-1;l]{x,/:y except x}\:l]};
combinations: {[N;l]  distinct asc each perm[N;l]};

//targetComb: first combs;
//targetNum: 20j;

findCoord:{[targetNum;width]
    show targetNum;
    xCoords: targetNum div width;
    yCoords: targetNum-(width*xCoords);
    :([] enlist targetNum; xCoords; yCoords)
    };

checkOneComb:{[targetComb;coordTab;width;length]
    show targetComb;
    onePos: exec from coordTab where targetNum=first targetComb;
    twoPos: exec from coordTab where targetNum=last targetComb;
    xDiff: onePos[`xCoords] - twoPos[`xCoords];
    yDiff: onePos[`yCoords] - twoPos[`yCoords];
    newPos1x: onePos[`xCoords]+xDiff;
    newPos2x: twoPos[`xCoords]-xDiff;
    newPos1y: onePos[`yCoords]+yDiff;
    newPos2y: twoPos[`yCoords]-yDiff;
    :([] enlist targetComb; newPos1x; newPos1y; newPos2x; newPos2y)
    };

getTableOneElement:{[initialTable;targetElement;width;length]
    show targetElement;
    //targetElement: `0
    //targetElement: first string first diffElements;
    targetElementPos: where initialTable=first string targetElement;
    coordTab: raze findCoord[;width] each targetElementPos;
    combs: combinations[2;targetElementPos];
    resOneElement: raze checkOneComb[;coordTab;width;length] each combs;
    :update element: targetElement from resOneElement
    };

finalRes: raze getTableOneElement[initialTable;;width;length] each diffElements;
redCols: ([] x: raze exec newPos1x, newPos2x from finalRes; y: raze exec newPos1y, newPos2y from finalRes);

//distinct select from redCols where x within (0;length-1), y within (0;width-1)

// 331 too high
// 320

// part 2

getTableOneElementExtra:{[initialTable;targetElement;width;length]
    show targetElement;
    //targetElement: `0
    //targetElement: first string first diffElements;
    targetElementPos: where initialTable=first string targetElement;
    coordTab: raze findCoord[;width] each targetElementPos;
    combs: combinations[2;targetElementPos];
    resOneElement: raze checkOneCombExtra[;coordTab;width;length] each combs;
    :update element: targetElement from resOneElement
    };

// TODO: continue from here
checkOneCombExtra:{[targetComb;coordTab;width;length]
    // targetComb: first combs;
    show targetComb;
    onePos: exec from coordTab where targetNum=first targetComb;
    twoPos: exec from coordTab where targetNum=last targetComb;
    xDiff: onePos[`xCoords] - twoPos[`xCoords];
    yDiff: onePos[`yCoords] - twoPos[`yCoords];
    newPos1x: onePos[`xCoords]+xDiff*til length;
    newPos1x: newPos1x where newPos1x within (0;length-1);
    newPos2x: twoPos[`xCoords]-xDiff*til length;
    newPos2x: newPos2x where newPos2x within (0;length-1);
    newPos1y: onePos[`yCoords]+yDiff*til width;
    newPos1y: newPos1y where newPos1y within (0;width-1);
    newPos2y: twoPos[`yCoords]-yDiff*til width;
    newPos2y: newPos2y where newPos2y within (0;width-1);
    minLength1: min(count newPos1x;count newPos1y);
    minLength2: min(count newPos2x;count newPos2y);

    res: ([] newPosX: (minLength1#newPos1x),(minLength2#newPos2x); newPosY: (minLength1#newPos1y),(minLength2#newPos2y));

    :update targetComb: (count res)#enlist targetComb from res
    };

finalRes: raze getTableOneElementExtra[initialTable;;width;length] each diffElements;
select distinct from select newPosX, newPosY from finalRes
// 1157