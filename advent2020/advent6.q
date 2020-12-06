initialTable: ([] read0 `:D:/Coding/advent/advent2020/input6_1.txt);
initialTable: update division: ?[x like "";1;0] from initialTable;
initialTable: update groupNum: sums division from initialTable;

countInGroup:{[targetGroup;initialTable]
    selectedAnswers: raze exec x from initialTable where groupNum=targetGroup;
    countAnswers: count distinct selectedAnswers;
    :([] enlist targetGroup;countAnswers)
    };

res: raze countInGroup[;initialTable] each exec distinct groupNum from initialTable;
exec sum countAnswers from res // 6521

countInGroupSecondTask:{[targetGroup;initialTable]
    selectedAnswers: select x from initialTable where groupNum=targetGroup;
    countLines: exec count i from selectedAnswers where not (`$x)=`; // why cannot I do that with string?
    joinedLine: raze exec x from selectedAnswers;
    groupedRes: count each group joinedLine;
    countAnswers: count where groupedRes=countLines;
    :([] enlist targetGroup;countAnswers)
    };

res: raze countInGroupSecondTask[;initialTable] each exec distinct groupNum from initialTable;
exec sum countAnswers from res // 3305