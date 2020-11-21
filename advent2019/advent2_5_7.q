system "c 300 300";

//tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input2_1.txt;
tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input5.txt;
// 5_1 works, proceed with 5_2
//tableFromFile: (1002,4,3,4,33);
//tableFromFile[1 2]: 12 2; // For task 2

runOneInstruction:{[tableFromFile] // works in 3.6, does not work in 3.5
    // Tasks 2_1, 2_2, 5_1.
    // show tableFromFile;
    countNum: 0;
    input: 1;
    output: 0;
    while[tableFromFile[countNum]<>99;
        show countNum;
        instruction: string tableFromFile[countNum];
        while[5>count instruction; // update if >3 inputs of instructions
            instruction: "0",instruction
            ];
        opcode: -2 sublist instruction;
        modes: 3 sublist instruction; // 3=5-2
        firstMode: last modes;
        secondMode: last -1_ modes;
        thirdMode: last -2_modes;
        $[all (opcode="1") or (opcode="01") or (opcode="2") or (opcode="02");
            [
                valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                $[all (opcode="1") or (opcode="01");valueThird: valueFirst+valueSecond;valueThird: valueFirst*valueSecond];
                // $[thirdMode="0";tableFromFile[tableFromFile[countNum+3]]: valueThird;thirdMode="1";tableFromFile[tableFromFile[countNum+3]]: valueThird;show "Wrong mode"]
                tableFromFile[tableFromFile[countNum+3]]: valueThird;
                countNum: countNum+4
                ];
            (all (opcode="3") or (opcode="03"));
                [
                    show "Input ", string input;
                    tableFromFile[tableFromFile[countNum+1]]: input;
                    countNum: countNum+2
                    ];
                (all (opcode="4") or (opcode="04"));
                    [
                        show "Output ",string output;
                        output: tableFromFile[tableFromFile[countNum+1]];
                        countNum: countNum+2
                        ];
                    show "Invalid input ",string  tableFromFile[countNum]
            ]; //all (opcode="1") or (opcode="01") or (opcode="2") or (opcode="02")
        // show tableFromFile;
        ]; //while
    countNum: countNum+1;
    :output // tableFromFile[0]
    };

res: runOneInstruction[tableFromFile];

