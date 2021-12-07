system "c 300 300";
initialTable: "4,1,1,4,1,2,1,4,1,3,4,4,1,5,5,1,3,1,1,1,4,4,3,1,5,3,1,2,5,1,1,5,1,1,4,1,1,1,1,2,1,5,3,4,4,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,5,1,1,1,4,1,2,3,5,1,2,2,4,1,4,4,4,1,2,5,1,2,1,1,1,1,1,1,4,1,1,4,3,4,2,1,3,1,1,1,3,5,5,4,3,4,1,5,1,1,1,2,2,1,3,1,2,4,1,1,3,3,1,3,3,1,1,3,1,5,1,1,3,1,1,1,5,4,1,1,1,1,4,1,1,3,5,4,3,1,1,5,4,1,1,2,5,4,2,1,4,1,1,1,1,3,1,1,1,1,4,1,1,1,1,2,4,1,1,1,1,3,1,1,5,1,1,1,1,1,1,4,2,1,3,1,1,1,2,4,2,3,1,4,1,2,1,4,2,1,4,4,1,5,1,1,4,4,1,2,2,1,1,1,1,1,1,1,1,1,1,1,4,5,4,1,3,1,3,1,1,1,5,3,5,5,2,2,1,4,1,4,2,1,4,1,2,1,1,2,1,1,5,4,2,1,1,1,2,4,1,1,1,1,2,1,1,5,1,1,2,2,5,1,1,1,1,1,2,4,2,3,1,2,1,5,4,5,1,4";
 initialTable: "3,4,3,1,2";
// initialTable: "J"$"," vs initialTable;

// TODO: count number of fish by group, group defined by day
countNum: 0;
while[countNum<80; //256;
    initialTable: "J"$"," vs initialTable;
    initialTable: initialTable-1;
    countNum: countNum+1;
    initialTable: "," sv string initialTable;
    initialTable: ssr[initialTable;"-1";"6,8"];
    show "After ",string[countNum]," days";
    // show initialTable;
    ];

res: "J"$"," vs initialTable;
count res // 376194

// part 2
initialTable: "J"$"," vs initialTable;
groupedData: count each group initialTable;
table: 0^([] zeroD: enlist groupedData[0]; oneD: groupedData[1]; twoD: enlist groupedData[2]; threeD: groupedData[3];
    fourD: enlist groupedData[4]; fiveD: groupedData[5]; sixD: enlist groupedData[6]; sevenD: groupedData[7];
    eightD: enlist groupedData[8]);

countNum: 0;
isBorn: 0;
while[countNum<256; //80;


    countNum: countNum+1;

    prevZero: first exec zeroD from table;
    if[0<prevZero; isBorn: prevZero];
    table: update zeroD: oneD from table;
    table: update oneD: twoD from table;
    table: update twoD: threeD from table;
    table: update threeD: fourD from table;
    table: update fourD: fiveD from table;
    table: update fiveD: sixD from table;
    table: update sixD: ?[isBorn>0;sevenD+prevZero;sevenD] from table;
    table: update sevenD: eightD from table;
    table: update eightD: prevZero from table;
    show "After ",string[countNum]," days";
    show table;


    ];

sum raze exec from table

