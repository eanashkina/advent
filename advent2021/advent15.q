system "c 300 300";
initialTable: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input15_0.txt;
initialTable: raze initialTable;
targetDiag: 3;
coord: (10*(til targetDiag)) + reverse til targetDiag;

initialTable[coord]
targetDiag: targetDiag+1;



