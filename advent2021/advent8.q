system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input8_1.txt);
initialTable: update (" | " vs) each x from initialTable;
initialTable: update beforeNum: x[;0], afterNum: x[;1] from initialTable;
initialTable: update (" " vs) each afterNum from initialTable;

initialTable: update firstNum: afterNum[;0], secondNum: afterNum[;1], thirdNum: afterNum[;2], fourthNum: afterNum[;3]
    from initialTable;
countNums: count each group raze exec count each firstNum, count each secondNum, count each thirdNum,
    count each fourthNum from initialTable;
//
//// 1 - 2, 4 - 4, 7 - 3, 8 - 7
countNums[2]+countNums[4]+countNums[3]+countNums[7]

// part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input8_1.txt);
initialTable: update (" | " vs) each x from initialTable;
initialTable: update beforeNum: x[;0], afterNum: x[;1] from initialTable;
initialTable: update (" " vs) each afterNum from initialTable;

countNum: 1;
getNumOneLine:{[initialTable;countNum]
    before: ([] " " vs first exec beforeNum from initialTable where i=countNum);
    before: update countX: count each x from before;

    num1: `$asc first exec x from before where countX=2;
    num4: `$asc first exec x from before where countX=4;
    num7: `$asc first exec x from before where countX=3;
    num8: `$asc first exec x from before where countX=7;

    oldA: `$string[num7] except string[num1];

    numsWith5: exec x from before where countX=5; // 2, 3, 5
    numsWith6: exec x from before where countX=6; // 0, 6, 9

    countNumsWith6: count each group raze numsWith6; // 3 - a, b, f, g; 2 - c, d, e
    oldD: `$((key countNumsWith6) where 2=value countNumsWith6) inter (string[num4] except string[num1]);
    num0: `$asc first numsWith6 where not raze (string[oldD] in/: numsWith6);
    nums69: numsWith6 where raze (string[oldD] in/: numsWith6);
    num9: `$asc first nums69 where (all each string[num1] in/: nums69);
    num6: `$asc first nums69 where not (all each string[num1] in/: nums69);

    oldE: `$string[num8] except string[num9];
    oldC: `$string[num8] except string[num6];
    oldF: `$string[num1] except string oldC;
    oldB: `$string[num4] except raze string oldC,oldD,oldF;
    oldG: `$string[num0] except raze string oldA,oldB,oldC,oldE,oldF;

    num2: `$asc raze string oldA,oldC,oldD,oldE,oldG;
    num3: `$asc raze string oldA,oldC,oldD,oldF,oldG;
    num5: `$asc raze string oldA,oldB,oldD,oldF,oldG;

    after: ([] letters: `$asc each exec first afterNum from initialTable where i=countNum);

    mapping: ([] number: til 10; letters: num0, num1, num2, num3, num4, num5, num6, num7, num8, num9);

    :([] countNum: enlist countNum; num: "J"$raze exec string[number] from after lj `letters xkey mapping)
    };

exec sum num from raze getNumOneLine[initialTable;] each til count initialTable