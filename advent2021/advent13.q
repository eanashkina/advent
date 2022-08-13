system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input13_1.txt);
foldLines: -12#initialTable;
initialTable: -13_initialTable;
//initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input13_0.txt);
//foldLines: -2#initialTable;
//initialTable: -3_initialTable;
initialTable: update ("," vs) each x from initialTable;
initialTable: update x: "I"$x[;0], y: "I"$x[;1] from initialTable;

// targetLine: first foldLines
foldOneLine:{[initialTable;targetLine]
    firstFold: `$"=" vs last " " vs exec x from targetLine;
    // secondFold: `$"=" vs last " " vs first exec x from foldLines where i=1;

    if[`y in firstFold;
        foldLine: "I"$string last firstFold;
        coordsToChange: select from initialTable where y>foldLine;
        coordsNotToChange: select from initialTable where y<foldLine;

        coordsToChange: update y: foldLine+(foldLine-y) from coordsToChange;
        initialTable: distinct coordsToChange,coordsNotToChange;

        ];

    if[`x in firstFold;
        foldLine: "I"$string last firstFold;
        coordsToChange: select from initialTable where x>foldLine;
        coordsNotToChange: select from initialTable where x<foldLine;

        coordsToChange: update x: foldLine+(foldLine-x) from coordsToChange;
        initialTable: distinct coordsToChange,coordsNotToChange;

        ];
    :initialTable
    };

//count newTab // 592

res: initialTable foldOneLine[;]/ foldLines;
`y`x xcols res
figure: ([] xCoord: til 1+exec max x from res) cross ([] til 1+exec max y from res);
// JGAJEFKU