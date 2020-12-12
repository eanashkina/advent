system "c 300 300";
initialTable: "J"$([] read0 `:D:/Coding/advent/advent2020/input9_1.txt);
numSteps: til (count initialTable)-25;
targetStep: 0;

checkOneNumber:{[initialTable;targetStep]
    show targetStep;
    numCheck: first exec x from initialTable where i=(25+targetStep);
    targetNumbers: exec x from initialTable where i within (targetStep;24+targetStep);
    targetNumbersDiff: numCheck-targetNumbers;
    $[0<count targetNumbersDiff inter targetNumbers;isValid: 1b;isValid: 0b];
    :([] enlist targetStep;isValid)
    };

res: raze checkOneNumber[initialTable;] each numSteps;
weakness: first exec x from initialTable where i=(25+(first exec targetStep from res where not isValid)); // 258585477

// the second part
numSteps: til (count initialTable);

checkOneStep:{[initialTable;targetStep;weakness]
    show targetStep;
    targetTable: select from initialTable where i>=targetStep;
    targetTable: update sumCol: sums x from targetTable;
    $[count (select from targetTable where sumCol=weakness);isValid: 1b;isValid: 0b];
    :([] enlist targetStep;isValid)
    };

res: raze checkOneStep[initialTable;;weakness] each numSteps;
targetStep: exec min targetStep from res where isValid;
show targetStep;
targetTable: select from initialTable where i>=targetStep;
targetTable: update sumCol: sums x from targetTable;
targetTable: select from targetTable where sumCol<=weakness;
(min targetTable[`x])+(max targetTable[`x]) // 41384461 too high, 35321204 too low

