system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input8_1.txt);
initialTable: update parsed: " " vs  'x from initialTable;
initialTable: update operation: `$parsed[;0], argument: parsed[;1] from initialTable;

targetInstruction: 0;
accumulator: 0;
allInstructions: ();
isRepeated: 0b;

while[not isRepeated;
    targetOperation: initialTable[targetInstruction][`operation];
    targetArgument: "J"$initialTable[targetInstruction][`argument];
    show targetInstruction;
    show targetOperation;
    show targetArgument;
    if[targetOperation=`acc;accumulator: accumulator+targetArgument;targetInstructionNew: targetInstruction+1];
    if[targetOperation=`jmp;targetInstructionNew: targetInstruction+targetArgument];
    if[targetOperation=`nop;targetInstructionNew: targetInstruction+1];

    allInstructions: allInstructions,targetInstruction;
    targetInstruction: targetInstructionNew;
    if[targetInstruction in allInstructions;show "Repeat";show accumulator;isRepeated: 1b];
    ];

accumulator // 1614

replacementPlaces: exec i from initialTable where operation in `jmp`nop;
// targetReplacement: 7;
checkReplacement:{[targetReplacement;initialTable]
    show targetReplacement;
    targetOperation: initialTable[targetReplacement][`operation];
    if[targetOperation=`jmp;initialTable: update operation: `nop from initialTable where i=targetReplacement];
    if[targetOperation=`nop;initialTable: update operation: `jmp from initialTable where i=targetReplacement];

    targetInstruction: 0;
    accumulator: 0;
    allInstructions: ();
    isRepeated: 0b;

    while[(not isRepeated) and (targetInstruction<(count initialTable));
        targetOperation: initialTable[targetInstruction][`operation];
        targetArgument: "J"$initialTable[targetInstruction][`argument];
                show targetInstruction;
                show targetOperation;
                show targetArgument;
        if[targetOperation=`acc;accumulator: accumulator+targetArgument;targetInstructionNew: targetInstruction+1];
        if[targetOperation=`jmp;targetInstructionNew: targetInstruction+targetArgument];
        if[targetOperation=`nop;targetInstructionNew: targetInstruction+1];

        allInstructions: allInstructions,targetInstruction;
        targetInstruction: targetInstructionNew;
        if[targetInstruction in allInstructions;show "Repeat";show accumulator;isRepeated: 1b];
        ];
    :([] enlist targetReplacement;isRepeated;accumulator)
    };

res: raze checkReplacement[;initialTable] each replacementPlaces;
