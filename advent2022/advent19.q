system "c 300 300";
//\P 17
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input19_1.txt);
initialTable: update x: ("." vs) each x from initialTable;
initialTable: delete x from update oreRobotCost: x[;0], clayRobotCost: x[;1], obsidianRobotCost: x[;2],
    geodeRobotCost: x[;3] from initialTable;
initialTable: update (" " vs) each oreRobotCost, (" " vs) each clayRobotCost, (" " vs) each obsidianRobotCost,
    (" " vs) each geodeRobotCost from initialTable;
initialTable: delete obsidianRobotCost, geodeRobotCost from update oreRobotCost: "J"$oreRobotCost[;6],
    clayRobotCost: "J"$clayRobotCost[;5], obsidianRobot1Cost: "J"$obsidianRobotCost[;5],
    obsidianRobot2Cost: "J"$obsidianRobotCost[;8], geodeRobot1Cost: "J"$geodeRobotCost[;5],
    geodeRobot2Cost: "J"$geodeRobotCost[;8] from initialTable;

blueprints: exec i from initialTable;

targetNum: 0;
testBlueprint:{[targetNum;initialTable]
    targetRow: select from initialTable where i=targetNum;
    show targetRow;
    //    oreRobotCost: targetRow[`oreRobotCost];
    //    clayRobotCost: targetRow[`clayRobotCost];
    //    obsidianRobot1Cost: targetRow[`obsidianRobot1Cost];
    //    obsidianRobot2Cost: targetRow[`obsidianRobot2Cost];
    //    geodeRobot1Cost: targetRow[`geodeRobot1Cost];
    //    geodeRobot2Cost: targetRow[`geodeRobot2Cost];

    table: ([] ore: enlist 0; clay: 0; obsidian: 0; geode: 0; oreRobot: 1; clayRobot: 0; obsidianRobot: 0; geodeRobot: 0);
    table: table^targetRow;
    // table: 24#table;

    5 div 2
    countStep: 0;
    while[countStep<24;
        show countStep;
        tableNew: update oreRobot: ?[ore>=oreRobotCost;oreRobot+(ore div oreRobotCost
        tableNew: update ore: ore+oreRobot, clay: clay+clayRobot, obsidian: obsidian+obsidianRobot,
            geode: geode+geodeRobot from table;
        countStep: countStep+1;
        ];
    };

initialTable: update "J"$sX, "J"$sY, "J"$bX, "J"$bY from initialTable;
// for each S exclude all points that are closer than B
sX-distanceBeacon -> sX+distanceBeacon
sY-distanceBeacon -> sY+distanceBeacon

sX: 100;
sY: 100;
distanceBeacon: 10;


firstHalf: raze raze {[height] {[x;sX;sY;height] (((sX-x);(sY-height));((sX+x);(sY-height)))}[;sX;sY;height]
    each til 1+(distanceBeacon-height)} each til 1+distanceBeacon;

//raze {[height] {[x;sX;sY;height] show x; (((sX-x);(sY-height));((sX+x);(sY-height)))}[;sX;sY;0] each til (distanceBeacon-0)}[0]

secondHalf: raze raze {[height] {[x;sX;sY;height] (((sX-x);(sY+height));((sX+x);(sY+height)))}[;sX;sY;height]
    each til 1+(distanceBeacon-height)} each til 1+distanceBeacon;

0^pivot `x`y xkey update num: 1 from select x: first each x, y: last each x from ([] asc distinct x: firstHalf,secondHalf)

pivot:{[t]
    u: `$string asc distinct last f:flip key t;
    pf:{x#(`$string y)!z};
    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
    p
    };

;((sX-x);(sY+height));
    ((sX+x);(sY+height))
// but circle, not square
initialTable: update distanceBeacon: {[sX;sY;x;y]
    abs[max[sX,x]-min[sX,x]]+abs[max[sY,y]-min[sY,y]]
        }'[sX;sY;bX;bY] from initialTable;

