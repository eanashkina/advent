system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input7_2.txt);

//select from initialTable where x like "*cd*"

initialTable: update isCd: 1b from initialTable where (x like "$ cd *") and (not x like "$ cd ..");
initialTable: update isLs: 1b from initialTable where x like "$ ls";
initialTable: update isDir: 1b from initialTable where x like "dir *";
initialTable: update parsedX: (" " vs) each x from initialTable;
initialTable: update size: "F"$first each parsedX from initialTable;
initialTable: update directory: ` from initialTable;
initialTable: update directory: `$parsedX[;2] from initialTable where isCd;
initialTable: update fills directory from initialTable;
initialTable: update insideDir: `$parsedX[;1] from initialTable where isDir;

selectedDirs: select from initialTable where not null insideDir;
// Find folders that are not mentioned in directory column - they have correct size
noIncludedDirs: (exec insideDir from selectedDirs) except (exec directory from selectedDirs);
//(count noIncludedDirs) - count distinct noIncludedDirs

initialTable: update noIncludedDir: 1b from initialTable where directory in noIncludedDirs;
initialTable: update groupInd: 1b from initialTable where not directory=prev directory;
initialTable: update sums groupInd from initialTable;

initialTable: update filledInsideDir: reverse fills reverse fills insideDir by groupInd from initialTable;
lastDirs: select sum size by groupInd, directory from initialTable where null filledInsideDir;

// at most 100,000
sumKnown: select sum size by groupInd from initialTable;
initialTable: update groupLeft: 1b from initialTable where groupInd in (exec groupInd from sumKnown where size<=100000);

initialTable: update levelIncrease: ?[x like "*cd *";1;0] from initialTable;
initialTable: update levelIncrease: -1 from initialTable where x like "*cd ..";
initialTable: update level: sums levelIncrease from initialTable;

tree: select first level by directory, groupInd from initialTable;
sumSize: select sum size by groupInd from initialTable;
tree: tree lj sumSize;
parent: exec level from tree;
name: exec groupInd from tree;
group parent
name parent scan 3



//1390824

//p:0N 0N 1 2 1 / parent
//n:`a`b`c`d`e  / name
//c:group p
//c   / children
//n p scan 3    / full path

shortInitialTable: delete from initialTable where groupInd in (exec groupInd from sumKnown where size>100000);



selectedSizes: select sum size by directory from initialTable where noIncludedDir; // these folders does not repeat

select from initialTable where directory in noIncludedDirs

initialTable: initialTable lj selectedSizes; //not sure it is correct

shortInitialTable: distinct select size, directory, insideDir, noIncludedDir from initialTable;



// Folders can have the same names, this logic will not work
dirSizes: select sum size by directory from initialTable;
dirSizes: update correctSize: 1b from dirSizes where directory in noIncludedDirs;
// Find which tables are inside other tables

selectedDirsFirstStep: select from selectedDirs where insideDir in noIncludedDirs;

// Folders can have the same names, join will not work

secondStepSizes: select newSize: sum size by directory from (selectedDirsFirstStep lj (`insideDir xkey select insideDir: directory, size from () xkey dirSizes));
// The size will be correct if this table is not mentioned in directory.
selectedDirsRest: select from selectedDirs where not insideDir in noIncludedDirs;
secondStepSizes: update correctSize: 1b from secondStepSizes where not directory in (exec directory from selectedDirsRest);

dirSizes: dirSizes lj secondStepSizes;
dirSizes: delete newSize from update size: size+newSize from dirSizes;

selectedDirsThirdStep: select from selectedDirs where directory in (exec directory from dirSizes where not correctSize);

thirdStepSizes: select from (select newSize: sum size, distinct correctSize by directory from
    (selectedDirsThirdStep lj  (`insideDir xkey select insideDir: directory, size, correctSize from () xkey dirSizes)))
        where (all each correctSize);
thirdStepSizes: update correctSize: 1b from thirdStepSizes;
dirSizes: dirSizes lj thirdStepSizes;
dirSizes: delete newSize from update size: size+newSize from dirSizes;

selectedDirsFourthStep: select from selectedDirs where directory in (exec directory from dirSizes where not correctSize);
fourthStepSizes: select from (select newSize: sum size, distinct correctSize by directory from
    (selectedDirsFourthStep lj  (`insideDir xkey select insideDir: directory, size, correctSize from () xkey dirSizes)))
        where (all each correctSize);
