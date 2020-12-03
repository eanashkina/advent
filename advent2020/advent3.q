initialTable: ([] read0 `:D:/Coding/advent/advent2020/input3_1.txt);

rowLength: count first exec x from initialTable where i=0;
countRight: 3;
countDown: 1;

checkSlope:{[slope;rowLength]
    countTrees: 0;
    rowCount: 0;
    columnCount: 0;
    countRight: slope[`countRight];
    countDown: slope[`countDown];
    while[rowCount<count initialTable;
        symbolSelected: `$(first exec x from initialTable where i=rowCount)[columnCount];
        if[symbolSelected=`$"#";countTrees: countTrees+1];
        rowCount: rowCount+countDown;
        columnCount: columnCount+countRight;
        if[columnCount>=rowLength;columnCount: columnCount-rowLength];
        ];
    :([] enlist countTrees)
    };

slope: ([] countRight: 1 3 5 7 1; countDown: 1 1 1 1 2);
res: raze checkSlope[;rowLength] each slope;

// I forgot how to multiply all values in columns!

resList: exec countTrees from res;

resList[0]*resList[1]*resList[2]*resList[3]*resList[4] //3154761400