system "c 300 300";
//\P 17
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input18_2.txt);
initialTable: update parsed: "J"$("," vs) each x from initialTable;
initialTable: update x: parsed[;0], y: parsed[;1], z: parsed[;2] from initialTable;
initialTable: update neighbours: {
    x1: x[0];
    x2: x[1];
    x3: x[2];
    :((x1-1;x2;x3);(x1+1;x2;x3);(x1;x2-1;x3);(x1;x2+1;x3);(x1;x2;x3-1);(x1;x2;x3+1))
    } each parsed from initialTable;

pivot:{[t]
    u: `$string asc distinct last f:flip key t;
    pf:{x#(`$string y)!z};
    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
    p
    };

//pivot `z`x xkey `x`z xasc update num: 1 from select x,z from initialTable where y=1

// targetRow: 1;
// targetTable: missingBlocks;
processOneRow:{[targetRow;targetTable]
    show "targetRow: ",string targetRow;
    prevNeighbours: exec parsed from targetTable where i<targetRow;
    countNeighbours: count (raze exec neighbours from targetTable where i=targetRow) inter prevNeighbours;
    if[countNeighbours=0; countNum: 6];
    if[countNeighbours=1; countNum: 4];
    if[countNeighbours=2; countNum: 2];
    if[countNeighbours=3; countNum: 0];
    if[countNeighbours=4; countNum: -2];
    if[countNeighbours=5; countNum: -4];
    if[countNeighbours=6; countNum: -6];
    :countNum
    };

//finalRes: processOneRow[;initialTable] each exec i from initialTable;
//sum finalRes //4418

selectedTable: `x`y`z xasc select x, y, z from initialTable;

combinationsZ: select distinct x,y from initialTable;

//targetComb: combinations[1];

checkCombZ:{[targetComb;selectedTable]
    // TODO: that is not correct because that does not handle the case when there is a dent in the shard that goes inside
    show enlist targetComb;
    selectedRows: select from selectedTable where x=targetComb[`x], y=targetComb[`y];
    if[2>=count selectedRows; :()];

    selectedZ: exec z from selectedRows;
    missingZ: ((min selectedZ) + til (1+((max selectedZ)-(min selectedZ)))) except selectedZ;
    if[0=count missingZ;:()];

    :(enlist targetComb) cross ([] z: missingZ)
    //:(enlist targetComb) ^ ([] z: enlist missingZ)
    };

missingBlocksZ: raze checkCombZ[;selectedTable] each combinationsZ;

combinationsX: select distinct y,z from initialTable;
checkCombX:{[targetComb;selectedTable]
    // TODO: that is not correct because that does not handle the case when there is a dent in the shard that goes inside
    show enlist targetComb;
    selectedRows: select from selectedTable where z=targetComb[`z], y=targetComb[`y];
    if[2>=count selectedRows; :()];

    selectedX: exec x from selectedRows;
    missingX: ((min selectedX) + til (1+((max selectedX)-(min selectedX)))) except selectedX;
    if[0=count missingX;:()];

    :(enlist targetComb) cross ([] x: missingX)
    //:(enlist targetComb) ^ ([] z: enlist missingZ)
    };
missingBlocksX: `x`y`z xcol raze checkCombX[;selectedTable] each combinationsX;

combinationsY: select distinct x,z from initialTable;
checkCombY:{[targetComb;selectedTable]
    // TODO: that is not correct because that does not handle the case when there is a dent in the shard that goes inside
    //targetComb: combinationsY[1];
    show enlist targetComb;
    selectedRows: select from selectedTable where z=targetComb[`z], x=targetComb[`x];
    if[2>=count selectedRows; :()];

    selectedY: exec y from selectedRows;
    missingY: ((min selectedY) + til (1+((max selectedY)-(min selectedY)))) except selectedY;
    if[0=count missingY;:()];

    :(enlist targetComb) cross ([] y: missingY)
    //:(enlist targetComb) ^ ([] z: enlist missingZ)
    };
missingBlocksY: `x`y`z xcol raze checkCombY[;selectedTable] each asc combinationsY;


missingBlocks: (missingBlocksX inter missingBlocksY) inter missingBlocksZ;

//`x`y xasc missingBlock
missingBlocks: update parsed: {(x;y;z)}'[x;y;z] from missingBlocks;
missingBlocks: update neighbours: {
    x1: x[0];
    x2: x[1];
    x3: x[2];
    :((x1-1;x2;x3);(x1+1;x2;x3);(x1;x2-1;x3);(x1;x2+1;x3);(x1;x2;x3-1);(x1;x2;x3+1))
    } each parsed from missingBlocks;
finalResMissing: processOneRow[;missingBlocks] each exec i from missingBlocks;
4418-(sum finalResMissing) // 2116j
// 2116 too low; 3222 too high
// How do I handle the case of S-shaped channel that goes inside the droplet?

// Part 2
maxValue: max (raze exec x, y, z from initialTable);
listOfPositions: (((til maxValue) cross (til maxValue)) cross (til maxValue)) except exec parsed from initialTable;


//targetPosition: listOfPositions[58];
checkOnePosition:{[targetPosition;initialTable]
    show targetPosition;
    neighbours: {[x1;x2;x3]
        ((x1-1;x2;x3);(x1+1;x2;x3);(x1;x2-1;x3);(x1;x2+1;x3);(x1;x2;x3-1);(x1;x2;x3+1))
        }'[targetPosition[0];targetPosition[1];targetPosition[2]];
    $[all neighbours in exec parsed from initialTable;
        res: ([] pos: enlist targetPosition; ne: enlist neighbours);
        res: ()
        ];
    :res
    };

finalRes: raze checkOnePosition[;initialTable] each listOfPositions;

4418-(count finalRes)*6 // too high - 4136