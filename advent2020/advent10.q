system "c 300 300";
initialTable: "J"$([] read0 `:D:/Coding/advent/advent2020/input10_1.txt);
chargingOutlet: 0;
deviceAdapter: 3+exec max x from initialTable;

newTable: (`x xasc initialTable),(enlist `x)!(enlist deviceAdapter);
newTable: update difference: deltas x from newTable;

res: () xkey (select from (select count i by difference from newTable) where difference in (1 3));
res[`x][0]*res[`x][1] //2263

// the second part
numRows: til count newTable;

findPossiblePositions:{[targetRow;newTable]
    show targetRow;
    selectedTable: select from newTable where not i=targetRow;
    selectedTable: update difference: deltas x from selectedTable;
    $[exec max difference from selectedTable>3;isValid: 0b;isValid: 1b];
    newTable: update isValidCol: isValid from newTable where i=targetRow;
    :select from newTable where i=targetRow
    };

res: raze findPossiblePositions[;newTable] each numRows;
res: update isValidCol: 0b from res where i=max i;
// Enumerate groups
res: update groupNum: 1 from res where isValidCol=1;
res: update firstInGroup: isValidCol & not prev isValidCol from res;
res: update groupId: sums firstInGroup from res;

numOfGroups: exec distinct groupId from res;

resGrouped: select sum groupNum by groupId from res;
map: (1 2 3)!(2 4 7);

resGrouped: update keyValue: map each groupNum from resGrouped;

iNum: 0;
multRes: 1;
while[iNum<count resGrouped;
    multRes: multRes*(exec keyValue from resGrouped where i=iNum);
    iNum: iNum+1;
    ];
