system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input10_1.txt);
// Repeat several times. TODO: automate
initialTable: update ssr[;"[[][]]";""] each x from initialTable;
initialTable: update ssr[;"()";""] each x from initialTable;
initialTable: update ssr[;"<>";""] each x from initialTable;
initialTable: update ssr[;"{}";""] each x from initialTable;

initialTable: update points: 25137 from initialTable where any x like/: ("*(>*";"*{>*";"*[[]>*");
initialTable: update points: 1197 from initialTable where any x like/: ("*(}*";"*<}*";"*[[]}*");
initialTable: update points: 57 from initialTable where any x like/: ("*([]]*";"*<[]]*";"*{[]]*");
initialTable: update points: 3 from initialTable where any x like/: ("*<)*";"*{)*";"*[[])*");

//exec sum points from initialTable // 392421

incomplete: select from initialTable where null points;
incomplete: update "J"$string y from update ssr[;"<";"4"] each y from update ssr[;"{";"3"] each y from
    update ssr[;"[[]";"2"] each y from update ssr[;"(";"1"] each y from update y: reverse each x from incomplete;

//// !!! Adverb
//line: 2 1 3 4;
//
//res: 0;
//targetNum: 0;

sumLine:{[res;line;targetNum]
    show res;
    // show line;
    show targetNum;
    res: 5*res;
    res: res+line[targetNum];
    show res;
    :res
    };

//finalRes: res sumLine[;line;]/ til count line;

final: update total: {[line] res sumLine[;line;]/ til count line} each y from incomplete;
exec med total from final