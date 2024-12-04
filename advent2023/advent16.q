initialTable: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input16_1_1.txt;
//([] initialTable)
//moveTable: ([] x: enlist 0; y: 0; dir: `r; step: 0);
// For my input it actually should be d:
moveTable: ([] x: enlist 0; y: 0; dir: `d; step: 0);
targetStep: 0;
stepsToAnalyse: select from moveTable where step=targetStep;

// targetRow: stepsToAnalyse[0]; 1 2
// processOneRow[targetRow;initialTable;rowLength;tableSize]
rowLength: first count each initialTable;
tableSize: count initialTable;



// if tries to move outside the table - remove
processOneRow:{[targetRow;initialTable;rowLength;tableSize]
    //show targetRow;
    xOld: targetRow`x;
    yOld: targetRow`y;
    dirOld: targetRow`dir;
    step: targetRow`step;

    if[dirOld=`r;
        newX: xOld;
        newY: (yOld+1)&(rowLength-1);
        ];

    if[dirOld=`l;
        newX: xOld;
        newY: (yOld-1)|0;
        ];

    if[dirOld=`u;
        newX: (xOld-1)|0;
        newY: yOld;
        ];

    if[dirOld=`d;
        newX: (xOld+1)&(tableSize-1);
        newY: yOld;
        ];

    newSym: `$initialTable[newX][newY];

    if[newSym=`$".";
        newStep: step+1;
        newDir: dirOld;
        moveTableRow: ([] x: enlist newX; y: newY; dir: newDir; step: newStep);
        ];

    if[newSym=`$"/";
        newStep: step+1;
        newDir: ?[dirOld=`r;`u;?[dirOld=`u;`r;?[dirOld=`l;`d;`l]]];
        moveTableRow: ([] x: enlist newX; y: newY; dir: newDir; step: newStep);
        ];

    if[newSym=`$"\\";
        newStep: step+1;
        newDir: ?[dirOld=`r;`d;?[dirOld=`d;`r;?[dirOld=`l;`u;`l]]];
        moveTableRow: ([] x: enlist newX; y: newY; dir: newDir; step: newStep);
        ];

    if[newSym=`$"|";
        newStep: step+1;
        $[dirOld in `l`r;
            [
                // split
                moveTableRow: ([] x: enlist newX; y: newY; dir: `u; step: newStep);
                moveTableRow,: ([] x: enlist newX; y: newY; dir: `d; step: newStep)
                ];
            [
                newDir: dirOld;
                moveTableRow: ([] x: enlist newX; y: newY; dir: newDir; step: newStep)
                ]
            ];
        ];

    if[newSym=`$"-";
        newStep: step+1;
        $[dirOld in `u`d;
            [
                // split
                moveTableRow: ([] x: enlist newX; y: newY; dir: `l; step: newStep);
                moveTableRow,: ([] x: enlist newX; y: newY; dir: `r; step: newStep)
                ];
            [
                newDir: dirOld;
                moveTableRow: ([] x: enlist newX; y: newY; dir: newDir; step: newStep)
                ]
            ];
        ];

    //    show moveTableRow;
    //    show newDir;
    moveTableRow: update step: newStep-1 from moveTableRow where (x=xOld), (y=yOld), (dir=dirOld);
    :moveTableRow
    };

while[targetStep<1000;
    show targetStep;
    moveTable,: raze processOneRow[;initialTable;rowLength;tableSize] each stepsToAnalyse;
    moveTable: () xkey `step xasc select first step by x, y, dir from moveTable;
    targetStep: targetStep+1;
    stepsToAnalyse: select from moveTable where step=targetStep;
    ];

select count i by x, y from moveTable // 8045 too high











