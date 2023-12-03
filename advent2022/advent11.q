system "c 300 300";
//\P 17
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input11_1.txt);
initialTable: update parsed: (":" vs) each x from initialTable;
initialTable: update meaning: first each parsed, values: last each parsed from initialTable;
initialTable: update monkey: last each meaning from initialTable where meaning like "Monkey *";
initialTable: update fills monkey from initialTable;
initialTable: update items: ssr[;" ";""] each values from initialTable where meaning like "*Starting*";
initialTable: update "F"$("," vs) each items from initialTable where meaning like "*Starting*";

shortTable: select from initialTable where (count each items)>0;
shortTable: update countNum: 0 from shortTable;
finalRes: shortTable runOneCycle[;]/ 1+til 1000;

("F"$"1233456789877644364328647264382467") mod 10

(0b vs 5) * (0b vs 5)

//prd 2#desc exec countNum from finalRes // 113232

runOneCycle:{[shortTable;cycleCount]
    show cycleCount;
    itemsMonkey0: raze exec items from shortTable where monkey="0";
    shortTable: shortTable Monkey0Func[;]/ itemsMonkey0;
    shortTable: update items: enlist () from shortTable where monkey="0";
    itemsMonkey1: raze exec items from shortTable where monkey="1";
    shortTable: shortTable Monkey1Func[;]/ itemsMonkey1;
    shortTable: update items: enlist () from shortTable where monkey="1";
    itemsMonkey2: raze exec items from shortTable where monkey="2";
    shortTable: shortTable Monkey2Func[;]/ itemsMonkey2;
    shortTable: update items: enlist () from shortTable where monkey="2";
    itemsMonkey3: raze exec items from shortTable where monkey="3";
    shortTable: shortTable Monkey3Func[;]/ itemsMonkey3;
    shortTable: update items: enlist () from shortTable where monkey="3";

//    itemsMonkey4: raze exec items from shortTable where monkey="4";
//    shortTable: shortTable Monkey4Func[;]/ itemsMonkey4;
//    shortTable: update items: enlist () from shortTable where monkey="4";
//    itemsMonkey5: raze exec items from shortTable where monkey="5";
//    shortTable: shortTable Monkey5Func[;]/ itemsMonkey5;
//    shortTable: update items: enlist () from shortTable where monkey="5";
//    itemsMonkey6: raze exec items from shortTable where monkey="6";
//    shortTable: shortTable Monkey6Func[;]/ itemsMonkey6;
//    shortTable: update items: enlist () from shortTable where monkey="6";
//    itemsMonkey7: raze exec items from shortTable where monkey="7";
//    shortTable: shortTable Monkey7Func[;]/ itemsMonkey7;
//    shortTable: update items: enlist () from shortTable where monkey="7";
    :shortTable
    };

Monkey0Func:{[shortTable;targetItem]
    show "Monkey 0, ",string targetItem;
    targetItem: (targetItem * 19); //3
    shortTable: update countNum: countNum+1 from shortTable where monkey="0";
    show targetItem;
    $[0=(targetItem mod 23);
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="2";
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="3"
      ];
    :shortTable
    };


Monkey1Func:{[shortTable;targetItem]
    show "Monkey 1, ",string targetItem;
    targetItem:  (targetItem + 6);
    shortTable: update countNum: countNum+1 from shortTable where monkey="1";
    $[0=(targetItem mod 19);
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="2";
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="0"
      ];
    :shortTable
    };

Monkey2Func:{[shortTable;targetItem]
    show "Monkey 2, ",string targetItem;
    targetItem:  (targetItem * targetItem);
    shortTable: update countNum: countNum+1 from shortTable where monkey="2";
    $[0=(targetItem mod 13);
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="1";
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="3"
      ];
    :shortTable
    };

Monkey3Func:{[shortTable;targetItem]
    show "Monkey 3, ",string targetItem;
    targetItem:  (targetItem + 3);
    shortTable: update countNum: countNum+1 from shortTable where monkey="3";
    $[0=(targetItem mod 17);
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="0";
      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="1"
      ];
    :shortTable
    };
//
//Monkey0Func:{[shortTable;targetItem]
//    show "Monkey 0, ",string targetItem;
//    targetItem: floor (targetItem * 7)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="0";
//    show targetItem;
//    $[0=(targetItem mod 3);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="4";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="1"
//      ];
//    :shortTable
//    };
//
//
//Monkey1Func:{[shortTable;targetItem]
//    show "Monkey 1, ",string targetItem;
//    targetItem: floor (targetItem + 5)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="1";
//    $[0=(targetItem mod 13);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="7";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="3"
//      ];
//    :shortTable
//    };
//
//Monkey2Func:{[shortTable;targetItem]
//    show "Monkey 2, ",string targetItem;
//    targetItem: floor (targetItem * targetItem)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="2";
//    $[0=(targetItem mod 2);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="6";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="5"
//      ];
//    :shortTable
//    };
//
//Monkey3Func:{[shortTable;targetItem]
//    show "Monkey 3, ",string targetItem;
//    targetItem: floor (targetItem + 6)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="3";
//    $[0=(targetItem mod 11);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="2";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="6"
//      ];
//    :shortTable
//    };
//
//Monkey4Func:{[shortTable;targetItem]
//    show "Monkey 4, ",string targetItem;
//    targetItem: floor (targetItem * 11)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="4";
//    show targetItem;
//    $[0=(targetItem mod 5);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="1";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="7"
//      ];
//    :shortTable
//    };
//
//
//Monkey5Func:{[shortTable;targetItem]
//    show "Monkey 5, ",string targetItem;
//    targetItem: floor (targetItem + 8)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="5";
//    $[0=(targetItem mod 17);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="4";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="0"
//      ];
//    :shortTable
//    };
//
//Monkey6Func:{[shortTable;targetItem]
//    show "Monkey 6, ",string targetItem;
//    targetItem: floor (targetItem + 1)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="6";
//    $[0=(targetItem mod 19);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="0";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="5"
//      ];
//    :shortTable
//    };
//
//Monkey7Func:{[shortTable;targetItem]
//    show "Monkey 7, ",string targetItem;
//    targetItem: floor (targetItem + 4)%3;
//    shortTable: update countNum: countNum+1 from shortTable where monkey="7";
//    $[0=(targetItem mod 7);
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="3";
//      shortTable: update items: {x,enlist y}'[items;targetItem] from shortTable where monkey="2"
//      ];
//    :shortTable
//    };
//
//
//
