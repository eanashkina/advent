tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input7.txt;
system "l D:/Coding/advent/advent2019/intcode_comp.q";

//tableFromFile: "J"$ "," vs "3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0";
//tableFromFile: "J"$ "," vs "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5";

perm:{[N;l]$[N=1;l;raze .z.s[N-1;l]{x,/:y except x}\:l]};
combinations: {[N;l]  distinct each  perm[N;l]};
//allPhaseSettings: combinations[5;9 8 7 6 5];
allPhaseSettings: combinations[5;til 5];

runForOneCombination:{[targetPhase;tableFromFile]
    startInput: 0;
    initialTargetPhase: targetPhase;
    while[0<count targetPhase;
        input: (first targetPhase), startInput;
        targetPhase: 1_targetPhase;
        startInput: runOneInstruction[input;tableFromFile];
        show startInput
        ];
    :([] enlist "," sv string[initialTargetPhase];startInput)
    };

finalRes: raze runForOneCombination[;tableFromFile] each allPhaseSettings;
exec max startInput from finalRes //75228

allPhaseSettings: combinations[5;5+til 5];
tableFromFile: "J"$ "," vs "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5";
targetPhase: last allPhaseSettings;
startInput: 0;
show 0
input: (first targetPhase), startInput;
startInput1: runOneInstructionAmpl[input;tableFromFile;0];
targetPhase: 1_targetPhase;
input: (first targetPhase), startInput1[`output];
input: input where not null input;
startInput2: runOneInstructionAmpl[input;tableFromFile;0];
targetPhase: 1_targetPhase;
input: (first targetPhase), startInput1[`output];
input: input where not null input;
startInput3: runOneInstructionAmpl[input;tableFromFile;0];
targetPhase: 1_targetPhase;
input: (first targetPhase), startInput1[`output];
input: input where not null input;
startInput4: runOneInstructionAmpl[input;tableFromFile;0];
targetPhase: 1_targetPhase;
input: (first targetPhase), startInput1[`output];
input: input where not null input;
startInput5: runOneInstructionAmpl[input;tableFromFile;0];

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


