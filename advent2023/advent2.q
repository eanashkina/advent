initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input2_2.txt);
initialTable: select parsed: (": " vs) each x from initialTable;
initialTable: select game: parsed[;0], line: parsed[;1] from initialTable;
initialTable: select `$game, lineParsed: `$("; " vs) each line from initialTable;
initialTableUngrouped: {@[x where count each x y;y;:;raze x y]}/[initialTable;`game`lineParsed]; // custom ungroup
initialTableUngrouped: update string lineParsed from initialTableUngrouped;
initialTableUngrouped: update setNum: i from update setCubes: `$(", " vs) each lineParsed from initialTableUngrouped;
initialTableUngroupedUngrouped: {@[x where count each x y;y;:;raze x y]}/[initialTableUngrouped;`setNum`setCubes];
initialTableUngroupedUngrouped: update parsed: (" " vs) each setCubes from update string setCubes from initialTableUngroupedUngrouped;
initialTableUngroupedUngrouped: update numberOfCubes: "F"$parsed[;0], colour: `$parsed[;1] from initialTableUngroupedUngrouped;

// Part 1
wrongGames: exec distinct game from initialTableUngroupedUngrouped where ((numberOfCubes>12) and (colour=`red)) or ((numberOfCubes>13) and (colour=`green)) or ((numberOfCubes>14) and (colour=`blue));
sum "F"$ssr[;"Game ";""] each string exec distinct game from delete from initialTableUngroupedUngrouped where game in wrongGames

// Part 2
// prd - cumulative multiplication
sum raze exec prd numberOfCubes by game from select max numberOfCubes by game, colour from initialTableUngroupedUngrouped
