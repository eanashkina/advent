system "c 300 300";
//\P 17
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input13_1.txt);
initialTable: update divider: 1 from initialTable where (count each x)=0;
initialTable: update groupNum: sums divider from initialTable;
initialTable: delete from initialTable where not null divider;

targetGroupNum: 7;
targetNum: 1;
checkGroup:{[initialTable;targetGroupNum]
    show targetGroupNum;
    left: exec first x from initialTable where groupNum=targetGroupNum;
    right: exec last x from initialTable where groupNum=targetGroupNum;
    left: ssr[left;"[[]";"("];
    left: ssr[left;"[]]";")"];
    left: ssr[left;",";";"];
    left: get left;
    if[1=count left; left: enlist left];
    // TODO: handle empty lists
    
    right: ssr[right;"[[]";"("];
    right: ssr[right;"[]]";")"];
    right: ssr[right;",";";"];
    right: get right;
    if[1=count right; right: enlist right];

    countLeft: count left;
    // TODO: update comparison below so that it works for nested lists
    :([] num: enlist targetGroupNum; res: enlist {[targetNum;left;right] show targetNum; :?[left[targetNum]<right[targetNum];
        `right;?[left[targetNum]=right[targetNum];`equal;`wrong]]}[;left;right] each til countLeft)
    };

raze checkGroup[initialTable;] each -1_distinct exec groupNum from initialTable

left: "[[9,7,3,[[10,9,3,5],[1,8],9,[9,2,6,7,6]]],[2,0,8,[[6,1],[4],6,[4,10,9,6],[]],[5,[],0,[2,0]]],[],[3],[[4],10,[[3,5,10],3,[10],[3,8,2,5],[7,9,9,1]]]]";
left: "[1,[2,[3,[4,[5,6,7]]]],8,9]";

"J"$(string left) where (string left) like "[0-9]"
(1;(2;(3;(4;(5;6;7))));8;9)
leftLine: ((9;7;3;((10;9;3;5);(1;8);9;(9;2;6;7;6)));(2;0;8;((6;1);(4);6;(4;10;9;6);());(5;();0;(2;0)));();(3);((4);10;((3;5;10);3;(10);(3;8;2;5);(7;9;9;1))))
([] leftLine)


([] "," vs left)

parsed: ([] x: "," vs left);
("]" vs) each

parsed: update test: ("[" vs) each x from parsed where x like "*[[]*";
parsed: update test2: ("]" vs) each x from parsed where x like "*[]]*";
parsed: update countOpen: {count (x where string[x] like "*[[]*")} each x from parsed;
parsed: update countClose: {count (x where string[x] like "*[]]*")} each x from parsed;



