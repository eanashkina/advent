system "c 300 300";

//tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input2_1.txt;
tableFromFile: "J"$ "," vs raze read0 `:D:/Coding/advent/advent2019/input5.txt;
// 5_1 works, proceed with 5_2
//tableFromFile: (1002,4,3,4,33);
//tableFromFile[1 2]: 12 2; // For task 2

system "l D:/Coding/advent/advent2019/intcode_comp.q";
res: runOneInstruction[1;tableFromFile];

input: ([] noun: til 100) cross ([] verb: til 100);
checkCombination:{[tableFromFile;inputRow]
    // Task 2.
    tableFromFile[1 2]: value inputRow;
    res: runOneInstruction[0;tableFromFile];
    if[res=19690720;
        :(100*inputRow[`noun])+inputRow[`verb];
        :()
        ];
    };

totalRes: raze checkCombination[tableFromFile;] each input;

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