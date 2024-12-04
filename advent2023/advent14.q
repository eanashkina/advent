initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input14_2.txt);

lengthLine: count exec x from first initialTable;
targetNum: 0;

flipOneCol:{[initialTable;targetNum]
    :([] x: enlist exec {x[y]}'[x;y] from update y: targetNum from initialTable)
    };

initialTableTransposed: raze flipOneCol[select x from initialTable;] each til lengthLine;
//initialTableTransposed: update ssr[;".O";"O"] each x from initialTableTransposed;

//moveStone:{[initialTableTransposed]
//    :update ssr[;".O";"O"] each x from initialTableTransposed;
//    };

checkTable: ();

while[not initialTableTransposed~checkTable;
    checkTable: initialTableTransposed;
    initialTableTransposed: update ssr[;".O";"O."] each x from initialTableTransposed;
    ];

lengthLine: count exec x from first initialTableTransposed;
initialTableTransposedTransposed: raze flipOneCol[select x from initialTableTransposed;] each til lengthLine;
initialTableTransposedTransposed: reverse update lineNum: i+1 from reverse initialTableTransposedTransposed;
initialTableTransposedTransposed: update stonesSym: `$string each x from initialTableTransposedTransposed;
initialTableTransposedTransposed: update countStones: {count where x=`O} each stonesSym from initialTableTransposedTransposed;

exec sum lineNum*countStones from initialTableTransposedTransposed // 109424

// Part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input14_2.txt);
moveOneCycle:{[initialTable]
    lengthLineX: count exec x from first initialTable;
    initialTableTransposed: raze flipOneCol[select x from initialTable;] each til lengthLineX;

    checkTable: ();
    while[not initialTableTransposed~checkTable;
        checkTable: initialTableTransposed;
        initialTableTransposed: update ssr[;".O";"O."] each x from initialTableTransposed; //north
        ];

    lengthLineY: count exec x from first initialTableTransposed;
    initialTable: raze flipOneCol[select x from initialTableTransposed;] each til lengthLineY;

    checkTable: ();
    while[not initialTable~checkTable;
        checkTable: initialTable;
        initialTable: update ssr[;".O";"O."] each x from initialTable; // west
        ];

    initialTableTransposed: raze flipOneCol[select x from initialTable;] each til lengthLineX;

    checkTable: ();
    while[not initialTableTransposed~checkTable;
        checkTable: initialTableTransposed;
        initialTableTransposed: update ssr[;"O.";".O"] each x from initialTableTransposed; //south
        ];

    initialTable: raze flipOneCol[select x from initialTableTransposed;] each til lengthLineY;

    checkTable: ();
    while[not initialTable~checkTable;
        checkTable: initialTable;
        initialTable: update ssr[;"O.";".O"] each x from initialTable; //east
        ];
    :initialTable
    };

initialTableNew: moveOneCycle[initialTable];
checkTable: enlist `$raze exec x from initialTableNew;
checkTableNew: `;
num: 0;
while[not any checkTableNew in checkTable;
    num: num+1;
    show num;
    // checkTable: initialTable;
    checkTable: checkTable,checkTableNew;
    initialTableNew: moveOneCycle[initialTableNew];
    checkTableNew: enlist `$raze exec x from initialTableNew;

    ];

where checkTableNew in checkTable
update isLine: {[checkTableNew;x] x=checkTableNew}[checkTableNew;] each x from delete from ([] x: checkTable,checkTableNew) where i=1
// 3rd cycle is the same as 10th in 14_1
// 101th cycle is the same as 110th in 14_2
3+7*til 10
(1000000000-3) mod 7

101+9*til 10
(1000000000-101) mod 9

// need 3+3th cycle in 14_1
// need 8+101th cycle in 14_2

initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input14_2.txt);
num: 0;
table: ();
while[num<200;
    num: num+1;
    show num;
    initialTable: moveOneCycle[initialTable];
    initialTable: reverse update lineNum: i+1 from reverse initialTable;
    initialTable: update stonesSym: `$string each x from initialTable;
    initialTable: update countStones: {count where x=`O} each stonesSym from initialTable;

    show exec sum lineNum*countStones from initialTable; // 109424
    table: table,([] enlist num;exec sum lineNum*countStones from initialTable);
    initialTable: delete lineNum, stonesSym, countStones from initialTable;
    ];

//102509