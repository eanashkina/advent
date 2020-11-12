system "c 300 300";
checkSetOfNumbers:{[dataset]
    tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent2019/input2_1.txt;
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

runOneInstruction:{[tableFromFile;countNum;inputNum]
    show "Current num ",string[countNum];
    show tableFromFile;
    instruction: tableFromFile[countNum];
    show instruction;
    instruction: "F"$string[string[instruction]];
    while[(count instruction)<5;
        instruction: 0, instruction;
        ];
    whatToDo: instruction[4]+10*instruction[3];
    mode1: instruction[2];
    mode2: instruction[1];
    mode3: instruction[0];
    if[whatToDo=99;
        tableFromFile: tableFromFile;
        countNum: 1+count tableFromFile
        ];
    if[whatToDo=1;
        $[mode1=1;
            value1: tableFromFile[countNum+1];
            value1: tableFromFile[tableFromFile[countNum+1]]
            ];
        $[mode2=1;
            value2: tableFromFile[countNum+2];
            value2: tableFromFile[tableFromFile[countNum+2]]
            ];
        position3: tableFromFile[countNum+3];
        tableFromFile[position3]: value1+value2;
        countNum: countNum+4;
        ];
    if[whatToDo=2;
        $[mode1=1;
            value1: tableFromFile[countNum+1];
            value1: tableFromFile[tableFromFile[countNum+1]]
            ];
        $[mode2=1;
            value2: tableFromFile[countNum+2];
            value2: tableFromFile[tableFromFile[countNum+2]]
            ];
        position3: tableFromFile[countNum+3];
        tableFromFile[position3]: value1*value2;
        countNum: countNum+4;
        ];
    if[whatToDo=3;
        position: tableFromFile[countNum+1];
        tableFromFile[position]: first inputNum;
        if[1<count inputNum;inputNum: 1_inputNum];
        countNum: countNum+2;
        ];
    if[whatToDo=4;
        $[mode1=1;
            valueNum: tableFromFile[countNum+1];
            valueNum: tableFromFile[tableFromFile[countNum+1]];
            ];
        outputNum: valueNum;
        countNum: countNum+2;
        ];
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
    };

tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent2019/input7.txt;
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


