system "c 300 300";
initialTable: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input6_2.txt;
xPos: first where {x like "*^*"} each initialTable;
yPos: first where initialTable[xPos]="^";
direction: -1 0;

posTable: ([] xPos; yPos; enlist direction);

processStep:{[posTable;initialTable]
    lastPos: last posTable;
    //show lastPos;
    dirs: lastPos[`direction];
    newXPos: lastPos[`xPos]+first dirs;
    newYPos: lastPos[`yPos]+last dirs;

    element: `$initialTable[newXPos][newYPos];
    if[element=`$"#";
        //show "Rotation";
        newXPos: lastPos[`xPos];
        newYPos: lastPos[`yPos];
        if[neg[1]=first dirs
            //show "From north to east";
            direction: 0 1;
            :posTable,([] xPos: newXPos; yPos: newYPos; direction: enlist direction)
            ];
        if[1=first dirs;
            //show "From south to west";
            direction: 0 -1;
            :posTable,([] xPos: newXPos; yPos: newYPos; direction: enlist direction)
            ];
        if[neg[1]=last dirs;
            //show "From west to north";
            direction: -1 0;
            :posTable,([] xPos: newXPos; yPos: newYPos; direction: enlist direction)
            ];
        if[1=last dirs;
            //show "From east to south";
            direction: 1 0;
            :posTable,([] xPos: newXPos; yPos: newYPos; direction: enlist direction)
            ];
        ];
    :posTable,([] xPos: newXPos; yPos: newYPos; direction: enlist dirs)
    };

c: 0;
while[((exec last xPos from posTable)<(-1+first count each initialTable))
    and ((exec last yPos from posTable)<(-1+count initialTable))
    and ((exec last xPos from posTable)>0)
    and ((exec last yPos from posTable)>0);
    c: c+1;
    show c;
    posTable: processStep[posTable;initialTable];
    ];

// 4663
distinctSteps: () xkey select count i by xPos, yPos from posTable;

// part 2
//line: `xPos`yPos`x!6 3 2j;

xPos1: first where {x like "*^*"} each initialTable;
yPos1: first where initialTable[xPos1]="^";
direction1: -1 0;

posTable: ([] xPos: xPos1; yPos: yPos1; enlist direction);

distinctSteps: delete from distinctSteps where xPos=xPos1, yPos=yPos1;

updateTestMap:{[line;initialTable;xPos1;yPos1;direction1]
    show line;
    posTable: ([] xPos: xPos1; yPos: yPos1; direction: enlist direction1);
    razedLine: (`$string raze initialTable);
    razedLine[((first count each initialTable)*line[`xPos])+line[`yPos]]: `$"#";

    newTable: (first count each initialTable) cut raze string razedLine;
    c: 0;
    uniqueness: 1;
    while[((exec last xPos from posTable)<(-1+first count each initialTable))
        and ((exec last yPos from posTable)<(-1+count initialTable))
        and ((exec last xPos from posTable)>0)
        and ((exec last yPos from posTable)>0)
        and uniqueness=1;
        c: c+1;
        //show c;
        posTable: processStep[posTable;newTable];
        uniqueness: max exec x from select count i by xPos, yPos, direction from posTable;
        ];
    :([] enlist line; uniqueness)
    };


test: raze updateTestMap[;initialTable;xPos1;yPos1;direction1] each distinctSteps;
select from test where uniqueness>1
//1530