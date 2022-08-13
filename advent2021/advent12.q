system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input12_0.txt);
initialTable: update ("-" vs) each x from initialTable;
initialTable: select begin: `$x[;0], end: `$x[;1] from initialTable;
targetStep: `start;

findNextSteps:{[targetStep;initialTable]
    //    targetStep: `A;
    nextSteps: raze exec begin, end from initialTable where (begin=targetStep) or (end=targetStep);
    nextSteps: nextSteps where not nextSteps in (targetStep,`start);
    crossed: targetStep cross nextSteps;
    :([] allSteps: crossed;prevStep: targetStep;nextSteps)
    };

crossed: findNextSteps[targetStep;initialTable];

//crossedLine: crossed[1];
findNextStepsCrossed:{[initialTable;crossedLine]
    //    targetStep: `A;
    targetStep: crossedLine[`nextSteps];
    if[targetStep=`end;:([] allSteps: enlist crossedLine[`allSteps]; prevStep: targetStep; nextSteps: `)];
    nextSteps: raze exec begin, end from select from initialTable where (begin=targetStep) or (end=targetStep);
    nextSteps: nextSteps where not nextSteps in (targetStep,`start);
    $[`end in nextSteps; isEnd: 1b; isEnd: 0b];

    nextStepsWithoutEnd: nextSteps except `end;
    checkIfCapital:{[targetNextStep]
        // targetNextStep: `kj;
        :all string[targetNextStep] in .Q.A
        };
    ifCapital: checkIfCapital each nextStepsWithoutEnd;

    smallLetters: nextStepsWithoutEnd where not ifCapital;
    largeLetters: `$string nextStepsWithoutEnd where ifCapital;
    nextSmallLetters: smallLetters except crossedLine[`allSteps];

    nextSteps: nextSmallLetters,largeLetters;
    if[isEnd;nextSteps: nextSteps,`end];

    // crossedTableSmall: targetStep cross nextSteps;

    $[0<count nextSteps;
        crossedLines: raze each {(x,y)}'[enlist crossedLine[`allSteps];] each nextSteps;
        [
            crossedLines: enlist crossedLine[`allSteps];
            nextSteps: `
            ]
        ];
    :([] allSteps: crossedLines;prevStep: targetStep;nextSteps)
    };

// TODO: wrap in loop
crossed: raze findNextStepsCrossed[initialTable;] each crossed;
crossed
select from (update lastStep: last each allSteps from crossed) where lastStep=`end

// Part 2
system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input12_1.txt);
initialTable: update ("-" vs) each x from initialTable;
initialTable: select begin: `$x[;0], end: `$x[;1] from initialTable;
targetStep: `start;

