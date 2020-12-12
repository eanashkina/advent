system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input11_2.txt);
rack: `numRow`numCol xcol ([] til count initialTable) cross ([] til count first value initialTable[0]);
targetElement: first rack

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

res: checkOnePosition[;initialTable] each rack;

elementsToUpdate: select from res where isChangeCol;

rowToUpdate: select from elementsToUpdate where numRow=0;

numRows: exec  distinct numRow from elementsToUpdate;
targetNumRow: first numRows;
changeOneRow:{[targetNumRow;elementsToUpdate;initialTable]
    show numRow;
    toUpdate: exec numCol from elementsToUpdate where numRow=targetNumRow;
    initialRow: first exec x from initialTable where i=targetNumRow;

    // replace on each position - how to do it in one line?
    (string initialRow)[toUpdate]
     initialRow
    };