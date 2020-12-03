listFromFile: "J"$read0 `:D:/Coding/advent/advent2020/input1_1.txt;
tableFromFile:([] listFromFile);
crossedTable: tableFromFile cross (select listFromFile2: listFromFile from tableFromFile);
crossedTable: update summedCol: listFromFile+listFromFile2 from crossedTable;
exec distinct listFromFile*listFromFile2 from crossedTable where summedCol=2020 //802011

crossedTable: tableFromFile cross (select listFromFile2: listFromFile from tableFromFile) cross (select listFromFile3: listFromFile from tableFromFile);
crossedTable: update summedCol: listFromFile+listFromFile2+listFromFile3 from crossedTable;
exec distinct listFromFile*listFromFile2*listFromFile3 from crossedTable where summedCol=2020 //248607374j