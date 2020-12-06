initialTable: ([] read0 `:D:/Coding/advent/advent2020/input4_1.txt);
initialTable: update division: ?[x like "";1;0] from initialTable;
initialTable: update passportNum: sums division from initialTable;

passportNums: exec distinct passportNum from initialTable;

targetNum: first passportNums;

checkOnePassport:{[targetNum;initialTable]
    show targetNum;
    targetLine: " " sv exec x from initialTable where passportNum=targetNum; // for the first part of the task
    isValid: (targetLine like "*byr:*") and (targetLine like "*iyr:*") and (targetLine like "*eyr:*") and (targetLine like "*hgt:*")
        and (targetLine like "*hcl:*") and (targetLine like "*ecl:*") and (targetLine like "*pid:*");
    // The code below is for the second part of the task
    targetTable: `x xcol ([] " " vs targetLine);
    targetTable: select parsed: ":" vs  'x from targetTable;
    targetTable: update parameter: `$parsed[;0], valueParam: `$parsed[;1] from targetTable;

    isByr: ("J"$ string first exec valueParam from targetTable where parameter=`byr) within (1920 2002);
    isIyr: ("J"$ string first exec valueParam from targetTable where parameter=`iyr) within (2010 2020);
    isEyr: ("J"$ string first exec valueParam from targetTable where parameter=`eyr) within (2020 2030);

    hgtParam: string first exec valueParam from targetTable where parameter=`hgt;
    $[(`$-2#hgtParam)=`cm;
        isHgt: ("J"$-2_hgtParam) within (150 193);
        (`$-2#hgtParam)=`in;
            isHgt: ("J"$-2_hgtParam) within (59 76);
                isHgt: 0b
        ];

    hclParam: string first exec valueParam from targetTable where parameter=`hcl;
    $[(`$1#hclParam)=`$"#";
        [
            hclParamShort: 1_hclParam;
            $[6=count hclParamShort;
                [
                    hclParamShort: ssr[hclParamShort;"[0-9]";""];
                    hclParamShort: ssr[hclParamShort;"[a-z]";""];
                    isHcl: $[0<count hclParamShort;0b;1b]
                    ];
                isHcl: 0b
                ];
            ];
        isHcl: 0b;
        ];



    isEcl: (first exec valueParam from targetTable where parameter=`ecl) in `amb`blu`brn`gry`grn`hzl`oth;
    isPidParam: string first exec valueParam from targetTable where parameter=`pid;
    $[9=count isPidParam;
        [
            $[0=count ssr[isPidParam;"[0-9]";""];isPid: 1b; isPid: 0b]
            ];
        isPid: 0b
        ];

    isValid: all isValid,isByr,isIyr,isEyr,isHgt,isHcl,isEcl,isPid;
    :([] enlist targetNum;isValid)
    };

res: raze checkOnePassport[;initialTable] each passportNums;

select sum isValid from res //200; first task
select sum isValid from res //116; second task - too high