system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input10_3.txt);
initialTable: update parsed: (" " vs) each x from initialTable;
initialTable: update cond: `$parsed[;0] from initialTable;
initialTable: update addition: "J"$parsed[;1] from initialTable;
initialTable: update cycleNum: ?[cond=`noop;1;2] from initialTable;
//initialTable: update addition: 1j from initialTable where i=0;

shortInitialTable: select cycleNum, addition, cond from initialTable;
shortInitialTable: ((`cycleNum`addition`cond)!(0;1;`)),shortInitialTable;

summed: update cycleNum: cycleNum+1 from select sums cycleNum, sums addition, cond from shortInitialTable;
res: update fills addition from
    ([] cycleNum: 1+ til exec max cycleNum from summed) lj `cycleNum xkey summed;
//exec sum res from update res: cycleNum*addition from select from res where cycleNum in (20+40*til 6)
// part 2

//res: 1_res;
//res: ([] cycleNum: 0 1; addition: 0 0; cond: ``),res;


res: update addition: 0j from res where i in (0 1);
res: update positionCRT: i from res;
res: update positionSprite: {(x-1),x,(x+1)} each addition from res;
res: update row: positionCRT div 40 from res;

res: update pixel: {x in ((z*40)+y)}'[positionCRT;positionSprite;row] from res;
string ([] 40 cut exec pixel from res)

RGZEHURK
1110001100111101111010010100101110010010b;
1001010010000101000010010100101001010100b;
1001010000001001110011110100101001011000b;
1110010110010001000010010100101110010100b;
1010010010100001000010010100101010010100b;
1001001110111101111010010011001001010010b