initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input5_1.txt);
initialTable: update start: parsed[;0], end: parsed[;1] from update parsed: (" -> " vs) each x from initialTable;
initialTable: update x1: "J"$ parsed[;0], y1: "J"$parsed[;1] from update parsed: ("," vs) each start from initialTable;
initialTable: update x2: "J"$ parsed[;0], y2: "J"$parsed[;1] from update parsed: ("," vs) each end from initialTable;
initialTable: delete parsed from initialTable;
getDiagonal: {x@'til count x};
//initialTable: select from initialTable where (x1=x2) or (y1=y2);

getCoordinates:{[row]
    // show row;
    x1: min row[`x1], row[`x2];
    x2: max row[`x1], row[`x2];
    y1: min row[`y1], row[`y2];
    y2: max row[`y1], row[`y2];
    $[((row[`x1]=row[`x2]) or (row[`y1]=row[`y2]));
        [
            coord: (x1+ (til 1+ (x2-x1))) cross (y1 + til (1+ (y2-y1)));
            ];
        [
            xCoord: x1+ (til 1+ (x2-x1));
            yCoord: y1 + til (1+ (y2-y1));
            if[row[`x1]>row[`x2]; xCoord: reverse (x1+ (til 1+ (x2-x1)))];
            if[row[`y1]>row[`y2]; yCoord: reverse (y1+ (til 1+ (y2-y1)))];
            coordFirst: xCoord cross yCoord;
            coord: getDiagonal ((1+y2-y1) cut coordFirst);
            ]
        ];
    // show x1, y1, x2, y2;
    :update coordinates: coord from row
    };

res: getCoordinates each initialTable;

select count i from (select countX: count i by x from ([] raze exec coordinates from res)) where countX>=2
// 5442
// 19571



