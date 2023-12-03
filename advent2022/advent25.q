system "c 300 300";
//\P 17
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input25_2.txt);

targetNum: 1;
parseOneNum:{[targetNum;initialTable]
    show targetNum;
    selected: first exec x from initialTable where i=targetNum;

    selectedTable: update number: ("J"$) x from update num: i from ([] x: reverse string selected);
    selectedTable: update number: -1 from selectedTable where x like "*-*";
    selectedTable: update number: -2 from selectedTable where x like "*=*";
    selectedTable: update powerFive: {5 xexp x} each num from selectedTable;
    show selectedTable;
//    :exec sum powerFive*number from selectedTable
    :update targetNum: targetNum from selectedTable
    };

decimal: raze parseOneNum[;initialTable] each exec i from initialTable;
update pentadecimal: (5 vs) each number from select sum number by num from decimal

0j	-5j
1j	21j
2j	-3j
3j	13j
4j	22j
5j	2j
6j	6j
7j	2j
8j	-10j
9j	-2j
10j	12j
11j	11j
12j	-16j
13j	7j
14j	17j
15j	-5j
16j	5j
17j	2j
18j	3j
19j	1j


0j	0
1j	0
2j	1
3j	=
4j	0
5j	2
6j	2
7j	=
8j	1
9j	1
10j	1
11j	=
12j	2
13j	-
14j	=
15j	-
16j	0
17j	=
18j	-
19j	2

([] reverse string "2-=0-=-2=111=220=100") // correct!

sumDecimal: sum decimal;
fives: {5 xexp x} each til 10;
max fives where fives<=sumDecimal