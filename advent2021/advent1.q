system "c 300 300";
initialTable: "F"$([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input1_1.txt);
select count i by isPositive:?[diff>0;1b;0b] from 1_update diff: deltas x from initialTable

select count i by isPositive:?[diff>0;1b;0b] from 1_update diff: deltas movSum from 2_update movSum: 3 msum x from initialTable

// 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input2_1.txt);
initialTable: update parsed: (" " vs) each x from initialTable;
initialTable: update direction: `$parsed[;0], number: "I"$parsed[;1] from initialTable;
horPosition: exec sum number from initialTable where direction=`forward; // 2083
initialTable: update sign: ?[direction=`down;1;-1] from initialTable;
depth: exec sum number*sign from initialTable where not direction=`forward; // 955
horPosition*depth