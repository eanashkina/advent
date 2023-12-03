system "c 300 300";
initialTable: ([] line: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input25_1.txt);
initialTableOld: initialTable;
countNumX: 0;
countNumY: 0;

//show countNum;
initialTable: update isCurrent: {(last[x]=">") and (first[x]=".")} each line from initialTable;
// One right move:
initialTable: update line: {ssr[x;">.";".>"]} each line from initialTable;
initialTable: update line: {">",(1_(-1)_x),"."} each line from initialTable where isCurrent;
initialTable: delete isCurrent from initialTable;
$[not initialTable~initialTableOld;
    [
        show countNumX;
        countNumX: countNumX+1;
        ];
    [

        show "Stop trying first move";
        ]
    ];
initialTableOld: initialTable;

numCols: first distinct exec count each line from initialTable;

pivotedTable: ([] line: exec (numCols#"C";numCols#1) 0: line from initialTable);
pivotedTable: update isCurrent: {(last[x]="v") and (first[x]=".")} each line from pivotedTable;
pivotedTable: update line: {ssr[x;"v.";".v"]} each line from pivotedTable;
pivotedTable: update line: {"v",(1_(-1)_x),"."} each line from pivotedTable where isCurrent;
pivotedTable: delete isCurrent from pivotedTable;

numColsPivoted: first distinct exec count each line from pivotedTable;
doublePivotedTable: ([] line: exec (numColsPivoted#"C";numColsPivoted#1) 0: line from pivotedTable);
$[not initialTable~doublePivotedTable;
    [
        initialTable: doublePivotedTable;
        show countNumY;
        countNumY: countNumY+1;
        // show initialTable;
        ];
    [
        initialTable: doublePivotedTable;
        show "Stop trying second move";
        ]
    ];

//"v...>.>vv>"
//".vv>.>vv.."
//">.>>v.>..v"
//">>v>.>.>v."
//"v>v.vv.v.."
//".>>.>.v..."
//".vv...>>v."
//"v.v..>>v.v"
//">...v..v.."

pivot:{[t]
    u: `$string asc distinct last f:flip key t;
    pf:{x#(`$string y)!z};
    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
    p
    };

// One bottom move:
// One row:
targetRow: 0;
pivot `numI xkey update numI: i from delete isCurrentRight from initialTable
flip select line from initialTable

t: ([] line: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input25_0.txt);

t,'flip exec `a`b`c!("HHH";"")0:line from t


colNames: `$"a",/: string til numCols;

initialTable,'flip exec colNames!("CCCCCCCCCC";1 1 1 1 1 1 1 1 1 1) 0: line from initialTable

flip flip

exec colNames!("CCCCCCCCCC";1 1 1 1 1 1 1 1 1 1) 0: line from initialTable




(enlist "v...>>.vv>")

`d`e`f`g`h`k`l