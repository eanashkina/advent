system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input11_1.txt);
rack: `numRow`numCol xcol ([] til count initialTable) cross ([] til count first value initialTable[0]);

checkOnePosition:{[targetElement;initialTable]
    show targetElement;
    rowPos: targetElement[`numRow];
    colPos: targetElement[`numCol];
    // check eight positions
    show (first exec x from initialTable where i=rowPos);
    targetSeat: (first exec x from initialTable where i=rowPos)[colPos];
    a1: (first exec x from initialTable where i=rowPos)[colPos-1];
    a2: (first exec x from initialTable where i=rowPos)[colPos+1];

    a3: (first exec x from initialTable where i=(rowPos-1))[colPos-1];
    a4: (first exec x from initialTable where i=(rowPos-1))[colPos];
    a5: (first exec x from initialTable where i=(rowPos-1))[colPos+1];

    a6: (first exec x from initialTable where i=(rowPos+1))[colPos-1];
    a7: (first exec x from initialTable where i=(rowPos+1))[colPos];
    a8: (first exec x from initialTable where i=(rowPos+1))[colPos+1];

    listOfSeats: ssr[(a1,a2,a3,a4,a5,a6,a7,a8);" ";""];

    if[targetSeat=".";isChange: 0b];
    if[targetSeat="L";isChange: ?[any listOfSeats in "#";0b;1b]];
    if[targetSeat="#";isChange: ?[4>(count listOfSeats where listOfSeats in "#");0b;1b]];
    :update isChangeCol: isChange from targetElement
    };

//res: checkOnePosition[;initialTable] each rack;
//elementsToUpdate: select from res where isChangeCol;
//numRows: exec  distinct numRow from res;

