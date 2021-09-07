system "c 300 300";
// initialTable: ([] read0 `:D:/Coding/advent/advent2020/input13_1.txt);
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2020/input13_1.txt);
targetTimestamp: "J"$exec x from initialTable[0];
buses: "," vs exec x from initialTable[1];
busesNum: "J"$buses where not buses like "*x*";

startTime: -1+"j"$(targetTimestamp%(max busesNum));

res: `time`buses xcol ([] startTime+til 100000) cross ([] busesNum);
res: `busTimestamp xasc update busTimestamp: time*buses from res;

finalRes: first select from res where busTimestamp>=targetTimestamp;
finalTimestamp: (finalRes[`busTimestamp]-targetTimestamp)*finalRes[`buses]; //102

// The second part
checkTable: update num: deltas num from (select from (update num: i from ([] "J"$buses)) where not null buses) where not num=0;

res: `time`buses xcol ([] 100000000000+til 10000000) cross ([] busesNum);
res: `busTimestamp xasc update busTimestamp: time*buses from res;

finalRes: update difference: deltas busTimestamp from res;

finalRes: update difference: 0 from finalRes where buses=(first busesNum);
finalRes: finalRes lj `buses xkey checkTable;
finalRes: update sameValue:1 from finalRes where difference=num;
finalRes: update 0^sameValue from finalRes;

finalRes: update groupNum: 1 from finalRes where sameValue=1;
finalRes: update firstInGroup: sameValue & not prev sameValue from finalRes;
finalRes: update groupId: sums firstInGroup from finalRes;

// finalResShort: select from finalRes where not buses=prev buses;


targetGroupIds: exec distinct groupId from (select sum sameValue by groupId from finalResShort) where sameValue>=(count busesNum);

targetGroup: 112499;
select max groupId from finalRes //892794
max targetGroupIds // 736993j
checkOneGroup:{[targetGroup;finalRes;busesNum]
    show targetGroup;
    selectedTable: select from finalRes where groupId=targetGroup, not null groupNum;
    $[busesNum~(exec distinct buses from selectedTable);isGood: 1;isGood: 0];
    :([] enlist targetGroup;isGood)
    };

res: raze checkOneGroup[;finalRes;busesNum] peach targetGroupIds;
finalTargetGroupIds: exec targetGroup from res where isGood=1;

select from finalRes where groupId in finalTargetGroupIds


10000#finalRes

select from finalRes where busTimestamp within 1068700 1070000