// Advent 5
system "c 300 300";
initialTable: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input5_2.txt;
spacePos: where initialTable like "";
rules: spacePos#initialTable;
pages: raze (spacePos+1) _ initialTable;

//targetPage: pages[4];


targetNums: "47|53";
parseRules:{[targetNumsX;numToFind]
    num1: 2#targetNumsX; num2: 3 _ targetNumsX;
    $[(any num1 like/: numToFind) and (any num2 like/: numToFind);
        res: targetNumsX;
        res: ""];
    :res
    };

checkNums:{[targetNums;targetPageParsed]
    //show targetNums;
    num1: 2#targetNums; num2: 3 _ targetNums;
    rest: raze (1+where targetPageParsed like num1) _ targetPageParsed;
    //show rest;
    rest2: where rest like num2;
    :0<count rest2
    };

checkTarget:{[targetPage;rules]
    targetPageParsed: "," vs targetPage;
    numToFind: "*",/:targetPageParsed;
    res: parseRules[;numToFind] each rules;
    res: res where not res like "";
    :all checkNums[;targetPageParsed] each res
    };

res: checkTarget[;rules] each pages;
selected: pages where res;

targetLine: first selected;
findMidPos:{[targetLine]
    parsed: "," vs targetLine;
    :parsed[(count parsed) div 2]

    };

//sum "F"$findMidPos each selected

//7307f

// part 2
perm:{(1 0#x){raze(1 rotate)scan'x,'y}/x};

checkPerm:{[res;targetPerm]
    :all checkNums[;targetPerm] each res
    };

selectedRest: pages where not res;
//count selectedRest // 82
targetPage: selectedRest[1];


pivot:{[t]
    u: `$string asc distinct last f:flip key t;
    pf:{x#(`$string y)!z};
    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
    p
    };

checkNumsOutput:{[targetNums;targetPageParsed]
    // targetNums: first violatedRules;
    //show targetNums;
    num1: 2#targetNums; num2: 3 _ targetNums;
    rest: raze (1+where targetPageParsed like num1) _ targetPageParsed;
    //show rest;
    rest2: where rest like num2;
    :([] isOrder: 0<count rest2; enlist "F"$num1; enlist "F"$num2)
    };

assignWeigth:{[targetPageParsedTable;targetRule]
    //targetRule: "62|85"
    //show targetRule;
    num1: `$2#targetRule; num2: `$3 _ targetRule;
    targetPageParsedTable: update weight-1 from targetPageParsedTable where x=num1;
    targetPageParsedTable: update weight+1 from targetPageParsedTable where x=num2;

    :targetPageParsedTable
    };

checkTargetRest:{[targetPage;rules]
    show targetPage;
    targetPageParsed: "," vs targetPage;
    numToFind: "*",/:targetPageParsed;
    res: parseRules[;numToFind] each rules;
    res: res where not res like "";
    targetPageParsedTable: ([] x: `$targetPageParsed; weight: 0);
    resTable: targetPageParsedTable assignWeigth[;]/ res;
    newOrder: string exec x from `weight xasc resTable;
    //distinct raze ("|" vs ) each res
    :newOrder
//    checkNumOutput: raze checkNumsOutput[;newOrder] each res;
//    pivot select count i by num1, isOrder from checkNumOutput
//    violatingNums: select from checkNumOutput where not isOrder;
//
//
//    violatedRules: res where not checkNums[;targetPageParsed] each res;
//
//    res where
//
//    perms: string perm "F"$targetPageParsed;
//    .Q.gc[];
    //:perms where checkPerm[res;] each perms
    };

finalRes: checkTargetRest[;rules] each selectedRest;

findMidPosParsed:{[targetLine]
    :targetLine[(count targetLine) div 2]

    };
sum "F"$findMidPosParsed each finalRes
//4713f