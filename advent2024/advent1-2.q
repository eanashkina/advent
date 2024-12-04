// Advent 1
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input1_2.txt);
initialTable: select firstNum: "F"$first each x, lastNum: "F"$last each x from update (" " vs) each x from initialTable;
firstList: exec firstNum from initialTable;
lastList: exec lastNum from initialTable;

exec sum diff from update diff: abs[firstList-lastList] from ([] asc firstList; asc lastList)

// part 2

groupLast: group lastList;
exec sum x*countNum from ([] x: firstList) lj `x xkey ([] x: key groupLast; countNum: count each value groupLast)

// Advent 2

initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input2_2.txt);
initialTable: update parsed: "F"$(" " vs) each x from initialTable;
initialTable: update diff: {(1_deltas x)} each parsed from initialTable;
initialTable: update safe: {all x in (1 2 3f)} each diff from initialTable;
initialTable: update safe: {all x in neg[1 2 3f]} each diff from initialTable where safe=0;
countGood: count select from initialTable where safe;

// part 2
initialTableShort: delete from initialTable where safe;

targetLine: 1 3 2 4 5f;
checkOneLine:{[targetLine]
    nums: count targetLine;
    countNums: 0;
    isSafe: 0;
    while[(countNums<nums) and (not isSafe);
        show targetLine;
        targetLineTest: 1_deltas (countNums # targetLine),((countNums+1) _ targetLine);
        show targetLineTest;
        isSafe: (all targetLineTest in (1 2 3f)) or (all targetLineTest in neg[1 2 3f]);
        show isSafe;
        countNums: countNums+1;
        ];
    :isSafe
    };

initialTableShort: update safeNew: raze checkOneLine each parsed from initialTableShort;
countGoodNew: count select from initialTableShort where safeNew;
countGoodNew+countGood

// Advent 3
system "c 300 300";
initialTable: raze read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input3_2.txt;
//initialTable: "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64]don't()(mul(11,8)undo()?mul(8,5))xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))";
oneDigitPos: initialTable ss "mul([0-9],";
twoDigitPos: initialTable ss "mul([0-9][0-9],";
threeDigitPos: initialTable ss "mul([0-9][0-9][0-9],";
doPos: initialTable ss "do()";
dontPos: initialTable ss "don't()";

//dontPosTarget: 17851;
findNextDo:{[initialTable;dontPosTarget]
    show dontPosTarget;
    num: first (dontPosTarget _ initialTable) ss "do()";
    :dontPosTarget+til num
    };

exList: findNextDo[initialTable;] each (neg[4]_dontPos);
exList: asc distinct raze exList;
//doTab: ([] x: dontPos; y: 3_doPos);
//doTab: update exclusion: {x+til y-x}'[x;y] from doTab;

//exList: asc raze exec exclusion from doTab;
oneDigitPos: oneDigitPos where not oneDigitPos in exList;
twoDigitPos: twoDigitPos where not twoDigitPos in exList;
threeDigitPos: threeDigitPos where not threeDigitPos in exList;

oneDigitPos: oneDigitPos where oneDigitPos<(first neg[4]#dontPos);
twoDigitPos: twoDigitPos where twoDigitPos<(first neg[4]#dontPos);
threeDigitPos: threeDigitPos where threeDigitPos<(first neg[4]#dontPos);

targetPos: 38;
num: 1;
processPos:{[initialTable;targetPos;num]
    selection: (10+num)# targetPos _ initialTable;
    show selection;
    closeBracket: 1+first selection ss ")";
    $[closeBracket>0;
        res:(closeBracket) # selection;
        res: ""
        ];
    show res;
    :res
    };

groupOne: processPos[initialTable;;0] each oneDigitPos;
groupTwo: processPos[initialTable;;1] each twoDigitPos;
groupThree: processPos[initialTable;;2] each threeDigitPos;

resTable: ([] x: groupOne,groupTwo,groupThree);
select sum numOne*numTwo from update numOne: {"F"$ssr[first x;"mul(";""]} each parsed, numTwo: {"F"$ssr[last x;")";""]} each parsed from update parsed: ("," vs) each x from resTable
174561379f
120019792f // too high
106921067f


// Advent 4
initialTable: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input4_2.txt;
len: first count each initialTable;
lines: count initialTable;
initialTable: raze initialTable;
xLoc: where initialTable="X";

xLocTarget: 4;
checkOneLoc:{[xLocTarget;initialTable;len;lines]
    show xLocTarget;
    lenNum: xLocTarget div len;
    north: `$ $[(xLocTarget-(3*len))<0;"";initialTable[xLocTarget-(1*len)],initialTable[xLocTarget-(2*len)],initialTable[xLocTarget-(3*len)]];
    northeast: `$ $[((xLocTarget-(3*len))<0) or (xLocTarget+3)>=(len*(1+lenNum));"";initialTable[(xLocTarget-(1*len))+1],initialTable[(xLocTarget-(2*len))+2],initialTable[(xLocTarget-(3*len))+3]];
    east: `$ $[(xLocTarget+3)>=(len*(1+lenNum));"";initialTable[xLocTarget+(1)],initialTable[xLocTarget+(2)],initialTable[xLocTarget+(3)]];
    southeast: `$ $[((xLocTarget+(3*len))<0) or (xLocTarget+3)>=(len*(1+lenNum));"";initialTable[(xLocTarget+(1*len))+1],initialTable[(xLocTarget+(2*len))+2],initialTable[(xLocTarget+(3*len))+3]];
    south: `$ $[(xLocTarget+(3*len))>(lines*len);"";initialTable[xLocTarget+(1*len)],initialTable[xLocTarget+(2*len)],initialTable[xLocTarget+(3*len)]];
    southwest: `$ $[((xLocTarget+(3*len))>(lines*len)) or (xLocTarget-3)<(len*(lenNum));"";initialTable[(xLocTarget+(1*len))-1],initialTable[(xLocTarget+(2*len))-2],initialTable[(xLocTarget+(3*len))-3]];
    west: `$ $[(xLocTarget-3)<(len*(lenNum));"";initialTable[xLocTarget-(1)],initialTable[xLocTarget-(2)],initialTable[xLocTarget-(3)]];
    northwest: `$ $[((xLocTarget-(3*len))<0) or (xLocTarget-3)<(len*(lenNum));"";initialTable[(xLocTarget-(1*len))-1],initialTable[(xLocTarget-(2*len))-2],initialTable[(xLocTarget-(3*len))-3]];
    list: north,northeast,east,southeast,south,southwest,west,northwest;
    :([] xLocTarget; x: enlist (list where list like "MAS"))
    };

res: raze checkOneLoc[;initialTable;len;lines] each xLoc;
sum select count each x from res
// 2504

// part 2

xLoc: where initialTable="A";

xLocTarget: 12;
checkOneLoc:{[xLocTarget;initialTable;len;lines]
    show xLocTarget;
    lenNum: xLocTarget div len;
    northeast: $[((xLocTarget-(1*len))<0) or (xLocTarget+1)>=(len*(1+lenNum));"";initialTable[(xLocTarget-(1*len))+1]];
    southeast: $[((xLocTarget+(1*len))<0) or (xLocTarget+1)>=(len*(1+lenNum));"";initialTable[(xLocTarget+(1*len))+1]];
    southwest: $[((xLocTarget+(1*len))>(lines*len)) or (xLocTarget-1)<(len*(lenNum));"";initialTable[(xLocTarget+(1*len))-1]];
    northwest: $[((xLocTarget-(1*len))<0) or (xLocTarget-1)<(len*(lenNum));"";initialTable[(xLocTarget-(1*len))-1]];
    list1: `$northeast,"A",southwest;
    list2: `$southeast,"A",northwest;
    :([] xLocTarget; x: enlist (list1=`SAM) or (list1=`MAS); y: enlist (list2=`SAM) or (list2=`MAS))
    };
res: raze checkOneLoc[;initialTable;len;lines] each xLoc;
count select from res where x, y
// 1923