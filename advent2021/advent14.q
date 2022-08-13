system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input14_1.txt);
template: exec first x from initialTable;
initialTable: 2_initialTable;

initialTable: select pair: x[;0], element: x[;1] from update (" -> " vs) each x from initialTable;
initialTable: update newElement1: pair[;0], newElement2: pair[;1] from initialTable;
//initialTable: update newElement: (newElement1,'element) from initialTable;
//initialTable: update newElement: (newElement,'newElement2) from initialTable;
initialTable: update newElementFirst: `$(newElement1,'element) from initialTable;
initialTable: update newElementSecond: `$(element,'newElement2) from initialTable;
initialTable: update `$pair from initialTable;
lengthOfLine: count template;

steps: 1*til (lengthOfLine-1);

targetStep: first steps;

processOneStep:{[template;initialTable;targetStep]
    targetPair: template[targetStep],template[targetStep+1];
    // show targetPair;
    // template: ssr[template;targetPair;exec first newElement from initialTable where pair like targetPair];
    res: exec first newElement from initialTable where pair like targetPair;
    if[not targetStep=0;
        res: 1_res
        ];
    // show res;
    //:template
    :res
    };


targetLine: 0;
//targetLine: targetLine+1;
processOneStepCount:{[newTable;sumTable;initialTable;targetLine]
    show "targetLine: ",string targetLine;
    targetPair: exec first code from sumTable where i=targetLine;
    // show targetPair;
    // show targetPair;
    // template: ssr[template;targetPair;exec first newElement from initialTable where pair like targetPair];
    res: raze exec newElementFirst, newElementSecond from initialTable where pair=targetPair;
    numEntries: first exec x from sumTable where code=targetPair;
    newTable: update x: x-numEntries from newTable where code=targetPair;
    newTable: select from newTable where not x=0;
    increaseTable: select from newTable where code in res;
    if[0=count increaseTable;
        newTable: newTable,([] code: res;x: numEntries);
        ];
    if[1=count increaseTable;
        // show increaseTable;
        newTable: update x: x+numEntries from newTable where code in res;
        addTable: ([] enlist code: first (res except exec code from newTable); x: numEntries);
        newTable: newTable, addTable;

        ];
    if[2=count increaseTable;
        newTable: update x: x+numEntries from newTable where code in res;
        ];


    // show newTable;
    //:template
    :newTable
    };

numSteps: 0;
//flip count each group ([] `$2 cut templateDoubled)

templateDoubled: raze string (`$string template) where 1,((-2+count template)#2),1;
sumTable: () xkey select count i by code from ([] code: `$2 cut templateDoubled);

//sumTable processOneStepCount[;initialTable;]/ til  count sumTable
newTable: sumTable;
//while[numSteps<10;
//    show numSteps;
//    lengthOfLine: count template;
//    steps: 1*til (lengthOfLine-1);
//    template: raze processOneStep[template;initialTable;] each steps;
//    numSteps: numSteps+1;
//    ];

numSteps: 0;
while[numSteps<40;
    show numSteps;
    finalTable: newTable processOneStepCount[;sumTable;initialTable;]/ til count sumTable;
    numSteps: numSteps+1;
    newTable: select from finalTable where x>0;
    sumTable: select from finalTable where x>0;
    outputRes: update x*0.5 from update x: (x+1) from (update (`$) each code from () xkey select sum x by code from ungroup update string code from sumTable) where code in `N`S;
    ];

resFinal: desc exec x from outputRes;
(first resFinal)-last resFinal
select sum x by code from ungroup update string code from sumTable

count each group template
4353-1011 // 3342
template: raze processOneStep[sumTable;template;initialTable;] each steps;


meta initialTable

NBBBCNCCNBBNBNBBCHBHHBCHB