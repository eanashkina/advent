initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input13_1.txt);
initialTable: update countLine: count each x from initialTable;
initialTable: update change: 1 from initialTable where countLine=0;
initialTable: update sums change from initialTable;

groups: exec distinct change from initialTable;
targetGroup: 0;


considerOneGroup:{[initialTable;targetGroup]
    show targetGroup;
    lines: select x from initialTable where change=targetGroup, countLine>0;
    // Check vertical
    // first half
(select {x[til 4]} each x from lines) ^
(select y: {x[4+til 4]} each x from lines)
// second half
(select {x[(5-(9-5)) + til (9-5)]} each x from lines) ^
(select y: {reverse x[5+til (9-5)]} each x from lines)
    }:
