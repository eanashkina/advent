// Advent 1
initialTable: "F"$([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input1_2.txt);
initialTable: update isNull: null x from initialTable;
initialTable: update groupNum: sums isNull from initialTable;
sum 3#exec x from `x xdesc select sum x by groupNum from initialTable

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
