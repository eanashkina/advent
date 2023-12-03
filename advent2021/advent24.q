system "c 300 300";
//initialTable: ([] line: read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input24_1.txt);
//initialTable: update parsed: (" " vs ) each line from initialTable;
//initialTable: update operation: `$parsed[;0], firstElement: `$parsed[;1],  secondElementAll: `$parsed[;2] from initialTable;
//
//// That should be possible to do with functional update, but I'm too lazy now.
//
//secondElementNum: "F"$parsed[;2],


//test: 14?1+til 8;
//test: 7 2 3 2 1 1 6 7 2 3 8 4 5 5j;
// 72,321,167,238,455
nums: string 99999999000000 + til 1000000;
// testOneNumber each nums where not nums like "*0*"
// 11.3 sec for 0.5 million
// 1e8*1e6
// (12*1e8)%3600

test: "72321167238455";
w: "J"$test[0];


table: ([] z1: 182 208 234 260 286 312 338 364 390j) cross ([] y1: 3 4 5 6 7 8 9 10 11j);
table: update z1New: z1+y1 from table;


w: "J"$test[0];
x: z;
x: x mod 26;
div z 1
add x 12
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 6
y: y*x;
z: z+y;

w: "J"$test[1];
x: z;
x: x mod 26;
div z 1
add x 10
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 2
y: y*x;
z: z+y;

w: "J"$test[2];
x: z;
x: x mod 26;
div z 1
add x 10
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 13
y: y*x;
z: z+y;

w: "J"$test[3];
x: z;
x: x mod 26;
z: z div 26;
add x -6
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 8
y: y*x;
z: z+y;

w: "J"$test[4];
x: z;
x: x mod 26;
div z 1
add x 11
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 13
y: y*x;
z: z+y;

w: "J"$test[5];
x: z;
x: x mod 26;
z: z div 26;
add x -12
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 8
y: y*x;
z: z+y;

w: "J"$test[6];
x: z;
x: x mod 26;
div z 1
add x 11
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 3
y: y*x;
z: z+y;

w: "J"$test[7];
x: z;
x: x mod 26;
div z 1
add x 12
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 11
y: y*x;
z: z+y;

w: "J"$test[8];
x: z;
x: x mod 26;
div z 1
add x 12
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 10
y: y*x;
z: z+y;

w: "J"$test[9];
x: z;
x: x mod 26;
z: z div 26;
add x -2
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 8
y: y*x;
z: z+y;

w: "J"$test[10];
x: z;
x: x mod 26;
z: z div 26;
add x -5
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 14
y: y*x;
z: z+y;

w: "J"$test[11];
x: z;
x: x mod 26;
z: z div 26;
add x -4
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 6
y: y*x;
z: z+y;

w: "J"$test[12];
x: z;
x: x mod 26;
z: z div 26;
add x -4
x: x=w;
x: x=0;
y: 0;
add y 25
y: y*x;
add y 1
z: z*y;
y: w;
add y 8
y: y*x;
z: z+y;

w: "J"$test[13];
x: z;
x: x mod 26; // w+12 = z mod 26
z: z div 26; // z should be less than 26
add x -12 // x should be w+12
x: x=w; // x should be equal to w
x: x=0; // x: 1=0
//y: 0;
//add y 25
y: y*x; // y=0
add y 1 // y=1
z: z*y; // z=z, but z should be 0
//y: w;
//add y 2
y: y*x; // x should be 0
z: z+y; // z and y should be 0

