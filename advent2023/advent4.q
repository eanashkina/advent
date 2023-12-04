initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input4_2.txt);
initialTable: update x: (": " vs) each x from initialTable;
initialTable: update cardNum: x[;0], x: x[;1] from initialTable;
initialTable: update x: (" | " vs) each x from initialTable;

initialTable: select cardNum, winNum: x[;0], myNum: x[;1] from initialTable;
initialTable: update "F"$(" " vs) each winNum from initialTable;
initialTable: update "F"$(" " vs) each myNum from initialTable;
initialTable: update {x where not null x} each winNum from initialTable;
initialTable: update {x where not null x} each myNum from initialTable;

initialTable: update coincide: {count where x in y}'[myNum;winNum] from initialTable;

//sum 2 xexp neg[1]+(exec coincide from initialTable where coincide>0) // 33950

// Part 2

initialTable: update {"F"$ssr[x;"Card ";""]} each cardNum from initialTable;

cardCopied: select cardNum, cardQuantity: 1 from initialTable;
cardCopied: cardCopied lj `cardNum xkey select cardNum, coincide from initialTable;
cardCopied: update additionalNums: {x+1+til y}'[cardNum;coincide] from cardCopied;

allCards: exec cardNum from cardCopied;

updateTable:{[allCards;cardCopied;lineNum]
    show lineNum;
    show allCards;
    numCards: count allCards where allCards=(lineNum+1);
    extraCards: exec additionalNums from cardCopied where i=lineNum;
    allCards: raze allCards, numCards#extraCards;
    :allCards
    };

finalRes: allCards updateTable[;cardCopied;]/ exec i from cardCopied;
count finalRes
