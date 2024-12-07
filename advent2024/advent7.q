system "c 300 300";
system "P 17";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2024/input7_2.txt);

initialTable: update (": " vs) each x from initialTable;
initialTable: update res: "F"$first each x from initialTable;
initialTable: update elements: last each x from initialTable;
initialTable: delete x from initialTable;
initialTable: update {"F"$" " vs x} each elements from initialTable;

//initialTable: ([] res: 156 156; elements: ((15 6);(15 6 2)));
//156: 15 6
//156: 15 6 2

initialTable: update lineNum: i from initialTable;
//targetLine: initialTable[1];


processNextPos:{[table;targetPos;targetElements]
    // show targetPos;
    nextEl: targetElements[targetPos];
    lenNexEl: count string nextEl;
    table: table,
        (update res*nextEl, pos: pos+1
            from select from table where pos=targetPos-1),
        (update res+nextEl, pos: pos+1
            from select from table where pos=targetPos-1);
    maxNum: exec max res from table;
    if[maxNum>1e14;
        //show maxNum;
        ];
    table: delete from table where res>targetRes, pos=targetPos;
    test: select from table where res>targetRes, pos<>targetPos;
    if[0<count test;
        show test];
    :table
    };

tenPower:{[testNum]
    //show testNum;
    // testNum: 3;
    resNum: 1;
    while[testNum>0;
        resNum: resNum*10;
        testNum: testNum-1;
        ];
    :resNum
    };

processNextPosExtra:{[table;targetPos;targetElements]
    // show targetPos;
    nextEl: targetElements[targetPos];
    lenNexEl: count string nextEl;
    table: table,
        (update res*nextEl, pos: pos+1, op: {`mult,x} each op
            from select from table where pos=targetPos-1),
        (update res+nextEl, pos: pos+1, op: {`sum,x} each op
            from select from table where pos=targetPos-1),
        (update res: {[res;nextEl;lenNexEl] nextEl+(res*(tenPower[lenNexEl]))}'[res;nextEl;lenNexEl], pos: pos+1, op: {`con,x} each op
            from select from table where pos=targetPos-1);
    maxNum: exec max res from table;
    if[maxNum>1e14;
        show maxNum;
        ];
    table: update diffCheck: res-targetRes from table;
    table: delete from table where diffCheck>0, pos=targetPos;
    table: delete diffCheck from table;

    //select from table where pos=6
//    364586373628j*635j
//    364586373628f*635f
//    635f+(364586373628f*(tenPower[3]))
//    635j+(364586373628j*(tenPower[3]))
//    40421763628632j-635j
    test: select from table where res>targetRes, pos<>targetPos;
    if[0<count test;
        show test];
    :table
    };

processOneLine:{[targetLine]
    //show targetLine;
    targetRes: targetLine`res;
    targetElements: targetLine`elements;

    table: ([] res: enlist first targetElements; pos: 0; targetRes);

    //targetPos: targetPos+1;
    finalRes: table processNextPos[;;targetElements]/ 1+til neg[1]+count targetElements;
    :update lineN: targetLine`lineNum from select from finalRes where res=targetRes
    };

processOneLineExtra:{[targetLine]
    //show targetLine;
    targetRes: targetLine`res;
    targetElements: "f"$targetLine`elements;

    table: ([] res: "f"$enlist first targetElements; pos: 0f; targetRes; op: `);
    // meta table
    //targetPos: 2;
//    finalRes
//    finalRes1
//    table: delete from finalRes1 where pos=7;
//    table:"j"$table
    finalRes: table processNextPosExtra[;;targetElements]/ 1+til neg[1]+count targetElements;
    // show meta finalRes;
    finalRes: update diff: res-targetRes from finalRes;
    :update lineN: targetLine`lineNum from select from finalRes where diff=0, pos=neg[1]+count targetElements
    };

allCombs: raze processOneLine each initialTable;
//select count i by res from initialTable


//exec sum res from select distinct res, lineN from allCombs
// 1430271835320f

// part 2
//  23,274,073,363,443 // too low
// 527,492,904,346,391 // too high

initialTableNew: delete from initialTable where lineNum in exec lineN from allCombs;





allCombsNew: raze processOneLineExtra each initialTableNew;

test1: select distinct res, lineN from allCombsNew;
test2: select distinct res, lineN from allCombsNew;

//select from test1 where not lineN in exec lineN from test2

//40421763628635f	33j
//30503902271528f	525j

1430271835320+exec sum res from select distinct res, lineN from allCombsNew

//236698619898188

//526062632511071
//526062632511071
//  1430271835320
//527492904346391
//456567238446228
//290,794,284,448,203
//581,096,360,369,763
//exec sum res from initialTable

//527492904346391-40421763628635
////487071140717756 // no
//527492904346391-30503902271528
////496989002074863 //no
//527492904346391-(40421763628635+30503902271528)

//455136966610908+1430271835320=456567238446228 // no

//456565678667482