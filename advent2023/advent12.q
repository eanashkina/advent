initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input12_2.txt);
initialTable: update (" " vs) each x from initialTable;
initialTable: select map: x[;0], nums: x[;1] from initialTable;
initialTable: update nums: "J"$("," vs) each nums from initialTable;
initialTable: update numI: i from initialTable;

testOneLine:{[targetLine]
    // targetLine: last initialTable
    show targetLine;
    map: `$string targetLine`map;
    nums: targetLine`nums;
    unknown: where map=`$"?";
    allCombinations: {y(x cross)/x}["#.";count[unknown]-1];
    mapDict: (til count map)!map;

    res: raze testOneCombination[mapDict;;unknown;nums] each allCombinations;
    // targetCombination: `$string last allCombinations
    :update countComb: count res from targetLine
    };

testOneCombination:{[mapDict;targetCombination;unknown;nums]
    // show targetCombination;
    remap: unknown!(`$string targetCombination);
    newMap: value mapDict^remap;
    flagged: update sums isFlag from update isFlag: 1 from ([] newMap) where newMap=`$".";
    counted: value exec count newMap by isFlag from select from flagged where newMap=`$"#";
    $[counted~nums;
        res: ([] map: enlist newMap; enlist counted);
        res: ()
        ];
    :res
    };

finalRes: testOneLine each initialTable;
//exec sum countComb from finalRes // 6852

// Part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input12_1.txt);
initialTable: update (" " vs) each x from initialTable;
initialTable: select map: x[;0], nums: x[;1] from initialTable;
initialTable: update nums: "J"$("," vs) each nums from initialTable;
initialTable: update numI: i from initialTable;
initialTable: update map: {"?" sv 5#enlist x} each map from initialTable;
initialTable: update nums: {raze 5#enlist x} each nums from initialTable;

//finalRes: testOneLine each initialTable; // wsfull








