initialTable: (read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input9_2.txt);

line: first initialTable;

processOneLine:{[line]
    show line;
    line: enlist "J"$" " vs line;
    x: 0;
    nonZeroes: count where not line[x]=0j;
    while[nonZeroes>0;

        diffLine: 1_deltas line[x];
        line: line,enlist diffLine;
        x: x+1;
        nonZeroes: count where not line[x]=0j;
        ];
    show line;
    revLine: reverse line;
    processRes:{[revLine;num]
        show num;
        targetLine: revLine[num];
        prevLastNum: last revLine[num-1];
        revLine[num]: targetLine,((last targetLine)+prevLastNum);
        :revLine
        };

    finalRes: revLine processRes[;]/ 1_til count revLine;

    :last last finalRes
    };

//sum processOneLine each initialTable
//1921197370

// Part 2

line: last initialTable;

processOneLineBack:{[line]
    show line;
    line: enlist "J"$" " vs line;
    x: 0;
    nonZeroes: count where not line[x]=0j;
    while[nonZeroes>0;

        diffLine: neg[1]*reverse 1_deltas reverse line[x];
        line: line,enlist diffLine;
        x: x+1;
        nonZeroes: count where not line[x]=0j;
        ];
    show line;
    revLine: reverse line;
    //num: 2;
    processRes:{[revLine;num]
        show num;
        targetLine: revLine[num];
        prevLastNum: first revLine[num-1];
        revLine[num]: ((first targetLine)-prevLastNum),targetLine;
        :revLine
        };

    finalRes: revLine processRes[;]/ 1_til count revLine;

    :first last finalRes
    };

//sum processOneLineBack each initialTable
//1124