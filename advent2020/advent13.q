system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input13_1.txt);
targetTimestamp: "J"$exec x from initialTable[0];
buses: "," vs exec x from initialTable[1];
busesNum: "J"$buses where not buses like "*x*";

startTime: -1+"j"$(targetTimestamp%(max busesNum));

res: `time`buses xcol ([] startTime+til 100000) cross ([] busesNum);
res: `busTimestamp xasc update busTimestamp: time*buses from res;

finalRes: first select from res where busTimestamp>=targetTimestamp;
finalTimestamp: (finalRes[`busTimestamp]-targetTimestamp)*finalRes[`buses]; //102

// The second part
// (select from (update num: i from ([] "J"$buses)) where not null buses)

//buses: "," vs "1789,37,47,1889";
//busesNum: "J"$buses where not buses like "*x*";
checkTable: update num: deltas num from (select from (update num: i from ([] "J"$buses)) where not null buses) where not num=0;
 startTimeNew: 523*23*29*41;
//startTimeNew: 19;
//  100000000000000
//    5512264783014 // too low
//16128485914812962 // too high
// 1900003818865841
// 66279790000000
//startTimeNew - (17*(startTimeNew div 17))
//(16128485914812962%startTimeNew)%19
//(startTimeNew+6)%17
//a: 1;

checkOneValue:{[a;checkTable;startTimeNew;busesNum]
    show a;
    res: `time`buses xcol ([] startTimeNew*((a*1000000)+(til 1000000))) cross ([] busesNum);
    //    res: `time`buses xcol ([] startTimeNew*(til 3123741)) cross ([] busesNum);
    res: update time: 19*(time-1) from res;
    //    res: update time : 7*(time-1) from res;
    res: res lj `buses xkey update sums num from checkTable;
    res: update sumTime: time+num from res;
    res: update newGroup: 1 from res where not time=prev time;
    res: update groupId: sums newGroup from res;
    resShort: select from res where sumTime=(buses*(sumTime div buses));
    resFinal: (select count i by groupId from resShort);
    :([] enlist a;(exec max x from resFinal))
    };


// 100#res
// a: 3300
resFinalSeveralA: raze checkOneValue[;checkTable;startTimeNew;busesNum] each (0+(til 100));
targetA: first exec a from resFinalSeveralA where x=count busesNum;
res: `time`buses xcol ([] startTimeNew*((targetA*1000000)+(til 1000000))) cross ([] busesNum);
100#res
res: res lj `buses xkey update sums num from checkTable;
res: update sumTime: time+num from res;
res: update newGroup: 1 from res where not time=prev time;
res: update groupId: sums newGroup from res;
resShort: select from res where sumTime=(buses*(sumTime div buses));
resFinal: exec first groupId from `x xdesc select count i by groupId from resShort;
select from resShort where groupId=resFinal


`x xdesc (select count i by groupId from resShort)
groupIds: exec groupId from (select count i by groupId from resShort) where x=max x;

select from resShort where groupId=204433j
  100000000000000
 1900024718846347
 1900062718927154
16128485914812962
  327300950120029
resShort: update diff: deltas sumTime from resShort;





resShortShort: select from resShort where diff<1000;
resShortShort: update diff2: deltas sumTime from resShortShort;
select from resShortShort where diff2<100

// find groups

res: update col37: (time+13) div 37, col523: (time+19) div 523, col13: (time+37) div 13, col23: (time+42) div 23,
    col29: (time+48) div 29, col547: (time+50) div 547, col41: (time+60) div 41, col17: (time+67) div 17 from res;
100#res
select from res where ((col523*523)=time) and ((col37*37)=time) // and ((col29*29)=time) // and ((col23*23)=time) // and ((col13*13)=time)


res: `busTimestamp xasc update busTimestamp: time*buses from res;

finalRes: update difference: deltas busTimestamp from res;

finalRes: update difference: 0 from finalRes where buses=(first busesNum);
finalRes: finalRes lj `buses xkey checkTable;
finalRes: update sameValue:1 from finalRes where difference=num;
finalRes: update 0^sameValue from finalRes;

finalRes: update groupNum: 1 from finalRes where sameValue=1;
finalRes: update firstInGroup: sameValue & not prev sameValue from finalRes;
finalRes: update groupId: sums firstInGroup from finalRes;

finalResShort: select from finalRes where not buses=prev buses;

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