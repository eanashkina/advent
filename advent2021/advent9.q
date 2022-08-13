system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input9_1.txt);
rows: til count initialTable;
columns: til count exec first x from initialTable;
coords: rows cross columns;

row: first coords;
checkOneNum:{[row;initialTable]
    show row;
    line: row[0];
    column: row[1];
    valueTarget: "J"$(first exec x from initialTable where i=line)[column];
    neighbour1: "J"$(first exec x from initialTable where i=line)[column-1];
    neighbour2: "J"$(first exec x from initialTable where i=line)[column+1];
    neighbour3: "J"$(first exec x from initialTable where i=(line-1))[column];
    if[0=count neighbour3;neighbour3: 0Nj];
    neighbour4: "J"$(first exec x from initialTable where i=(line+1))[column];
    if[0=count neighbour4;neighbour4: 0Nj];
    listNeighbours: (neighbour1;neighbour2;neighbour3;neighbour4);
    listNeighbours: listNeighbours where not null listNeighbours;
    if
    $[all valueTarget<listNeighbours;
        :valueTarget;
        :0Nj]


    };



res: checkOneNum[;initialTable] each coords;
sum 1+ res where not null res



