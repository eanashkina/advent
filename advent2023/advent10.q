initialTable: (read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input10_2.txt);

startRow: first where initialTable like "*S*";
startColumn: first where (string initialTable[startRow]) like "*S*";


//x: startRow;
//y: startColumn;

posTable: ([] num: enlist (startRow;startColumn); symbol: `S; step: 0);
checkNeighbours:{[x;y;prevStep;initialTable]
    show x,y;
    currentSym: `$initialTable[x][y];
    topN: `$initialTable[(x-1)|0][y];
    downN: `$initialTable[(x+1)&(neg[1]+count initialTable)][y];
    rightN: `$initialTable[x][(y+1)&(neg[1]+count first initialTable)];
    leftN: `$initialTable[x][(y-1)|0];
    topNConnection: topN in `$string("|";"7";"F");
    downNConnection: downN in `$string("|";"L";"J");
    rightNConnection: rightN in `$string("-";"7";"J");
    leftNConnection: leftN in `$string("-";"L";"F");
    if[currentSym=`$"|";rightNConnection:leftNConnection:0b];
    if[currentSym=`$"7";rightNConnection:topNConnection:0b];
    if[currentSym=`$"F";topNConnection:leftNConnection:0b];
    if[currentSym=`$"-";topNConnection:downNConnection:0b];
    if[currentSym=`$"L";downNConnection:leftNConnection:0b];
    if[currentSym=`$"J";downNConnection:rightNConnection:0b];

    tab: ([] pos: topNConnection,downNConnection,rightNConnection,leftNConnection;
        num: ((((x-1)|0);y);
            (((x+1)&(neg[1]+count initialTable));y);
            (x;(y+1)&(neg[1]+count first initialTable));
            (x;(y-1)|0));
        symbol: topN,downN,rightN,leftN
            );
    :tab
    };

processOnePos:{[posTable;initialTable]
    prevStep: last posTable`step;
//    prevStep: 258
    show prevStep;
    posTablePrevStep: select from posTable where step=prevStep;
    numPrevStep: exec num from posTable where step<=prevStep;
    x: first last posTablePrevStep`num;
    y: last last posTablePrevStep`num;
    tab: checkNeighbours[x;y;prevStep;initialTable];
    resLast: update step: 1+prevStep from delete pos from select from tab where pos;
    resLast: select from resLast where not num in numPrevStep;

    x: first first posTablePrevStep`num;
    y: last first posTablePrevStep`num;
    tab: checkNeighbours[x;y;prevStep;initialTable];
    resFirst: update step: 1+prevStep from delete pos from select from tab where pos;
    resFirst: select from resFirst where not num in numPrevStep;
    :posTable,distinct(resFirst,resLast)
    };


posTable: processOnePos[posTable;initialTable];
prevPosTable: ();

while[not posTable~prevPosTable;
    prevPosTable: posTable;
    posTable: processOnePos[posTable;initialTable];
    ];

//exec max step from posTable //6690
// Part 2

positions: update isPos: 1 from select x: first each num, y: last each num from posTable;
rack: ([] x: til exec max x from positions) cross ([] y: til exec max y from positions);
pivot:{[t]
    u: `$string asc distinct last f:flip key t;
    pf:{x#(`$string y)!z};
    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
    p
    };

//pivot select first isPos by x, y from 0^rack lj `x`y xkey positions
//`:C:/Users/anash/MyPC/Coding/advent/advent2023/table2.csv 0: csv 0: pivot select first isPos by x, y from 0^rack lj `x`y xkey positions

//88 - black bold
//57 - grey bold
//96 - blue bold
//449 - black normal
//69 - last
//
//88 + 57+96+449+69 // 759j // too high
//// 758 too high
//88+57+96
//341+69+348
//// 650 is too high - some boundary cells should have been possible to reach from outside, but which ones?

//delete step from `step xasc update step*neg[1] from (select x: first each num, y: last each num, step from posTable) where step=prev step

//`step xasc update step*neg[1] from (`step`x xasc select x: first each num, y: last each num, step from posTable) where step<>prev step

//delete step from `step xasc 100#update step*neg[1] from (`step`x xasc select x: first each num, y: last each num, step from posTable) where (i mod 2)=0
`:C:/Users/anash/MyPC/Coding/advent/advent2023/tablePos.csv 0: csv 0: `step xasc update step*neg[1] from (select x: first each num, y: last each num, step from posTable) where (i mod 2)=0

377 incorrect

