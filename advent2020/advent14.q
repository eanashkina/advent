system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input14_1.txt);
initialTable: update isNewMask: 1 from initialTable where x like "*mask*";
initialTable: update groupNum: sums isNewMask from initialTable;

numGroups: exec distinct groupNum from initialTable;

updateOneGroup:{[targetGroupNum;initialTable]
    show targetGroupNum;
    data: select from initialTable where groupNum=targetGroupNum;
    mask: last "= " vs first exec x from data;
    maskLength: count mask;
    positions1: ss[mask;"1"];
    positions0: ss[mask;"0"];
    values: select from data where not i=0;
    values : update parsed: (" = " vs) each x from values;
    values: update address: parsed[;0], num: "J"$parsed[;1] from values;
    values: update address: {ssr[x;"mem";""]} each address from values;
    values: update address: "J"$(-1_1_) each address from values;
    values: update numBinary: (2 vs) each num from values;
    values: update numBinary: 0j from values where num=0;

    lineCounts: til count values;
    res: raze updateOneLine[maskLength;;values;positions1;positions0] each lineCounts;
    :res
    };

updateOneLine:{[maskLength;targetLineCount;values;positions1;positions0]
    lineToChange: first exec numBinary from values where i=targetLineCount;
    lineToChange: (((maskLength)-(count lineToChange))#0),lineToChange;
    lineToChange[positions1]: 1;
    lineToChange[positions0]: 0;
    :update numBinary: enlist lineToChange from select from values where i=targetLineCount
    };


resFinal: raze updateOneGroup[;initialTable] each numGroups;
resFinal: update numFinal: (2 sv) each numBinary from resFinal;

select sum numFinal from select last numFinal by address from resFinal // 15018100062885

// the second part
