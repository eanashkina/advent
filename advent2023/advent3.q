initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input3_2.txt);
lenLine: exec count first x from initialTable;
initialTable: update parsed: ("." vs) each x from initialTable;
symbols: raze exec x from initialTable;
symbols: symbols where not symbols in .Q.n;
symbols: symbols where not symbols=".";
initialTable: update positionSymbol: {where x in symbols} each x from initialTable;
initialTable: update positionNumber: {where x in .Q.n} each x from initialTable;

initialList: raze read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input3_2.txt;
numbers: initialList where not initialList in symbols;
numbers: "F"$"." vs numbers;
numbers: numbers where not null numbers;


symPositions: where initialList in symbols;
numPositions: where initialList in .Q.n;
additionalSymPositions: asc (symPositions-(lenLine-1)),(symPositions-lenLine),(symPositions-(lenLine+1)),(symPositions-1),
    symPositions,(symPositions+1),(symPositions+(lenLine-1)),(symPositions+lenLine),(symPositions+(lenLine+1));
numsWithNeighbours: numPositions where numPositions in additionalSymPositions;
extraNums: numPositions where numPositions in ((numsWithNeighbours-1),(numsWithNeighbours+1));
extraNums2: numPositions where numPositions in ((extraNums-1),(extraNums+1));
numsListAll: asc distinct numsWithNeighbours,extraNums,extraNums2;
//initialList[(numPositions except numsListAll)]
select sum num from update "F"$num from select num by flag from update sums flag from 0^update flag: 1
    from ([] num: raze string initialList[numsListAll]; pos: numsListAll) where (not pos=(prev pos)+1)

507214f

// Part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input3_2.txt);
lenLine: exec count first x from initialTable;
initialTable: update flag: {any x in "*"} each x from initialTable;

initialList: raze read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input3_2.txt;
numbers: initialList where not initialList in symbols;
numbers: "F"$"." vs numbers;
numbers: numbers where not null numbers;


symPositions: ([] x: where initialList in "*");
numPositions: where initialList in .Q.n;
additionalSymPositions: update xAdd: {asc ((x-(lenLine-1)),(x-lenLine),(x-(lenLine+1)),(x-1),
    x,(x+1),(x+(lenLine-1)),(x+lenLine),(x+(lenLine+1)))} each x from symPositions;
additionalSymPositions: update numsWithNeighbours: {numPositions where numPositions in x} each xAdd from additionalSymPositions;
additionalSymPositions: update extraNums: {numPositions where numPositions in ((x-1),(x+1))} each numsWithNeighbours from additionalSymPositions;
additionalSymPositions: update extraNums2: {numPositions where numPositions in ((x-1),(x+1))} each extraNums from additionalSymPositions;
additionalSymPositions: update numsListAll: {asc distinct x,y,z}'[numsWithNeighbours;extraNums;extraNums2] from additionalSymPositions;
flaggedTable: update sums flag from 0^update flag: 1 from (ungroup select x, numsListAll from additionalSymPositions) where (not numsListAll=(prev numsListAll)+1);
flaggedTable: update numValue: {first string initialList[x]} each numsListAll from flaggedTable;
selectedPos: exec distinct x
    from (select count distinct flag by x from flaggedTable)
    where flag=2;
exec sum numValue from select prd numValue by x from select "F"$numValue by x, flag from select from flaggedTable where x in selectedPos