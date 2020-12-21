system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input12_1.txt);
//initialTable: ([] ("F10";"N3";"F7";"R90";"F11"));
initialTable: update action: {`$(1#x)} each x, num: "J"${1_x} each x from initialTable;
initialTable: update newRow: 0, newCol: 0, newDegree: 0 from initialTable;
// select distinct num from initialTable where action in `L`R // 90, 180, 270

//startRow: 0;
//startCol: 0;
//startDegree: 90;

//targetRow: startRow;
//targetCol: startCol;
//targetDegree: startDegree;
//
//targetStep: 0;


doOneInstruction:{[initialTable;targetStep;nothing]
    show targetStep;
    action: initialTable[targetStep][`action];
    num: initialTable[targetStep][`num];

    $[targetStep=0;
        [
            targetRow: 0;
            targetCol: 0;
            targetDegree: 90;
            ];
        [
            targetRow: initialTable[targetStep-1][`newRow];
            targetCol: initialTable[targetStep-1][`newCol];
            targetDegree: initialTable[targetStep-1][`newDegree]
            ]
        ];

    show targetRow;
    show targetCol;
    show targetDegree;

    if[targetDegree>=360;targetDegree: targetDegree-360];
    if[targetDegree<0;targetDegree: targetDegree+360];

    $[targetDegree=90;
        direction: `east;
            targetDegree=180;
                direction: `south;
                    targetDegree=270;
                        direction: `west;
                            targetDegree=0;
                                direction: `north;
                                    show "error"
                                    ];
    show direction;

    if[action=`N;targetRow: targetRow-num];
    if[action=`S;targetRow: targetRow+num];
    if[action=`E;targetCol: targetCol+num];
    if[action=`W;targetCol: targetCol-num];
    if[action=`L;targetDegree: targetDegree-num];
    if[action=`R;targetDegree: targetDegree+num];
    if[action=`F;
        if[direction=`east;targetCol: targetCol+num];
        if[direction=`south;targetRow: targetRow+num];
        if[direction=`west;targetCol: targetCol-num];
        if[direction=`north;targetRow: targetRow-num];
        ];

    :update newRow: targetRow, newCol: targetCol, newDegree: targetDegree from initialTable where i=targetStep
    };

res: initialTable doOneInstruction[;;`none]/ til count initialTable;
abs exec (last newRow)+(last newCol) from res


