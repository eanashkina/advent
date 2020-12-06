initialTable: ([] read0 `:D:/Coding/advent/advent2020/input5_1.txt);
initialTable: update row: (7#) each x, column: (7_) each x from initialTable;

targetEntry: first initialTable;

findOneSeat:{[targetEntry]
    show targetEntry;
    targetRow: targetEntry[`row];
    targetColumn: targetEntry[`column];

    numRows: til 128;
    while[1<=count targetRow;
        targetLetter: `$first targetRow;
        targetRow: 1_targetRow;
        cutRows: ("j"$((count numRows)%2)) cut numRows;
        show targetLetter;
        $[targetLetter=`F;
            numRows: first cutRows;
            numRows: last cutRows
            ];
        ];

    finalRow: first numRows;
    show finalRow;

    numColumns: til 8;
    while[1<=count targetColumn;
        targetLetter: `$first targetColumn;
        targetColumn: 1_targetColumn;
        cutColumns: ("j"$((count numColumns)%2)) cut numColumns;
        show targetLetter;
        $[targetLetter=`L;
            numColumns: first cutColumns;
            numColumns: last cutColumns
            ];
        ];

    finalColumn: first numColumns;
    show finalColumn;
    :([] enlist finalRow;finalColumn)
    };

res: raze findOneSeat each initialTable;
res: update seatId: (finalRow*8)+finalColumn from res;
maxId: exec max seatId from res; // 901

first exec x from (update xDelta: deltas x from ([] (til (maxId+1)) except (exec seatId from res))) where not xDelta=1, not x=0 //661