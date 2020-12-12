system "c 300 300";
initialTable: ([] read0 `:D:/Coding/advent/advent2020/input7_1.txt);
initialTable: update parsed: " " vs  'x from initialTable;

countCommas:{[targetLine]
    res: targetLine[`parsed];
    countCommas: ((0^(count each group res)["bags,"]) + (0^(count each group res)["bag,"]) +
        (0^(count each group res)["bag."]) + (0^(count each group res)["bags."]));
    :update countCommas from targetLine
    };

initialTableUpd: countCommas each initialTable;
// select max countCommas from initialTableUpd
// Maximum number of different bags in one bag is 4 (not 2!!!).
// The same can be done by just counting the elements in parsed column.
initialTable: update outerBag1: parsed[;0], outerBag2: parsed[;1] from initialTable;
initialTable: update numInsideBag1: parsed[;4], insideBag1_1: parsed[;5], insideBag1_2: parsed[;6] from initialTable;
initialTable: update numInsideBag2: parsed[;8], insideBag2_1: parsed[;9], insideBag2_2: parsed[;10] from initialTable;
initialTable: update numInsideBag3: parsed[;12], insideBag3_1: parsed[;13], insideBag3_2: parsed[;14] from initialTable;
initialTable: update numInsideBag4: parsed[;16], insideBag4_1: parsed[;17], insideBag4_2: parsed[;18] from initialTable;

initialTableShort: select outerBag: `$sv'[" ";flip (outerBag1;outerBag2)], numInsideBag1: "J"$numInsideBag1,
    insideBag1: `$sv'[" ";flip (insideBag1_1;insideBag1_2)], numInsideBag2: "J"$numInsideBag2,
    insideBag2: `$sv'[" ";flip (insideBag2_1;insideBag2_2)], numInsideBag3: "J"$numInsideBag3,
    insideBag3: `$sv'[" ";flip (insideBag3_1;insideBag3_2)], numInsideBag4: "J"$numInsideBag4,
    insideBag4: `$sv'[" ";flip (insideBag4_1;insideBag4_2)] from initialTable;

listOfBags: `$"shiny gold";
listOfBagsNew: ();

while[(count listOfBags)<>(count listOfBagsNew);
    listOfBags: $[0=count listOfBagsNew;`$"shiny gold";listOfBagsNew];
    newListOfBags: exec outerBag from initialTableShort where (insideBag1 in listOfBags) or (insideBag2 in listOfBags)
        or (insideBag3 in listOfBags) or (insideBag4 in listOfBags);
    show count newListOfBags;
    listOfBagsNew: distinct newListOfBags,listOfBags;
    show listOfBagsNew;
    ];

count newListOfBags // 287

// 2nd part

listOfBags: `$"shiny gold";
listOfBagsNew: ();
sumBags: 0;
newListOfBags: ();
listOfBagsAll: ();

initialTableShort2: select outerBag: `$sv'[" ";flip (outerBag1;outerBag2)],
    insideBag1num: `$sv'[" ";flip (numInsideBag1;insideBag1_1;insideBag1_2)],
    insideBag2num: `$sv'[" ";flip (numInsideBag2;insideBag2_1;insideBag2_2)],
    insideBag3num: `$sv'[" ";flip (numInsideBag3;insideBag3_1;insideBag3_2)],
    insideBag4num: `$sv'[" ";flip (numInsideBag4;insideBag4_1;insideBag4_2)] from initialTable;

while[ //count listOfBagsAll<>listOfBagsNew;
    listOfBags: $[0=count listOfBagsAll;`$"shiny gold";listOfBagsAll];
    newTableOfBags: select from initialTableShort2 where (outerBag in listOfBags);
    bag1: `$ {2_x} each exec string[insideBag1num] from newTableOfBags;
    bag2: `$ {2_x} each exec string[insideBag2num] from newTableOfBags;
    bag3: `$ {2_x} each exec string[insideBag3num] from newTableOfBags;
    bag4: `$ {2_x} each exec string[insideBag4num] from newTableOfBags;
    num1: "J"$ {2#x} each exec string[insideBag1num] from newTableOfBags;
    num2: "J"$2#first exec string[insideBag2num] from newTableOfBags;
    num3: "J"$2#first exec string[insideBag3num] from newTableOfBags;
    num4: "J"$2#first exec string[insideBag4num] from newTableOfBags;
    newListOfBags: (distinct bag1,bag2,bag3,bag4) except `$"other bags.";
    show newTableOfBags;
    // sumBagsNew: sum 0^ raze exec numInsideBag1, numInsideBag2, numInsideBag3, numInsideBag4 from newTableOfBags;
    listOfBagsNew: distinct newListOfBags;
    listOfBagsAll: distinct newListOfBags,listOfBags;
    show listOfBagsAll;
    // sumBags: sumBags+sumBagsNew;
    // show sumBags;
    ];

count distinct listOfBagsAll
// 302 too low
// 48250 too high
res: 0!newTableOfBags lj `outerBag xkey initialTableShort;
noBagsList: exec outerBag from res where insideBag1num=`$"no other bags.";
res: update insideBag1num: `$"no other bags.", totalBags: (0^numInsideBag1)+(0^numInsideBag2)+(0^numInsideBag3)+(0^numInsideBag4)
    from res where ((insideBag1 in noBagsList) or (null insideBag1)) and
    ((insideBag2 in noBagsList) or (null insideBag2)) and ((insideBag3 in noBagsList) or (null insideBag3)) and
    ((insideBag4 in noBagsList) or (null insideBag4));


update insideBag1num: `$"no other bags." from
select from initialTableShort2 where outerBag in noBagsList
select from res where outerBag in noBagsList
meta initialTableShort2
meta res
