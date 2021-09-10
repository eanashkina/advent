system "c 300 300";

// Part 1

initialTable: ([] number: 17 1 3 16 19 0);
//initialTable: ([] number: 0 3 6);

turnsTotal: 2019; // 2020th number spoken; consider changing if enumeration is from zero

targetTurn: 0;
countNum: 0;
newTable: initialTable;
//targetTurn: 4
while[targetTurn<=turnsTotal;
    if[(targetTurn-(100000*(targetTurn div 100000)))=0;
        show "The number of the response ",string targetTurn+1;
        ];
    $[countNum<count initialTable;
        [
            show "This is initial table.";
            show initialTable[`number][countNum];
            newTable: update lastSaw: countNum from newTable where i=countNum;
            ];
        [
            // The numbers in the initial list are not repeated (in my case).
            lastNum: newTable[`number][countNum-1];
            // show "Last number ",string lastNum;
            newTable: update isLastNumSeen: ?[lastNum=number;1b;0b] from newTable;
            numMentions: count select from newTable where isLastNumSeen;
            $[numMentions>1;
                [
                    // show "We have seen this number ",string lastNum;
                    targetTable: select from newTable where isLastNumSeen;
                    targetTableOther: select from newTable where not isLastNumSeen;
                    targetTableShort: -2#targetTable;
                    //show targetTable;
                    newNum: targetTableShort[`lastSaw][1]-targetTableShort[`lastSaw][0];
                    newTable: (delete isLastNumSeen from (targetTableOther,(last targetTableShort))),([] number: enlist newNum; lastSaw: targetTurn);
                    countNum: countNum-1;
                    ];
                [
                    // show "New number ",string lastNum;
                    newTable: (delete isLastNumSeen from newTable),([] number: enlist 0; lastSaw: targetTurn);
                    ]
                ];

            // show newTable;
            ]
        ];
    targetTurn: targetTurn+1;
    countNum: countNum+1;
    ];

show last newTable // 694

// Part 2
turnsTotal: 30000000;
//turnsTotal: 2020;
//turnsTotal: 11;

initialList: 17 1 3 16 19 0;
// initialList: 0 3 6;

lastPos: turnsTotal#0;
prevPos: turnsTotal#0;
targetTurn: 1+count initialList;

lastPos[initialList]: 1+til count initialList;
prevPos[initialList]: 1+til count initialList;
thisNum: last initialList;

while[targetTurn<=turnsTotal;
     if[(targetTurn-(10000*(targetTurn div 10000)))=0;
        show "The number of the response ",string targetTurn;
         ];
    $[not lastPos[thisNum]=0;
        [
            // show "We have seen this number ",string thisNum;
            newNum: lastPos[thisNum]-prevPos[thisNum];

            prevPos[newNum]: $[lastPos[newNum]=0;targetTurn;lastPos[newNum]];
            lastPos[newNum]: targetTurn;
            ];
        [
            // show "Number not seen before ",string thisNum;
            newNum: 0;
            prevPos[newNum]: targetTurn;
            lastPos[newNum]: targetTurn;
            ]
        ];
    thisNum: newNum;
    // show thisNum;
    // show prevPos;
    // show lastPos;
    targetTurn: targetTurn+1;
    ];

thisNum
