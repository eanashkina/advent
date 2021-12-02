system "c 300 300";

initialTableData: read0 `:C:/Users/Katerina/Documents/GitHub/advent/advent2020/inputDay17.txt;

initialTableData: ([] x: string (`$".#."),(`$"..#"),(`$"###"));

select x[;0] from update `$string each x from initialTableData

neighbours: ({x cross x cross x} -1 0 1);