crossed: findNextSteps[targetStep;initialTable];
crossed: update smallCaveTwice: ` from crossed;


findNextStepsCrossedSecondVisit:{[initialTable;crossedLine]
    // crossedLine: crossed[17];
    show crossedLine;
    targetStep: crossedLine[`nextSteps];
    if[targetStep=`end;:([] allSteps: enlist crossedLine[`allSteps]; prevStep: targetStep; nextSteps: `end;smallCaveTwice: `)];
    nextSteps: raze exec begin, end from select from initialTable where (begin=targetStep) or (end=targetStep);
    nextSteps: nextSteps where not nextSteps in (targetStep,`start);
    $[`end in nextSteps; isEnd: 1b; isEnd: 0b];

    nextStepsWithoutEnd: nextSteps except `end;
    checkIfCapital:{[targetNextStep]
        // targetNextStep: `kj;
        :all string[targetNextStep] in .Q.A
        };
    ifCapital: checkIfCapital each nextStepsWithoutEnd;

    smallLetters: nextStepsWithoutEnd where not ifCapital;
    largeLetters: `$string nextStepsWithoutEnd where ifCapital;
    doubleLetter: `;
    doubleLetterPrev: crossedLine[`smallCaveTwice];

    $[null doubleLetterPrev;
        [
            show "Can visit a cave twice";
            ifCapitalInAll: checkIfCapital each crossedLine[`allSteps];
            smallInAll: distinct crossedLine[`allSteps] where not ifCapitalInAll;
            allLetters: count each group smallLetters,smallInAll;
            show allLetters;
            doubleLetter: where allLetters=2;
            show doubleLetter;
            if[0=count doubleLetter; doubleLetter: `];
            $[all not null doubleLetter;
                nextSmallLetters: doubleLetter, smallLetters except crossedLine[`allSteps];
                nextSmallLetters: smallLetters except crossedLine[`allSteps]
                ];
            ];
        nextSmallLetters: smallLetters except crossedLine[`allSteps]
        ];

    nextSteps: nextSmallLetters,largeLetters;
    if[isEnd; nextSteps: nextSteps,`end];

    // crossedTableSmall: targetStep cross nextSteps;

    $[0<count nextSteps;
        crossedLines: raze each {(x,y)}'[enlist crossedLine[`allSteps];] each nextSteps;
        [
            crossedLines: enlist crossedLine[`allSteps];
            nextSteps: `
            ]
        ];

    if[(null doubleLetterPrev) and (all null doubleLetter); :([] allSteps: crossedLines;prevStep: targetStep;nextSteps: nextSteps;smallCaveTwice: `)];

    $[(not null doubleLetterPrev) and (all null doubleLetter);
        res:([] allSteps: crossedLines;prevStep: targetStep;nextSteps: nextSteps;smallCaveTwice: doubleLetterPrev);
        [
            $[1=count doubleLetter; // what if not null doubleLetterPrev?
                [
                    res: ([] allSteps: crossedLines;prevStep: targetStep;nextSteps: nextSteps;smallCaveTwice: first doubleLetter);
                    res: update smallCaveTwice: ` from res where not (last each allSteps)=smallCaveTwice;
                    res: update countSteps: {count each group x}'[allSteps] from res;
                    res: update caveTwice: {where x=2}'[countSteps] from res;
                    checkIfSmallAny:{[targetNextStep]
                        // targetNextStep: `A;
                        show targetNextStep;
                        res1: `$string[targetNextStep] where string[targetNextStep] in .Q.a;
                        :res1
                        };
                    // res: update isSmallCaveTwice: {checkIfSmallAny each x} each caveTwice from res;
                    // update raze each isSmallCaveTwice from res
                    res: update isCapital: checkIfCapital each smallCaveTwice from res;
                    res: update smallCaveTwice: ` from res where isCapital;
                    res: delete isCapital, countSteps, caveTwice from res
                    ];
                [
                    res: ([] allSteps: crossedLines;prevStep: targetStep;nextSteps: nextSteps;smallCaveTwice: `);
                    res: update countSteps: {count each group x}'[allSteps] from res;
                    res: update caveTwice: {where x=2}'[countSteps] from res;
                    // res: update caveTwice: enlist each ` from res where 0=count each caveTwice;
                    checkIfSmallAny:{[targetNextStep]
                        // targetNextStep: `A;
                        show targetNextStep;
                        res1: `$string[targetNextStep] where string[targetNextStep] in .Q.a;
                        :res1
                        };
                    // res: update isSmallCaveTwice: {checkIfSmallAny each x} each caveTwice from res;
                    // update raze each isSmallCaveTwice from res
                    res: update isCapital: {checkIfSmallAny each x} each caveTwice from res;
                    res: update smallCaveTwice: {x except `} each isCapital from res;
                    res: update first each smallCaveTwice from res;
                    res: delete isCapital, countSteps, caveTwice from res;
                    res: update countTest: count each smallCaveTwice from res;
                    res: update smallCaveTwice: ` from res where countTest=0;
                    res: delete countTest from res;
                    ]
                ];
            ]
        ];
    :res
    };

// TODO: add loop
crossed: raze findNextStepsCrossedSecondVisit[initialTable;] each crossed;
crossed

//select from (update isEnd: (`end in) each allSteps from crossed) where isEnd
select from (update lastStep: last each allSteps from crossed) where lastStep in `end

start,A,b,A,c,A,b,A,end
start,A,b,A,c,A,b,end
start,A,c,A,b,A,b,A,end
start,A,c,A,b,A,b,end
start,b,A,c,A,b,A,end
start,b,A,c,A,b,end
