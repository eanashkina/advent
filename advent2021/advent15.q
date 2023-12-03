system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input15_0.txt);
// "1163751742"
//"1381373672"
numCols: first distinct exec count each x from initialTable;
targetLine: initialTable[0];
colNames: `$"a",/: string til numCols;

parseOneLine:{[targetLine;numCols;colNames]
    // show targetLine;
    targetLine: exec x from targetLine;
    :pivot `nums xkey update nums: colNames from ([] first each string targetLine)
    };

parsedTable: raze parseOneLine[;numCols;colNames] each initialTable;

















///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
pivotedTable: ([] line: exec (numCols#"C";numCols#1) 0: x from initialTable);

pivot:{[t]
    u: `$string asc distinct last f:flip key t;
    pf:{x#(`$string y)!z};
    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
    p
    };


{(!) . "C" 0: x} each initialTable`x
select {([] string x)} each x from initialTable

initialTable: raze initialTable;
targetDiag: 3;
coord: (10*(til targetDiag)) + reverse til targetDiag;

initialTable[coord]
targetDiag: targetDiag+1;



