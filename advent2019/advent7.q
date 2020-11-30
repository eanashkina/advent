tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input7.txt;
system "l D:/Coding/advent/advent2019/intcode_comp.q";

//tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input7.txt;
tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input2_1.txt;
tableFromFile: "J"$ "," vs "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5";


runOneInstruction[tableFromFile]


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


