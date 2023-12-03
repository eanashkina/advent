system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input9_2.txt);
initialTable: update (" " vs) each x from initialTable;
initialTable: update direction: `$x[;0], move: "J"$x[;1] from initialTable;

initialTable: update xHeadStart: 0N, xHeadEnd: 0N, yHeadStart: 0N, yHeadEnd: 0N from initialTable;
initialTable: update yHeadEnd: move from initialTable where direction=`R;
initialTable: update yHeadEnd: neg move from initialTable where direction=`L;
initialTable: update xHeadEnd: move from initialTable where direction=`U;
initialTable: update xHeadEnd: neg move from initialTable where direction=`D;

initialTable: update sums xHeadEnd, sums yHeadEnd from initialTable;
initialTable: update xHeadStart: 0^prev xHeadEnd, yHeadStart: 0^prev yHeadEnd from initialTable;

initialTable: update xHeadPositions: enlist each xHeadStart from initialTable where xHeadEnd=xHeadStart;
initialTable: update xHeadPositions: {x+til (1+(y-x))}'[xHeadStart;xHeadEnd] from initialTable where xHeadEnd>xHeadStart;
initialTable: update xHeadPositions:  {reverse x+til (1+(y-x))}'[xHeadEnd;xHeadStart] from initialTable where xHeadStart>xHeadEnd;

initialTable: update yHeadPositions: enlist each yHeadStart from initialTable where yHeadEnd=yHeadStart;
initialTable: update yHeadPositions: {x+til (1+(y-x))}'[yHeadStart;yHeadEnd] from initialTable where yHeadEnd>yHeadStart;
initialTable: update yHeadPositions: {reverse x+til (1+(y-x))}'[yHeadEnd;yHeadStart] from initialTable where yHeadStart>yHeadEnd;


headPositions: ([] raze exec crossed from update crossed: {x cross y}'[xHeadPositions;yHeadPositions] from
    select xHeadPositions, yHeadPositions from initialTable);
// headPositions: distinct headPositions;
headPositions: select x1: first each x, y1: last each x from headPositions;
headPositions: update x2: 0, y2: 0 from headPositions;
//headPositions: update isNeighbourX: {(y-x) in (-1;0;1)}'[x1;x2] from headPositions;
//headPositions: update isNeighbourY: {(y-x) in (-1;0;1)}'[y1;y2] from headPositions;
//headPositions: update isNeighbour: isNeighbourX and isNeighbourY from headPositions;

counts: count headPositions;
//targetCount: 4;

checkPosition:{[headPositions;targetCount]
    show targetCount;
    selectedRow: select from headPositions where i=targetCount;
    targetX1: first selectedRow[`x1];
    targetY1: first selectedRow[`y1];
    targetX2: first selectedRow[`x2];
    targetY2: first selectedRow[`y2];
    selectedRow: update isNeighbourX: {(y-x) in (-1;0;1)}'[x1;x2] from selectedRow;
    selectedRow: update isNeighbourY: {(y-x) in (-1;0;1)}'[y1;y2] from selectedRow;
    selectedRow: update isNeighbour: isNeighbourX and isNeighbourY from selectedRow;
    $[first selectedRow[`isNeighbour];
        [
            :headPositions
            ];
        [
            headPositions: update x2: targetX2+signum(targetX1-targetX2), y2: targetY2+signum(targetY1-targetY2) from
                headPositions where i>=targetCount;

            :headPositions
            ]
        ];
    };

finalRes: headPositions checkPosition[;]/til counts;
distinct select x2, y2 from finalRes
// 6494

// (x;y) -> neighbours (x-1;y-1), (x;y-1), (x+1;y-1), (x-1;y), (x+1;y), (x-1;y+1), (x;y+1), (x+1;y+1)