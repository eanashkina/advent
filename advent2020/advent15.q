system "c 300 300";

// Part 1

initialTable: ([] number: 17 1 3 16 19 0);
// initialTable: ([] number: 3 1 2);

turnsTotal: 2019; // 2020th number spoken; consider changing if enumeration is from zero
turnsTotal: 30000000-1;
targetTurn: 0;
newTable: initialTable;
//targetTurn: 4
while[targetTurn<=turnsTotal;
    show "The number of the response ",string targetTurn+1;
    $[targetTurn<count initialTable;
        [
//            show "This is initial table.";
//            show initialTable[`number][targetTurn];
            ];
        [
            // The numbers in the initial list are not repeated (in my case).
            lastNum: newTable[`number][targetTurn-1];
//            show "Last number ",string lastNum;
            newTable: update isLastNumSeen: ?[lastNum=number;1b;0b] from newTable;
            numMentions: count select from newTable where isLastNumSeen;
            $[numMentions>1;
                [
//                    show "We have seen this number.";
                    targetTable: select from (update turnNum: i+1 from newTable) where isLastNumSeen;
                    targetTable: -2#targetTable;
//                    show targetTable;
                    newNum: targetTable[`turnNum][1]-targetTable[`turnNum][0];
                    newTable: (delete isLastNumSeen from newTable),([] number: enlist newNum);
                    ];
                [
//                    show "New number.";
                    newTable: (delete isLastNumSeen from newTable),([] number: enlist 0);
                    ]
                ];

            // show newTable;
            ]
        ];
    targetTurn: targetTurn+1;
    ];

show last newTable // 694