changeOnePosition:{[initialRow;position;toUpdate]
    targetElement: initialRow[position];
    $[position in toUpdate;
        [
            if[targetElement="L";newElement: "#"];
            if[targetElement="#";newElement: "L"];
            if[not (`$targetElement) in (`L,(`$"#"));show["Error"]]
            ];
        [
            newElement: targetElement
            ]
        ];
    :newElement
    };

changeOneRow:{[targetNumRow;elementsToUpdate;initialTable]
    show targetNumRow;
    toUpdate: exec numCol from elementsToUpdate where numRow=targetNumRow;
    initialRow: first exec x from initialTable where i=targetNumRow;
    newRow: changeOnePosition[initialRow;;toUpdate] each til count initialRow;
    :newRow
    };

//initialTable: `x xcol ([] changeOneRow[;elementsToUpdate;initialTable] each numRows);
iteration: 0;
elementsToUpdate: ();
while[(0<count elementsToUpdate) or (not iteration);
    res: checkOnePosition[;initialTable] each rack;
    elementsToUpdate: select from res where isChangeCol;
    numRows: exec distinct numRow from res;
    initialTable: `x xcol ([] changeOneRow[;elementsToUpdate;initialTable] each numRows);
    iteration: iteration+1;
    show iteration;
    show initialTable
    ];
// 5 minutes to run

countOccupiedSeats:{[targetElement;initialTable]
    show targetElement;
    rowPos: targetElement[`numRow];
    colPos: targetElement[`numCol];
    // check eight positions
    targetSeat: (first exec x from initialTable where i=rowPos)[colPos];

    if[targetSeat=".";isOccupied: 0b];
    if[targetSeat="#";isOccupied: 1b];
    if[targetSeat="L";isOccupied: 0b];
    :update isChangeCol: isOccupied from targetElement
    };

resFinal: countOccupiedSeats[;initialTable] each rack;
select sum isChangeCol from resFinal

// the second part
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input11_1.txt);
rack: `numRow`numCol xcol ([] til count initialTable) cross ([] til count first value initialTable[0]);

checkOnePosition:{[targetElement;initialTable]
    show targetElement;
    rowPos: targetElement[`numRow];
    colPos: targetElement[`numCol];
    // check eight positions
    show (first exec x from initialTable where i=rowPos);
    targetSeat: (first exec x from initialTable where i=rowPos)[colPos];
    a1: (first exec x from initialTable where i=rowPos)[colPos-1];
    if[0<count a1;
        if[(a1=".") and (not a1=" ");
            step1: 0;
            while[not ((a1="L") or (a1="#") or (a1=" "));
                step1: step1+1;
                a1: (first exec x from initialTable where i=rowPos)[colPos-(1+step1)];
                show a1;
                if[0=count a1;a1: " "];
                ];
            ];
        ];

    a2: (first exec x from initialTable where i=rowPos)[colPos+1];
    if[0<count a2;
        if[(a2=".") and (not a2=" ");
            step1: 0;
            while[not ((a2="L") or (a2="#") or (a2=" "));
                step1: step1+1;
                a2: (first exec x from initialTable where i=rowPos)[colPos+(1+step1)];
                show a2;
                if[0=count a2;a2: " "];
                ];
            ];
        ];

    a3: (first exec x from initialTable where i=(rowPos-1))[colPos-1];
    if[0<count a3;
        if[(a3=".") and (not a3=" ");
            step1: 0;
            while[not ((a3="L") or (a3="#") or (a3=" "));
                step1: step1+1;
                a3: (first exec x from initialTable where i=(rowPos-(1+step1)))[colPos-(1+step1)];
                show a3;
                if[0=count a3;a3: " "];
                ];
            ];
        ];

    a4: (first exec x from initialTable where i=(rowPos-1))[colPos];
    if[0<count a4;
        if[(a4=".") and (not a4=" ");
            step1: 0;
            while[not ((a4="L") or (a4="#") or (a4=" "));
                step1: step1+1;
                a4: (first exec x from initialTable where i=(rowPos-(1+step1)))[colPos];
                show a4;
                if[0=count a4;a4: " "];
                ];
            ];
        ];

    a5: (first exec x from initialTable where i=(rowPos-1))[colPos+1];
    if[0<count a5;
        if[(a5=".") and (not a5=" ");
            step1: 0;
            while[not ((a5="L") or (a5="#") or (a5=" "));
                step1: step1+1;
                a5: (first exec x from initialTable where i=(rowPos-(1+step1)))[colPos+(1+step1)];
                show a5;
                if[0=count a5;a5: " "];
                ];
            ];
        ];

    a6: (first exec x from initialTable where i=(rowPos+1))[colPos-1];
    if[0<count a6;
        if[(a6=".") and (not a6=" ");
            step1: 0;
            while[not ((a6="L") or (a6="#") or (a6=" "));
                step1: step1+1;
                a6: (first exec x from initialTable where i=(rowPos+(1+step1)))[colPos-(1+step1)];
                show a6;
                if[0=count a6;a6: " "];
                ];
            ];
        ];

    a7: (first exec x from initialTable where i=(rowPos+1))[colPos];
    if[0<count a7;
        if[(a7=".") and (not a7=" ");
            step1: 0;
            while[not ((a7="L") or (a7="#") or (a7=" "));
                step1: step1+1;
                a7: (first exec x from initialTable where i=(rowPos+(1+step1)))[colPos];
                show a7;
                if[0=count a7;a7: " "];
                ];
            ];
        ];

    a8: (first exec x from initialTable where i=(rowPos+1))[colPos+1];
    if[0<count a8;
        if[(a8=".") and (not a8=" ");
            step1: 0;
            while[not ((a8="L") or (a8="#") or (a8=" "));
                step1: step1+1;
                a8: (first exec x from initialTable where i=(rowPos+(1+step1)))[colPos+(1+step1)];
                show a8;
                if[0=count a8;a8: " "];
                ];
            ];
        ];

    listOfSeats: ssr[(a1,a2,a3,a4,a5,a6,a7,a8);" ";""];

    if[targetSeat=".";isChange: 0b];
    if[targetSeat="L";isChange: ?[any listOfSeats in "#";0b;1b]];
    if[targetSeat="#";isChange: ?[5>(count listOfSeats where listOfSeats in "#");0b;1b]];
    :update isChangeCol: isChange from targetElement
    };

//res: checkOnePosition[;initialTable] each rack;
//elementsToUpdate: select from res where isChangeCol;
//numRows: exec  distinct numRow from res;

changeOnePosition:{[initialRow;position;toUpdate]
    targetElement: initialRow[position];
    $[position in toUpdate;
        [
            if[targetElement="L";newElement: "#"];
            if[targetElement="#";newElement: "L"];
            if[not (`$targetElement) in (`L,(`$"#"));show["Error"]]
            ];
        [
            newElement: targetElement
            ]
        ];
    :newElement
    };

changeOneRow:{[targetNumRow;elementsToUpdate;initialTable]
    show targetNumRow;
    toUpdate: exec numCol from elementsToUpdate where numRow=targetNumRow;
    initialRow: first exec x from initialTable where i=targetNumRow;
    newRow: changeOnePosition[initialRow;;toUpdate] each til count initialRow;
    :newRow
    };

//initialTable: `x xcol ([] changeOneRow[;elementsToUpdate;initialTable] each numRows);
iteration: 0;
elementsToUpdate: ();
while[(0<count elementsToUpdate) or (not iteration);
    res: checkOnePosition[;initialTable] each rack;
    elementsToUpdate: select from res where isChangeCol;
    numRows: exec distinct numRow from res;
    initialTable: `x xcol ([] changeOneRow[;elementsToUpdate;initialTable] each numRows);
    iteration: iteration+1;
    show iteration;
    show initialTable
    ];

resFinal: countOccupiedSeats[;initialTable] each rack;
select sum isChangeCol from resFinal
