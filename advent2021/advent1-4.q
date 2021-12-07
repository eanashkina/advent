system "c 300 300";
initialTable: "F"$([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input1_1.txt);
select count i by isPositive:?[diff>0;1b;0b] from 1_update diff: deltas x from initialTable

select count i by isPositive:?[diff>0;1b;0b] from 1_update diff: deltas movSum from 2_update movSum: 3 msum x from initialTable

// 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input2_1.txt);
initialTable: ([] read0 `$":C:/Users/anash/MyPC/Coding/advent/advent2021/new 3.txt");

initialTable: update parsed: (" " vs) each x from initialTable;
initialTable: update direction: `$parsed[;0], number: "I"$parsed[;1] from initialTable;
horPosition: exec sum number from initialTable where direction=`forward; // 2083
initialTable: update sign: ?[direction=`down;1;?[direction=`up;-1;0]] from initialTable;
depth: exec sum number*sign from initialTable where not direction=`forward; // 955
horPosition*depth

iNum: 0;
aim: 0;
depth: 0;
while[iNum<count initialTable;
    show iNum;
    targetDirection: exec first direction from initialTable where i=iNum;
    targetNum: exec first number from initialTable where i=iNum;
    targetSign: exec first sign from initialTable where i=iNum;
    $[targetDirection in `up`down;
        aim: aim+(targetSign*targetNum);
        depth: depth+(aim*targetNum)];

    iNum: iNum+1;

    ];

horPosition*depth // 11935590 too low 2089174012

// 3
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input3_1.txt);
// 12 positions
posNum: til 12;

targetPosNum: 0;
checkOnePosition:{[targetPosNum;initialTable]
    selectedData: `x xdesc select count i by targetPosNum from select x[;targetPosNum] from initialTable;
    :"J"$exec first targetPosNum from selectedData
    };

res: checkOnePosition[;initialTable] each posNum;
exec targetP
(2 sv  res)*(((2 xexp 12)-1)-(2 sv  res)) // 2261546

// part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input3_1.txt);
// 12 positions
posNum: til 12;

//targetPosNum: 2;
checkOnePositionOxygen:{[initialTable;targetPosNum]
    show targetPosNum;
    res: update pos: x[;targetPosNum] from initialTable;
    res: update (`$) each pos from res;
    countValues: select count i by pos from res;
    $[(exec first x from countValues)=(exec last x from countValues);
        mostCommonValue: `1;
        mostCommonValue: exec first pos from `x xdesc countValues
        ];
    initialTable: delete pos from select from res where pos=mostCommonValue;
    show mostCommonValue;
    show initialTable;
    :initialTable
    };

finalLineOxygen: initialTable checkOnePositionOxygen[;]/ posNum;

checkOnePositionCO2:{[initialTable;targetPosNum]
    show targetPosNum;
    res: update pos: x[;targetPosNum] from initialTable;
    res: update (`$) each pos from res;
    countValues: select count i by pos from res;
    $[(exec first x from countValues)=(exec last x from countValues);
        mostCommonValue: `0;
        mostCommonValue: exec first pos from `x xasc countValues
        ];
    initialTable: delete pos from select from res where pos=mostCommonValue;
    show mostCommonValue;
    show initialTable;
    :initialTable
    };

finalLineCO2: initialTable checkOnePositionCO2[;]/ posNum;

ox: first exec x from finalLineOxygen;

(2 sv "J"$string first exec x from finalLineOxygen)*(2 sv "J"$string first exec x from finalLineCO2)

// 4
system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input4_1.txt);
nums: "J"$"," vs first exec x from initialTable;
initialTable: 2_initialTable;

initialTable: update ssr[;"  ";" "] each x from initialTable;
initialTable: update countNum: count each x from update "J"$(" " vs) each x from initialTable;
initialTable: update isBreak: ?[countNum=1;1;0] from initialTable;
initialTable: select x, isBreak, numTable: sums isBreak from initialTable;
initialTable: delete from initialTable where isBreak=1;
//select count i by numTable from initialTable

initialTable: update {x where not null x} each x from initialTable;
// initialTable: update firstCol: 0, secondCol: 0, thirdCol: 0, fourthCol: 0, fifthCol: 0 from initialTable;
initialTable: delete isBreak from initialTable;
initialTable: update numInCol: 0N from initialTable;

//initialTable: select from initialTable where numTable<4;

//targetNum: first nums; // 66 39 9 87 85
targetNum: 66;
targetNum: 39;
targetNum: 9;
targetNum: 87;
targetNum: 85;

checkOneNum:{[initialTable;targetNum]
    show targetNum;
    // show initialTable;
    // show cols initialTable;
    if[not `winnerNum in cols initialTable;
        // update isNumInCol: targetNum in/:x from initialTable
        initialTable: update isNumInColNew: ?[;targetNum] each x from initialTable;
        initialTable: update isNumInColNew: 0Nj from initialTable where isNumInColNew=5;
        initialTable: update isLineWinner: 0b from update numInCol: (numInCol,'isNumInColNew) from initialTable;
        checkedTable: checkLines each initialTable;
        winnerLine: select from checkedTable where isLineWinner=1b;
        $[0<count winnerLine;
            [
                show "The winner is ",string targetNum;
                :update winnerNum: targetNum from winnerLine
                ];
            [
                numTables: distinct exec numTable from initialTable;
                initialTable: raze checkTable[initialTable;] each numTables;
                valuesWinner: count select from initialTable where isLineWinner=1b;
                // show initialTable;
                if[0<valuesWinner;
                    show select from initialTable where isLineWinner=1b;
                    initialTable: update winnerNum: targetNum from initialTable
                    ];
                ]
            ];
        ];
        :initialTable
    };

checkOneNumPartTwo:{[initialTable;targetNum]
    show targetNum;
     show initialTable;
    // show cols initialTable;

    initialTable: update isNumInColNew: ?[;targetNum] each x from initialTable;
    initialTable: update isNumInColNew: 0Nj from initialTable where isNumInColNew=5;
    initialTable: update isLineWinner: 0b from update numInCol: (numInCol,'isNumInColNew) from initialTable;
    checkedTable: checkLines each initialTable;
    winnerLine: select from checkedTable where isLineWinner=1b;
    $[0<count winnerLine;
        [
            tableToDelete: exec numTable from checkedTable where isLineWinner=1b;
            show tableToDelete;
            :delete from initialTable where numTable in tableToDelete
            ];
        [
            numTables: distinct exec numTable from initialTable;
            initialTable: raze checkTable[initialTable;] each numTables;
            :delete from initialTable where isLineWinner=1b;
            ]
        ];
    };

//nums: 66 39 9 87 85;
res: initialTable checkOneNumPartTwo/ nums;

tableToDelete: 10

//row: first initialTable
checkLines:{[row]
    // show "CheckLines";
    values: asc distinct exec numInCol from row;
    values: values where not null values;
    if[5=(count values);row: update isLineWinner: 1b from row];
    :row
    };

//checkTable[initialTable;2]
//numTableTarget: 2
checkTable:{[initialTable;numTableTarget]
    // show "Check table";
    selectedTable: select from initialTable where numTable=numTableTarget;
    // show selectedTable;
    values: raze exec numInCol from selectedTable;
    values: values where not null values;
    if[0<count values;
        $[5=first desc count each group values;
            [
                :update isLineWinner: 1b from selectedTable where numTable=numTableTarget
                ];
            [
                :selectedTable
                ]
            ];
        ];
    :selectedTable
    };

winnerNumTarget: first exec winnerNum from res;
calledNums: nums[til 1+ nums?winnerNumTarget];



boardNums: raze exec x from initialTable where numTable=(first exec numTable from res);

boardNums: raze exec x from res where isLineWinner=1;

(sum boardNums where not boardNums in calledNums)*winnerNumTarget // 34506


calledNums: nums[til 1+ nums?42];
boardNums: raze exec x from initialTable where numTable=58;
(sum boardNums where not boardNums in calledNums)*42 // 7686

