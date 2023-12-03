system "c 300 300";
//\P 17
initialTable: (read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input12_1.txt);
line: where initialTable like "*S*";
num: where (first initialTable[line])="S";
start: (line,num);

line: where initialTable like "*E*";
num: where (first initialTable[line])="E";
end: (line,num);


// 450 too low