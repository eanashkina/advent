system "c 300 300";
//\P 17
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input14_1.txt);
initialTable: update parsed: (" -> " vs) each x from initialTable;

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
