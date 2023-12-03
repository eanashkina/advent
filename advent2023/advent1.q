// Advent 1
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input1_2.txt);
initialTable: update numbers: {"F"$string x where x in "0123456789"} each x from initialTable;
exec sum numbers1 from "F"$update {x,y}'[numbers;numbers1] from string select first each numbers, last each numbers from initialTable

initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input1_3.txt);
initialTable: update whereOne: {"F"$raze raze string ss[x;"one"]} each x from initialTable;
update count each whereOne from initialTable
exec min whereOne from initialTable where 0<count each whereOne
initialTable: update whereTwo: {ss[x;"two"]} each x from initialTable;
initialTable: update whereThree: {ss[x;"three"]} each x from initialTable;
initialTable: update whereFour: {ss[x;"four"]} each x from initialTable;
initialTable: update whereFive: {ss[x;"five"]} each x from initialTable;
initialTable: update whereSix: {ss[x;"six"]} each x from initialTable;
initialTable: update whereSeven: {ss[x;"seven"]} each x from initialTable;
initialTable: update whereEight: {ss[x;"eight"]} each x from initialTable;
initialTable: update whereNine: {ss[x;"nine"]} each x from initialTable;




initialTable: update x1: ssr[;"one";"1"] each x from initialTable;
initialTable: update x2: ssr[;"two";"2"] each x from initialTable;
initialTable: update x3: ssr[;"three";"3"] each x from initialTable;
initialTable: update x4: ssr[;"four";"4"] each x from initialTable;
initialTable: update x5: ssr[;"five";"5"] each x from initialTable;
initialTable: update x6: ssr[;"six";"6"] each x from initialTable;
initialTable: update x7: ssr[;"seven";"7"] each x from initialTable;
initialTable: update x8: ssr[;"eight";"8"] each x from initialTable;
initialTable: update x9: ssr[;"nine";"9"] each x from initialTable;

initialTable: update positions1: {where x in "0123456789"} each x1 from initialTable;
initialTable: update positions2: {where x in "0123456789"} each x2 from initialTable;
initialTable: update positions3: {where x in "0123456789"} each x3 from initialTable;
initialTable: update positions4: {where x in "0123456789"} each x4 from initialTable;
initialTable: update positions5: {where x in "0123456789"} each x5 from initialTable;
initialTable: update positions6: {where x in "0123456789"} each x6 from initialTable;
initialTable: update positions7: {where x in "0123456789"} each x7 from initialTable;
initialTable: update positions8: {where x in "0123456789"} each x8 from initialTable;
initialTable: update positions9: {where x in "0123456789"} each x9 from initialTable;
initialTable: update minPos: {[a;b;c;d;e;f;g;h] min raze (a,b,c,d,e,f,g,h)}'[positions1;positions2;positions3;positions4;positions5;positions6;positions7;positions8],
    maxPos: {[a;b;c;d;e;f;g;h] max raze (a,b,c,d,e,f,g,h)}'[positions1;positions2;positions3;positions4;positions5;positions6;positions7;positions8] from initialTable;
initialTable: update minPos: {[a;b] min raze (a,b)}'[positions9;minPos], maxPos: {[a;b] max raze (a,b)}'[positions9;maxPos] from initialTable;

minList: raze each select {x[y]}'[x1;minPos], {x[y]}'[x2;minPos], {x[y]}'[x3;minPos], {x[y]}'[x4;minPos], {x[y]}'[x5;minPos], {x[y]}'[x6;minPos], {x[y]}'[x7;minPos], {x[y]}'[x8;minPos],{x[y]}'[x9;minPos] from initialTable;
minimumTable: select minimum: {"F"$distinct x where x in "0123456789"} each x from ([] x: minList);
maxList: raze each select {x[y]}'[x1;maxPos], {x[y]}'[x2;maxPos], {x[y]}'[x3;maxPos], {x[y]}'[x4;maxPos], {x[y]}'[x5;maxPos], {x[y]}'[x6;maxPos], {x[y]}'[x7;maxPos], {x[y]}'[x8;maxPos],{x[y]}'[x9;maxPos] from initialTable;
maximumTable: update maximum: {"F"$distinct x where x in "0123456789"} each x from ([] x: maxList);
maximumTable: update maximum: 4f from maximumTable where i=224;
maximumTable: update maximum: 4f from maximumTable where i=264;
maximumTable: update maximum: 4f from maximumTable where i=607;
maximumTable: update maximum: 7f from maximumTable where i=938;