minX: min raze exec bX, sX from initialTable;
maxX: max raze exec bX, sX from initialTable;
list: (-2000000)+minX+til (2000000+(maxX-minX));
targetY: 2000000j;


list: (-20)+minX+til (20+(maxX-minX));
targetY: 11;
list: til 21;
coords: ([] x: list; y: (count list)#targetY); //2,000,000

targetCoord: first 100000 cut coords;
checkCoord:{[targetCoord;initialTable]
    show targetCoord;
    res: update distancePoint: {[sX;sY;x;y]
        abs[max[sX,x]-min[sX,x]]+abs[max[sY,y]-min[sY,y]]
            }'[sX;sY;x;y] from ((targetCoord) cross select sX, sY, bX, bY, distanceBeacon from initialTable);
    :targetCoord except (distinct select x, y from res where distanceBeacon>=distancePoint)
    };


checkY:{[targetY;initialTable]
    show targetY;
    list: til 4000000;
    coords: ([] x: list; y: (count list)#targetY); //2,000,000
    finalRes: raze checkCoord[;initialTable] each 10000 cut coords;
    :finalRes
    };

finalFinalRes: raze checkY[;initialTable] each til 4000000;

3*4000000%60
//select from res where x=-12, y=10
count finalRes except (select distinct x: bX, y: bY from initialTable) // 4424278



select count i, distinct isFar by coord from update coord: {x,y}'[x;y] from update isFar: distanceBeacon>distancePoint from res

parseOneLine:{[targetLine]
    targetLine: exec parsed from targetLine;
    parsedTable: update xLine: {x1: min[x,y]; x2: max[x,y]; :x1 + til (1+(x2-x1))}'[x;next x],
        yLine: {x1: min[x,y]; x2: max[x,y]; :x1 + til (1+(x2-x1))}'[y;next y] from
            update x: last each parsed, y: first each parsed from update parsed: "J"$("," vs) each initial from
                ([] initial: targetLine);

    parsedTable: update crossed: {x cross y}'[xLine;yLine] from -1_parsedTable;
    :distinct asc raze exec crossed from parsedTable
    };


initialTableNoSand: ([] x: parseOneLine each initialTable);
walls: raze exec x from initialTableNoSand;
floorCoord: 2+max walls[;0];
walls: walls,(enlist floorCoord) cross (til 1000);
wallsInitial: walls;

dropOneSand:{[walls;countSand]
    show countSand;
    dropLocation: (min walls where walls[;1]=500)+(-1;0);
    // show "!!! ", "_" sv string dropLocation;
    moveLeft: (1;-1);
    moveRight: (1;1);
    blocked: 0b;
    while[(not blocked) or (all dropLocation=(0,500));
        leftLocation: dropLocation+moveLeft;
        $[not leftLocation in walls;
            dropLocation: leftLocation;
            [
                rightLocation: dropLocation+moveRight;
                $[not rightLocation in walls;
                    dropLocation: rightLocation;
                    blocked: 1b;
                    ];
                ]
            ];
        // show dropLocation;
        // Drop down
        yDrop: last dropLocation;
        dropLocations: (walls where walls[;1]=yDrop);
        // dropLocationsAdjusted: dropLocations+(-1;0);
        dropLocationNew: (min dropLocations where (dropLocations[;0])>dropLocation[0])+(-1;0);
        if[0<count dropLocationNew;dropLocation: dropLocationNew]
        ];
    show "Final ","_" sv string dropLocation;
    :walls,enlist dropLocation
    };


walls: walls dropOneSand/ til 20000; // 900
count asc walls except wallsInitial

walls20000: walls;
wallsNew: walls20000;

wallsNew: wallsNew dropOneSand/ 20000+til 20000;
count asc wallsNew except wallsInitial

// Part 1: 888
// Part 2: 26461

select x: last each walls, y: first each walls from ([] walls)
