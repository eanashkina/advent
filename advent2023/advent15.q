initialLine: raze read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input15_2.txt;
//initialLine: "HASH";

initialTable: ([] step: "," vs initialLine);

func: {((x+y)*17) mod 256};

proceedOneStep:{[targetStep]
    show targetStep;
    x: 0;
    :x func[;]/ raze "i"$string targetStep
    };

//res: update num: proceedOneStep each step from initialTable;
//exec sum num from res // 516657

// Part 2

initialTable: update isDash: {(`$"-") in `$string x} each step from initialTable;
initialTable: update isEqual: {(`$"=") in `$string x} each step from initialTable;
initialTable: update parseStep: ("=" vs) each step from initialTable where isEqual;
initialTable: update parseStep: ("-" vs) each step from initialTable where isDash;
initialTable: update letter: parseStep[;0], focal: "F"$parseStep[;1] from initialTable;
initialTable: update num: proceedOneStep each letter from initialTable;
initialTable: update `$letter from initialTable;

boxTable: ([] boxNum : til 256; lens: 256#enlist ``);

//targetLine: initialTable[167];
processOneStep:{[boxTable;targetLine]
    show targetLine;
    isDash: targetLine`isDash;
    isEqual: targetLine`isEqual;
    targetBox: targetLine`num;
    targetLabel: targetLine`letter;
    targetFocal: `$string targetLine`focal;
    selectedBox: select from boxTable where boxNum=targetBox;
    lensInBox: first exec lens from selectedBox;
    if[isEqual;
        $[targetLabel in lensInBox;
            [
                focalPos: first 1+where lensInBox=targetLabel;
                lensInBox[focalPos]: targetFocal;
                ];
            [
                lensInBox: lensInBox,targetLabel,targetFocal;
                lensInBox: lensInBox where not lensInBox=`;
                ]
            ];
        ];

    if[isDash;
        $[targetLabel in lensInBox;
            [
                lensPos: where lensInBox=targetLabel;
                lensInBox[lensPos]: `;
                lensInBox[lensPos+1]: `;
                lensInBox: lensInBox where not lensInBox=`;
                ];
            [
                lensInBox: lensInBox;
                ]
            ];
        ];


    :update lens: enlist lensInBox from boxTable where boxNum=targetBox
    };

res: boxTable processOneStep[;]/initialTable;
res: update length: {count x where not x=`} each lens from res;
resShort: select from res where length>0;
resShort: update isNum: {all string[x] in .Q.n} each lens from (ungroup resShort);
resShort: select from resShort where isNum;
resShort: update isFlag: not boxNum=prev boxNum from resShort;

resShort: update fills posBox from update posBox: i from resShort where isFlag;

resShort: update sums isFlag from resShort;
resShort: update posLens: 1+(i-posBox) from resShort;
resShort: update "J"$string each lens from resShort;
exec sum (boxNum+1)*posLens*lens from resShort // 210906 /

