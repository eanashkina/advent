system "c 300 300";
// target area: x=277..318, y=-92..-53
//xStart: 277;
//xEnd: 318;
//yStart: -92;
//yEnd: -53;
xStart: 20;
xEnd: 30;
yStart: -10;
yEnd: -5;
xCoord: xStart+til 1+xEnd-xStart;
yCoord: yStart+til 1+yEnd-yStart;

allCoord: xCoord cross yCoord;
// allCoord: ([] allCoord);
// yVel0: 90;
//countInArea: 1;
//while[(count countInArea)>0;
//    yVel0: yVel0+1;
//    show "YVel0: ",string yVel0;
//    yVelSteps: yVel0-til 100000;
//    yCoor: sums yVelSteps;
//    countInArea: yCoor where yCoor in yCoord;
//    show yCoor;
//    ];

countCoords:{[yVel0;yCoord]
    // yVel0: 91
    show "YVel0: ",string yVel0;
    yVelSteps: yVel0-til 1000000;
    yCoor: sums yVelSteps;
    countInArea: yCoor where yCoor in yCoord;
    :([] enlist yVel0;count countInArea)
    };

yPossibilities: raze countCoords[;yCoord] each 100-til 200;
yPossibilities: select from yPossibilities where countInArea>0;

//xVel0:7
countCoordsx:{[xVel0;xCoord]
    show "XVel0: ",string xVel0;
    XVelSteps: xVel0-til 1+xVel0;
    xCoor: sums XVelSteps;
    countInArea: xCoor where xCoor in xCoord;
    :([] enlist xVel0;count countInArea)
    };

xPossibilities: raze countCoordsx[;xCoord] each til 200;
xPossibilities: select from xPossibilities where countInArea>0;

allPossibilities: delete countInArea from xPossibilities cross yPossibilities;

//allPossibilities: ([] xVel0: til 170) cross ([] yVel0: -100 + til 200);

//allPossibilities: ([] xVel0: 200+til 50) cross ([] yVel0: -100 + til 200);

//targetPos: allPossibilities[6];
checkOnePos:{[targetPos;allCoord]
     show raze targetPos;
    steps: til 100000;

    allVelosities:  updateCoord[targetPos;] each steps;
    allVelosities: update combined: {x,y}'[xCoord;yCoord] from update xCoord: sums xVel0, yCoord: sums yVel0 from allVelosities;
    :update xVel0: targetPos[`xVel0], yVel0: targetPos[`yVel0] from (select from allVelosities where combined in allCoord)
    };



finalRes2: raze checkOnePos[;allCoord] each allPossibilities;
distinct select xVel0, yVel0 from finalRes
finalRes
// 1029 too low // 1700 too low

select count i by xVel0, yVel0 from finalRes


select from finalRes where yVel0>-3

updateCoord:{[targetPos;targetStep]
    :update max(0;(xVel0-targetStep)), yVel0-targetStep from targetPos
    };