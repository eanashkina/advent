inputData: ([] read0 `:D:/Coding/advent2019/input3_1.txt);
firstLine: "," vs exec x from inputData[0];
secondLine: "," vs exec x from inputData[1];

//firstLine: "," vs "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51";
//secondLine: "," vs "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7";
stepsTotal: 0 0 ;
workWithCurrentCoordinate:{[coordinates;item;variable]
    currentCoord: last coordinates;
    show currentCoord;
    direction: `$item[0];
    steps: "J"$1_item;
    stepsTotal:: stepsTotal,((last stepsTotal)+1+til steps);
    if[direction=`R; newCoordinates: currentCoord[0] cross (currentCoord[1]+1+til steps)];
    if[direction=`L; newCoordinates: currentCoord[0] cross (currentCoord[1]-(1+til steps))];
    if[direction=`U; newCoordinates: (currentCoord[0]+1+til steps) cross currentCoord[1]];
    if[direction=`D; newCoordinates: (currentCoord[0]-(1+til steps)) cross currentCoord[1]];
    :coordinates,newCoordinates
    };

currentCoord: ((0,0);(0,0));
coordinates: currentCoord;
resFirstLine: coordinates workWithCurrentCoordinate[;;0]/ firstLine;
stepsFirst: stepsTotal;

stepsTotal: 0 0 ;
currentCoord: ((0,0);(0,0));
coordinates: currentCoord;
resSecondLine: coordinates workWithCurrentCoordinate[;;0]/ secondLine;
stepsSecond: stepsTotal;

//totalRes: update sumCol1: first each resSecondLine, sumCol2: last each resSecondLine from totalRes;

select count i by resSecondLine from ([] resSecondLine)

totalRes: ([] resFirstLine,resSecondLine)^([] stepsFirst, stepsSecond);

countRes: select from (select count i, distinct stepsSecond by resSecondLine from totalRes) where x>1;
countRes: update sumCol1: abs first each resSecondLine, sumCol2: abs last each resSecondLine,
    stepsCol1: first each stepsSecond, stepsCol2: last each stepsSecond from countRes;
countRes: update sumCol: sumCol1+sumCol2, sumSteps: stepsCol1+stepsCol2 from countRes;
