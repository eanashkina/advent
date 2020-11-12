tableFromFile: `num xcol ([] "F"$read0 `:D:/Coding/advent2019/input1_1.txt);

sum floor((tableFromFile%3))-2

firstSum: 33583; // 3363033;

fuel: firstSum;

calculateOneLine:{[line]
    show line;
    fuel: exec first num from line;
    fuel: floor((fuel%3))-2;
    firstSum: fuel;
    while[fuel>0;
        show fuel;
        fuel: floor((fuel%3))-2;
        if[fuel>0;
            firstSum: firstSum + fuel;
            ];

        ];
    :firstSum
    };

calculateOneLine[((enlist `num)!enlist 100756)]

tableFromFile[1]

res: sum raze calculateOneLine each tableFromFile;