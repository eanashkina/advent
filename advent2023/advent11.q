initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input11_1.txt);

initialTable2: update isGalaxy: {x like "*#*"} each x from initialTable;
initialTable2: update lineNum: i from initialTable2;
initialTable2: `lineNum xasc initialTable2,select from initialTable2 where not isGalaxy;

lengthLine: count exec x from first initialTable2;
targetNum: 0;

flipOneCol:{[initialTable;targetNum]
    :([] x: enlist exec {x[y]}'[x;y] from update y: targetNum from initialTable)
    };

initialTableTransposed: raze flipOneCol[select x from initialTable2;] each til lengthLine;
initialTableTransposed: update isGalaxy: {x like "*#*"} each x from initialTableTransposed;
initialTableTransposed: update lineNum: i from initialTableTransposed;
initialTableTransposed: `lineNum xasc initialTableTransposed,select from initialTableTransposed where not isGalaxy;

lengthLine: count exec x from first initialTableTransposed;
initialTableTransposedTransposed: raze flipOneCol[select x from initialTableTransposed;] each til lengthLine;
initialTableTransposedTransposed: update isGalaxy: {x like "*#*"} each x from initialTableTransposedTransposed;
initialTableTransposedTransposed: update rowNum: i from initialTableTransposedTransposed;

galaxies: update galNum: i from ungroup select rowNum, colNum:{where string[x] like "*#*"} each x
    from select from initialTableTransposedTransposed where isGalaxy;

comb:{[N;l]$[N=1;l;raze .z.s[N-1;l]{x,/:y where y>max x}\:l]};
galaxiesPairs: update galaxyOne: galaxyPair[;0], galaxyTwo: galaxyPair[;1] from ([] galaxyPair: comb[2;exec galNum from galaxies]);
galaxiesPairs: galaxiesPairs lj `galaxyOne xkey update galaxyOne: galNum, rowNum1: rowNum, colNum1: colNum from galaxies;
galaxiesPairs: galaxiesPairs lj `galaxyTwo xkey update galaxyTwo: galNum, rowNum2: rowNum, colNum2: colNum from galaxies;
galaxiesPairs: delete rowNum, colNum, galNum from galaxiesPairs;
galaxiesPairs: update colDist: abs[colNum1-colNum2], rowDist: abs[rowNum1-rowNum2] from galaxiesPairs;

galaxiesPairs: update dist: colDist+rowDist from galaxiesPairs;
exec sum dist from galaxiesPairs // 9177603

// Part 2
// Find positions of empty lines
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input11_2.txt);

initialTable2: update isGalaxy: {x like "*#*"} each x from initialTable;
initialTable2: update lineNum: i from initialTable2;
linesEmpty: exec lineNum from initialTable2 where not isGalaxy;

lengthLine: count exec x from first initialTable;
flipOneCol:{[initialTable;targetNum]
    :([] x: enlist exec {x[y]}'[x;y] from update y: targetNum from initialTable)
    };

initialTableTransposed: raze flipOneCol[select x from initialTable;] each til lengthLine;
initialTableTransposed: update isGalaxy: {x like "*#*"} each x from initialTableTransposed;
initialTableTransposed: update lineNum: i from initialTableTransposed;

colsEmpty: exec lineNum from initialTableTransposed where not isGalaxy;

initialTable2: update rowNum: i from initialTable2;
galaxies: update galNum: i from ungroup select rowNum, colNum:{where string[x] like "*#*"} each x
    from select from initialTable2 where isGalaxy;

addLinesTable: ([] rowNum: linesEmpty; addLines: 999999);
addLinesTable: update sums addLines from addLinesTable;
galaxies: delete addLines from update rowNum+addLines from 0^aj[`rowNum;galaxies;addLinesTable];

addColsTable: ([] colNum: colsEmpty; addLines: 999999);
addColsTable: update sums addLines from addColsTable;
galaxies: delete addLines from update colNum+addLines from 0^aj[`colNum;galaxies;addColsTable];

comb:{[N;l]$[N=1;l;raze .z.s[N-1;l]{x,/:y where y>max x}\:l]};
galaxiesPairs: update galaxyOne: galaxyPair[;0], galaxyTwo: galaxyPair[;1] from ([] galaxyPair: comb[2;exec galNum from galaxies]);
galaxiesPairs: galaxiesPairs lj `galaxyOne xkey update galaxyOne: galNum, rowNum1: rowNum, colNum1: colNum from galaxies;
galaxiesPairs: galaxiesPairs lj `galaxyTwo xkey update galaxyTwo: galNum, rowNum2: rowNum, colNum2: colNum from galaxies;
galaxiesPairs: delete rowNum, colNum, galNum from galaxiesPairs;
galaxiesPairs: update colDist: abs[colNum1-colNum2], rowDist: abs[rowNum1-rowNum2] from galaxiesPairs;

galaxiesPairs: update dist: colDist+rowDist from galaxiesPairs;
exec sum dist from galaxiesPairs // 632003913611