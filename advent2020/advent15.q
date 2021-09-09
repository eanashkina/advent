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
turnsTotal: 30000000-1;
//turnsTotal: 2019;
testTable: ([] num: til 200000; lastSeen: 0N; prevSeen: 0N);
//
//100#testTable
targetTurn: 0;
thisNum: 0N;

while[targetTurn<=turnsTotal;
    if[(targetTurn-(10000*(targetTurn div 10000)))=0;
        show "The number of the response ",string targetTurn+1;
        ];
    $[targetTurn<count initialTable;
        [
            // show "This is initial table.";
            thisNum: initialTable[`number][targetTurn];
            testTable: update lastSeen: targetTurn from testTable where num=thisNum;
            ];
        [
            // The numbers in the initial list are not repeated (in my case).
            // show "Last number ",string thisNum;
            if[thisNum>count testTable;
                'string[thisNum]," is outside the table"
                ];
            lastSeenNum: first exec lastSeen from testTable where num=thisNum;
            lastSeenPrev: first exec prevSeen from testTable where num=thisNum;
            $[not null lastSeenPrev;
                [
                    // show "We have seen this number ",string thisNum;
                    newNum: lastSeenNum-lastSeenPrev;
                    testTable: update prevSeen: lastSeen, lastSeen: targetTurn from testTable where num=newNum;
                    ];
                [
                    // show "Number not seen before ",string thisNum;
                    newNum: 0;
                    testTable: update prevSeen: lastSeen, lastSeen: targetTurn from testTable where num=newNum;
                    ]
                ];
            thisNum: newNum;
            ]
        ];
    targetTurn: targetTurn+1;
    ];

thisNum
// Numbers after 14756 are seen occasionally - instead of preparing large table, add them if they are found

// 100540 - after 100,000 iterations 1554j	104556j	4016j
// 200268 - after  200,000 iterations 5365j	206885j	6617j

// 9 sec - 10,000
30,000,000%10,000 = 3000