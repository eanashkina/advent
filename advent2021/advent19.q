system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input19_0.txt);
initialTable: update ssr[;" ---";""] each x from initialTable;
initialTable: update numCount: i from initialTable;

selectedTable: select numCount, parsed: ("scanner " vs) each x from initialTable where x like "*scan*";
selectedTable: update scanPos: first each parsed[;1] from selectedTable;
selectedTable: update isName: 1b from update (`$) each scanPos from selectedTable;

initialTable: update fills scanPos from initialTable lj `numCount xkey selectedTable;
initialTable: update isName: 1b from initialTable where (next isName);

initialTable: select from initialTable where not isName; // prepared table
initialTable: update parsed: ("," vs) each x from initialTable;
initialTable: update firstCoord: "J"$parsed[;0], secondCoord: "J"$parsed[;1] from initialTable;