input: ([] noun: til 100) cross ([] verb: til 100);
checkCombination:{[tableFromFile;inputRow]
    // Task 2.
    tableFromFile[1 2]: value inputRow;
    res: runOneInstruction[tableFromFile];
    if[res=19690720;
        :(100*inputRow[`noun])+inputRow[`verb];
        :()
        ];
    };

totalRes: raze checkCombination[tableFromFile;] each input;





    if[whatToDo=5;
        $[mode1=1;
            checkValue: tableFromFile[countNum+1];
            checkValue: tableFromFile[tableFromFile[countNum+1]]
            ];
        $[not checkValue=0;
            [
                $[mode2=1;
                    value2: tableFromFile[countNum+2];
                    value2: tableFromFile[tableFromFile[countNum+2]]
                    ];
                countNum: value2;
                ];
            countNum: countNum+3;
            ];
        ];
    if[whatToDo=6;
        $[mode1=1;
            checkValue: tableFromFile[countNum+1];
            checkValue: tableFromFile[tableFromFile[countNum+1]]
            ];
        $[checkValue=0;
            [
                $[mode2=1;
                    value2: tableFromFile[countNum+2];
                    value2: tableFromFile[tableFromFile[countNum+2]]
                    ];
                countNum: value2;
                ];
            countNum: countNum+3;
            ];
        ];
    if[whatToDo=7;
        $[mode1=1;
            value1: tableFromFile[countNum+1];
            value1: tableFromFile[tableFromFile[countNum+1]]
            ];
        $[mode2=1;
            value2: tableFromFile[countNum+2];
            value2: tableFromFile[tableFromFile[countNum+2]]
            ];
        position3: tableFromFile[countNum+3];
        $[value1<value2;
            tableFromFile[position3]: 1;
            tableFromFile[position3]: 0
            ];
        countNum: countNum+4;
        ];
    if[whatToDo=8;
        $[mode1=1;
            value1: tableFromFile[countNum+1];
            value1: tableFromFile[tableFromFile[countNum+1]]
            ];
        $[mode2=1;
            value2: tableFromFile[countNum+2];
            value2: tableFromFile[tableFromFile[countNum+2]]
            ];
        position3: tableFromFile[countNum+3];
        $[value1=value2;
            tableFromFile[position3]: 1;
            tableFromFile[position3]: 0
            ];
        countNum: countNum+4;
        ];
    :`table`countNum`inputNum`outputNum!(tableFromFile;countNum;inputNum;outputNum)














checkSetOfNumbers:{[dataset]
    tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input2_1.txt;
    tableFromFile[1]: dataset[0];
    tableFromFile[2]: dataset[1];

    cutTable: 4 cut tableFromFile;
    numOfIters: count cutTable;
    countNum: 0;
    while[countNum<numOfIters;
        data: cutTable[countNum];
        countNum: countNum+1;
        whatToDo: data[0];
        position1: data[1];
        position2: data[2];
        position3: data[3];
        if[whatToDo=99;
            tableFromFile: tableFromFile
            ];
        if[not whatToDo in (1 2);
            tableFromFile: tableFromFile
            ];
        if[whatToDo=1;
            tableFromFile[position3]: (tableFromFile[position1])+(tableFromFile[position2]);
            ];
        if[whatToDo=2;
             tableFromFile[position3]: tableFromFile[position1]*tableFromFile[position2];
             ];
        ];
    if[tableFromFile[0]=19690720;
        show "Yes";
        show dataset;
        ];
    };

(( til 99) cross ( til 99))[2]
raze checkSetOfNumbers each (( til 99) cross ( til 99))

/////////////////////////////////////////////////////////////////////////////////////////////////////

tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent2019/input5.txt;
//tableFromFile: "J"$ "," vs raze "3,21,1008,21,8,20,1005,20,22,107,",
//    "8,21,20,1006,20,31, 1106,0,36,98,",
//    "0,0,1002,21,125,20,4,20,1105,1,",
//    "46,104, 999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99";
inputNum: 5;
countNum: 0;
while[countNum<=(count tableFromFile);
    // data: cutTable[countNum];
    res: runOneInstruction[tableFromFile;countNum;inputNum];
    tableFromFile: res[`table];
    countNum: res[`countNum];
    outputNum: res[`outputNum];
    ];
outputNum
8684145j
///////////////////////////////////////////////////////////////



//tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input7.txt;
tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input2_1.txt;
tableFromFile: "J"$ "," vs "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5";

perm:{[N;l]$[N=1;l;raze .z.s[N-1;l]{x,/:y except x}\:l]};
combinations: {[N;l]  distinct each  perm[N;l]};
allPhaseSettings: combinations[5;9 8 7 6 5];
countAllPhases: 0;
resPhase: ([] phases: (); output: `long$());
allOutputs: ();
while[countAllPhases<(count allPhaseSettings);
    phaseSettings: allPhaseSettings[countAllPhases];
    countPhase: 0;
    secondInput: 0;
    while[countPhase<(count phaseSettings);
        allOutputs: `long$();
        countNum: 0;
        currentPhase: phaseSettings[countPhase];
        inputNum: currentPhase,secondInput;
        while[countNum<=(count tableFromFile);
            // data: cutTable[countNum];
            res: runOneInstruction[tableFromFile;countNum;inputNum];
            tableFromFile: res[`table];
            countNum: res[`countNum];
            inputNum: res[`inputNum];
            outputNum: res[`outputNum];
            allOutputs: allOutputs,outputNum;
            if[0<count outputNum;
                inputNum: outputNum;
                countNum: (count tableFromFile)+1
                ];
            ];
        countPhase: countPhase+1;
        show countPhase;
        secondInput: first allOutputs;
        ];
    countAllPhases: countAllPhases+1;
     if[(count allPhaseSettings)=countAllPhases;
         countAllPhases: 0;
        ];
    resPhase: resPhase,(`phases`output!(phaseSettings;first allOutputs));
    show tableFromFile[countNum];
    show first `output xdesc resPhase
    ];
`output xdesc resPhase


