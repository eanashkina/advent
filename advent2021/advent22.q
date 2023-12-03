system "c 300 300";
initialTable: ([] line: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input22_1.txt);
initialTable: update ("," vs) each line from initialTable;
initialTable: update x: line[;0], y: line[;1], z: line[;2] from initialTable;
initialTable: update (" " vs) each x from initialTable;
initialTable: update position: `$x[;0], x: x[;1] from initialTable;

// TODO: wrap everything in functions
initialTable: update ("=" vs) each x from initialTable;
initialTable: update last each x from initialTable;
initialTable: update "J"$(".." vs) each x from initialTable;

initialTable: update ("=" vs) each y from initialTable;
initialTable: update last each y from initialTable;
initialTable: update "J"$(".." vs) each y from initialTable;

initialTable: update ("=" vs) each z from initialTable;
initialTable: update last each z from initialTable;
initialTable: update "J"$(".." vs) each z from initialTable;

initialTable: update x1: min each x from initialTable;
initialTable: update x2: max each x from initialTable;
initialTable: update y1: min each y from initialTable;
initialTable: update y2: max each y from initialTable;
initialTable: update z1: min each z from initialTable;
initialTable: update z2: max each z from initialTable;

initialTable: update x1: max(-50;min(50;x1)) from initialTable;
initialTable: update x2: max(-50;min(50;x2)) from initialTable;
initialTable: update y1: max(-50;min(50;y1)) from initialTable;
initialTable: update y2: max(-50;min(50;y2)) from initialTable;
initialTable: update z1: max(-50;min(50;z1)) from initialTable;
initialTable: update z2: max(-50;min(50;z2)) from initialTable;

initialTable: update xValues: {[x1;x2] x1 + til 1+(x2-x1)}'[x1;x2] from initialTable;
initialTable: update yValues: {[x1;x2] x1 + til 1+(x2-x1)}'[y1;y2] from initialTable;
initialTable: update zValues: {[x1;x2] x1 + til 1+(x2-x1)}'[z1;z2] from initialTable;

initialTable: update xyCross: {x cross y}'[xValues;yValues] from initialTable;
initialTable: update xyzCross: {x cross y}'[xyCross;zValues] from initialTable;

initialTableShort: update num: i, countCubes: count each xyzCross from select xyzCross, position from initialTable;
initialTableShortUngroup: delete countCubes, num from update countCubesMany: {x#y}'[countCubes;num] from initialTableShort;

ungroupedTable: ungroup initialTableShortUngroup;
ungroupedTable: update positionNum: ?[position=`on;1;-1] from ungroupedTable;

rowsToRemoveX: select x, x1, x2, num: i from initialTable where (x1=x2) and ((x1=50) or (x1=-50));
rowsToRemoveY: select y, y1, y2, num: i from initialTable where (y1=y2) and ((y1=50) or (y1=-50));
rowsToRemoveZ: select z, z1, z2, num: i from initialTable where (z1=z2) and ((z1=50) or (z1=-50));

posToRemove: distinct (exec num from rowsToRemoveX), (exec num from rowsToRemoveY), (exec num from rowsToRemoveZ);
ungroupedTableShort: select from ungroupedTable where not countCubesMany in posToRemove;

.Q.gc[];

resList:{[list;none]
    show list;
    $[1<count list;
        [
            num1: list[0];
            num2: list[1];
            res: num1+num2;
            if[res>1;res: 1];
            // show res,2_list;
            :res,2_list
            ];
        [
            :list
            ]
        ];
    };

//res: list resList[;]/ list;
aggregated: select positionNum by xyzCross from ungroupedTableShort;
aggregated: update countPositionNum: count each positionNum from aggregated;
aggregatedOne: update first each positionNum from select from aggregated where countPositionNum=1;
firstNumber: count select from aggregatedOne where positionNum=1; // 206620j

aggregatedNotOne: delete from aggregated where countPositionNum=1;
aggregatedNotOne: update diffSign: {count distinct x} each positionNum from aggregatedNotOne;

aggregatedNotOneSameSign: select from aggregatedNotOne where diffSign=1;
aggregatedNotOneNotSameSign: delete from aggregatedNotOne where diffSign=1;

resFinalAggregatedNotOneNotSameSign: update res: {[x] x resList[;]/ x} each positionNum from aggregatedNotOneNotSameSign;
resFinalAggregatedNotOneNotSameSign: update first each res from resFinalAggregatedNotOneNotSameSign;

//resFinalAggregatedNotOne: update res: {[x] x resList[;]/ x} each positionNum from aggregatedNotOne;
//resFinalAggregatedNotOne: update first each res from resFinalAggregatedNotOne;

firstNumber+(count aggregatedNotOneSameSign)+7146
select count i by res from resFinalAggregatedNotOneNotSameSign
//590784 cubes are on.
//counted: ((select distinct xyzCross from ungroupedTable) lj
//    select offCount: count i by xyzCross from select from ungroupedTableShort where positionNum=-1) lj
//    (select onCount: count i by xyzCross from select from ungroupedTableShort where positionNum=1);
//
//select count i by sumCount from update sumCount: onCount-offCount from 0^counted
//select count i by sumPos from update sumPos: sum each positionNum from select positionNum by xyzCross from select from ungroupedTable where countCubesMany in (0;1;2)

