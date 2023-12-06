initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input6_1.txt);
initialTable: update ("J"$" " vs) each x from initialTable;
initialTable: update {x where not null x}each x from initialTable;
lists: exec x from initialTable;
times: flip lists;
table: update time: x[;0], distance: x[;1] from ([] x: times);
table: update pressTime: {til 1+x} each time from table;
table: update moveTime: time-pressTime from table;
prd exec {count x where x>y}'[res;distance] from select res: {x*y}'[pressTime;moveTime], distance from table
// 5133600

// Part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input6_2.txt);
initialTable: update ssr[;" ";""] each x from initialTable;
initialTable: update ("J"$last ":" vs) each x from initialTable;
time: exec first x from initialTable;
distance: exec last x from initialTable;
pressTime: til 1+time;
moveTime: time-pressTime;
res: pressTime*moveTime;
count res where res>distance
// 40651271