system "c 300 300";

initialTableData: ([] read0 `:C:/Users/Katerina/Documents/GitHub/advent/advent2020/inputDay16_data.txt);
initialMyTicket: "J"$"," vs first read0 `:C:/Users/Katerina/Documents/GitHub/advent/advent2020/inputDay16_my_ticket.txt;
initialNearbyTickets: ([] read0 `:C:/Users/Katerina/Documents/GitHub/advent/advent2020/inputDay16_nearby_tickets.txt);

// Part 1
initialTableData: ([] ("class: 1-3 or 5-7";"row: 6-11 or 33-44";"seat: 13-40 or 45-50"));
initialMyTicket: 11 12 13;
initialNearbyTickets: ([] ("7,3,47";"40,4,50";"55,2,20";"38,6,12"));

initialTableData: ([] ("class: 0-1 or 4-19";"row: 0-5 or 8-19";"seat: 0-13 or 16-19"));
initialMyTicket: 11 12 13;
initialNearbyTickets: ([] ("3,9,18";"15,1,5";"5,14,9"));

// Add comma in the end of ticket lines to improve raze.

initialNearbyTicketsNew: update {x,","} each x from initialNearbyTickets; // there is an adverb for that!
allNearbyNumbers: "J"$"," vs raze exec x from initialNearbyTicketsNew;
allNearbyNumbers: allNearbyNumbers where not null allNearbyNumbers;

parsedTableData: select firstParse: (": " vs) each x from initialTableData;
parsedTableData: update dataType: `$firstParse[;0], firstParse: firstParse[;1] from parsedTableData;
parsedTableData: update firstParse: (" or " vs) each firstParse from parsedTableData;
parsedTableData: update firstGroup: firstParse[;0], secondGroup: firstParse[;1] from parsedTableData;
parsedTableData: update firstGroup: ("-" vs) each firstGroup from parsedTableData;
parsedTableData: update secondGroup: ("-" vs) each secondGroup from parsedTableData;
parsedTableData: update firstGroupStart: "J"$firstGroup[;0], firstGroupEnd: "J"$firstGroup[;1],
    secondGroupStart: "J"$secondGroup[;0], secondGroupEnd: "J"$secondGroup[;1] from parsedTableData;
parsedTableData: delete firstParse, firstGroup, secondGroup from parsedTableData;
parsedTableData: update firstInterval: firstGroupStart+til each (1+firstGroupEnd-firstGroupStart) from parsedTableData;
parsedTableData: update secondInterval: secondGroupStart+til each (1+secondGroupEnd-secondGroupStart) from parsedTableData;

allNumbers: asc distinct raze raze exec firstInterval, secondInterval from parsedTableData;
//sum allNearbyNumbers except allNumbers // 19240j
extraNums: allNearbyNumbers except allNumbers;

// Part 2

allNearbyNumbersTable: "J"$update ("," vs) each x from initialNearbyTickets;
allNearbyNumbersTable: update isWrong: any x in/: extraNums from allNearbyNumbersTable;
allNearbyNumbersTable: update any each isWrong from allNearbyNumbersTable;

// Here I need to exclude invalid tickets.
allNearbyNumbersTable: delete from allNearbyNumbersTable where isWrong;

parsedTableData: delete firstInterval, secondInterval from update joinedInterval: (firstInterval,'secondInterval) from
    parsedTableData;

numOfTypes: til count exec first x from allNearbyNumbersTable; // 20

// For each numOfTypes identify the type.
targetType: first numOfTypes;

checkOneType:{[targetType;allNearbyNumbersTable;parsedTableData]
    numsToCheck: exec x[;targetType] from allNearbyNumbersTable;
    table: update isSuitable: all each numsToCheck in/: joinedInterval from parsedTableData;
    selectedTable: select dataType from table where isSuitable;
    show targetType;
    show selectedTable;
    :update typeNum: targetType from selectedTable
    };

res: raze checkOneType[;allNearbyNumbersTable;parsedTableData] each numOfTypes;

select count i, distinct dataType by typeNum from res

(hsym `$":C:/Users/Katerina/Documents/GitHub/advent/advent2020/res.csv") 0:"," 0:
    update ", " sv/: string each dataType from
        select count i, distinct dataType by typeNum from res where not dataType in
            (`price`route`type,(`$"arrival track"),`seat`duration`row`zone,
            (`$"arrival location"),(`$"departure station"),(`$"departure time"),
            (`$"departure platform"),(`$"departure location"),(`$"departure track"),
            (`$"departure date"),`wagon)

0 arrival track
1 price
2 wagon
3 route
4 seat
5 type
6 departure date
7 departure time
8 zone
9 arrival location
10 departure platform
11 class
12 duration
13 row
14 arrival platform
15 train
16 arrival station
17 departure station
18 departure location
19 departure track

typesToCheck: 6 7 10 17 18 19;

initialMyTicket[typesToCheck]
223*67*173*227*229*157