select from initialTable where i in (92 224 264 607 938 876)
select from( minimumTable ^ maximumTable) where i in (224 264 607 938)
//select i, x, maximum from maximumTable where maximum>9
exec sum maximum from update i from "F"$select {string[x],string[y]}'[minimum;maximum] from minimumTable ^ maximumTable

// 54745 too high
// 53195 too low
// 53193 too low

initialTable: update numbers: {"F"$string x where x in "0123456789"} each x from initialTable;
exec sum numbers1 from "F"$update {x,y}'[numbers;numbers1] from string select first each numbers, last each numbers from initialTable




// Advent 2
system "c 300 300";

initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input2_2.txt);
//A for Rock, B for Paper, and C for Scissors
//X for Rock, Y for Paper, and Z for Scissors
//Rock defeats Scissors, Scissors defeats Paper, and Paper defeats Rock
//The score for a single round is the score for the shape you selected (1 for Rock, 2 for Paper, and 3 for Scissors) plus
//the score for the outcome of the round (0 if you lost, 3 if the round was a draw, and 6 if you won)
initialTable: update parsed: (" " vs) each x from initialTable;
initialTable: update player1: `$parsed[;0], player2:`$parsed[;1] from initialTable;
initialTable: update res: 6j from initialTable where ((player1=`C) and (player2=`X)) or ((player1=`B) and (player2=`Z)) or ((player1=`A) and (player2=`Y));
initialTable: update res: 3j from initialTable where ((player1=`C) and (player2=`Z)) or ((player1=`B) and (player2=`Y)) or ((player1=`A) and (player2=`X));
initialTable: update 0j^res from initialTable;
initialTable: update shape: ?[player2=`X;1j;?[player2=`Y;2j;3j]] from initialTable;

sum exec sum res, sum shape from initialTable

initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input2_2.txt);
initialTable: update parsed: (" " vs) each x from initialTable;
initialTable: update player1: `$parsed[;0], resSym:`$parsed[;1] from initialTable;
initialTable: update resValue: ?[resSym=`X;0j;?[resSym=`Y;3j;6j]] from initialTable;
initialTable: update res: 1j from initialTable where ((player1=`B) and (resSym=`X)) or ((player1=`C) and (resSym=`Z)) or ((player1=`A) and (resSym=`Y));
initialTable: update res: 2j from initialTable where ((player1=`C) and (resSym=`X)) or ((player1=`A) and (resSym=`Z)) or ((player1=`B) and (resSym=`Y));
initialTable: update res: 3j from initialTable where ((player1=`A) and (resSym=`X)) or ((player1=`B) and (resSym=`Z)) or ((player1=`C) and (resSym=`Y));
sum exec sum res, sum resValue from initialTable


// Advent 3
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input3_2.txt);
initialTable: update countLine: count each x from initialTable;
initialTable: update halfCount: "j"$countLine%2 from initialTable;
initialTable: update halfs: {x cut y}'[halfCount;x] from initialTable;
initialTable: update firstHalf: halfs[;0] from initialTable;
initialTable: update secondHalf: halfs[;1] from initialTable;
initialTable: update similar: {distinct x inter y}'[firstHalf;secondHalf] from initialTable;
similarLetters: exec first each similar from initialTable;

mapping: ([] letters: .Q.a,.Q.A; numbers: 1+til 52);
exec sum numbers from ([] letters: similarLetters; test: 1b) lj `letters xkey mapping

initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input3_2.txt);
initialTable: update num: 1b from initialTable where (i mod 3)=0;
initialTable: update rucksackNum: sums num from initialTable;

nums: exec distinct rucksackNum from initialTable;

checkGroup:{[targetNum;initialTable]
    res: count each group raze exec distinct each x from initialTable where rucksackNum=targetNum;
    :([] groupNum: enlist targetNum; letters: first where res=3)
    };

finalRes: raze checkGroup[;initialTable] each nums;
exec sum numbers from finalRes lj `letters xkey mapping

// Advent 4
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input4_2.txt);
initialTable: update parsed: ("," vs) each x from initialTable;
initialTable: update group1: parsed[;0], group2: parsed[;1] from initialTable;
initialTable: update ("-" vs) each group1 from initialTable;
initialTable: update ("-" vs) each group2 from initialTable;
initialTable: update start1: group1[;0], end1: group1[;1], start2: group2[;0], end2: group2[;1] from initialTable;

initialTable: update start1: {"J"$x} each start1 from initialTable;
initialTable: update end1: {"J"$x} each end1 from initialTable;
initialTable: update start2: {"J"$x} each start2 from initialTable;
initialTable: update end2: {"J"$x} each end2 from initialTable;

initialTable: update list1: {x+til (1+y-x)}'[start1;end1], list2: {x+til (1+y-x)}'[start2;end2] from initialTable;
initialTable: update isIncluded1: {all x in y}'[list1;list2] from initialTable; // part1
initialTable: update isIncluded2: {all x in y}'[list2;list1] from initialTable;
exec count i from select isIncluded1, isIncluded2 from initialTable where (isIncluded1>0) or (isIncluded2>0)

initialTable: update isOverlap: {any x in y}'[list1;list2] from initialTable;
exec count i from initialTable where isOverlap


// Advent 5
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input5_2.txt);
// TODO: this num is different for my input
crates: 9#initialTable;
initialTable: 10_initialTable;

stackNum: count ssr[exec last x from crates;" ";""];
//1+ til stackNum
crates: -1_crates;

//groupsTable: (1+ til stackNum)!(`N`Z;`D`C`M;`P);
groupsTable: (1+ til stackNum)!(`Z`P`B`Q`M`D`N;`V`H`D`M`Q`Z`L`C;`G`Z`F`V`D`R`H`Q;`N`F`D`G`H;`Q`F`N;`T`B`F`Z`V`Q`D;`H`S`V`D`Z`T`M`Q;`Q`N`P`F`G`M;`M`R`W`B);

targetLine: initialTable[0];

// part 1
moveOneLine:{[groupsTable;targetLine]
    show groupsTable;
    show targetLine;
    targetLine: exec x from targetLine;
    line: " " vs targetLine;
    lineFirst: "J"$line[1];
    lineSecond: "J"$line[3];
    lineThird: "J"$line[5];
    while[lineFirst>0;
        show lineFirst;
        moveCrate: 1#groupsTable[lineSecond];
        groupsTable[lineSecond]: 1_groupsTable[lineSecond];
        groupsTable[lineThird]: moveCrate,groupsTable[lineThird];
        lineFirst: lineFirst-1;
        ];
    show groupsTable;
    show "";
    :groupsTable
    };

// part 2
moveOneLine:{[groupsTable;targetLine]
    show groupsTable;
    show targetLine;
    targetLine: exec x from targetLine;
    line: " " vs targetLine;
    lineFirst: "J"$line[1];
    lineSecond: "J"$line[3];
    lineThird: "J"$line[5];

    moveCrate: lineFirst#groupsTable[lineSecond];
    groupsTable[lineSecond]: lineFirst _groupsTable[lineSecond];
    groupsTable[lineThird]: moveCrate,groupsTable[lineThird];


    show groupsTable;
    show "";
    :groupsTable
    };
//show ""
groupsTable: groupsTable moveOneLine/ initialTable;

value first each groupsTable
