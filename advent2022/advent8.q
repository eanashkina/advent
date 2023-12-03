system "c 300 300";
initialTable: (read0 `:C:/Users/anash/MyPC/Coding/advent/advent2022/input8_2.txt);
//initialTable[0;1] // row;column
countRows: count initialTable;
countColumns: first count each initialTable;

combinations: (til countRows) cross (til countColumns);

targetComb: combinations[7];

checkCombination:{[targetComb;initialTable;countRows;countColumns]
    show targetComb;
    targetTree: "F"$initialTable[first targetComb;last targetComb];
    verticalTrees: (((til countRows) cross last targetComb));
    horizontalTrees: (first targetComb) cross (til countColumns);

    verticalTreesSelected: "F"$string {initialTable[x;y]}'[first each verticalTrees;last each verticalTrees];
    verticalTreesBefore: reverse verticalTreesSelected[til first targetComb];
    verticalTreesBeforeStop: first where verticalTreesBefore>=targetTree;
    //    verticalTreesBeforeCount: where verticalTreesBefore<targetTree;
    // verticalTreesBeforeCountFinal: count (first verticalTreesBeforeCount), verticalTreesBeforeCount where 1=verticalTreesBeforeCount-(prev verticalTreesBeforeCount);
    verticalTreesBeforeCountFinal: $[not null verticalTreesBeforeStop;count til (1+verticalTreesBeforeStop);count verticalTreesBefore];
    // if[0=count verticalTreesBeforeCount;verticalTreesBeforeCountFinal: 0];

    verticalTreesAfter: verticalTreesSelected[(til countRows) except (til 1+first targetComb)];
    verticalTreesAfterStop: first where verticalTreesAfter>=targetTree;
    //    verticalTreesAfterCountFinal: count (first verticalTreesAfterCount), verticalTreesAfterCount where 1=verticalTreesAfterCount-(prev verticalTreesAfterCount);
    verticalTreesAfterCountFinal: $[not null verticalTreesAfterStop;count til (1+verticalTreesAfterStop);count verticalTreesAfter];
    // if[0=count verticalTreesAfterCount;verticalTreesAfterCountFinal: 0];

    // verticalVisibilityBefore: not count verticalTreesBefore where verticalTreesBefore>=targetTree;
    // verticalVisibilityAfter: not count verticalTreesAfter where verticalTreesAfter>=targetTree;
    // visibilityVertical: any verticalVisibilityBefore,verticalVisibilityAfter;

    horizontalTreesSelected: "F"$string {initialTable[x;y]}'[first each horizontalTrees;last each horizontalTrees];
    horizontalTreesBefore: reverse horizontalTreesSelected[til last targetComb];
    horizontalTreesBeforeStop: first where horizontalTreesBefore>=targetTree;
    horizontalTreesBeforeCountFinal: $[not null horizontalTreesBeforeStop;count til (1+horizontalTreesBeforeStop);count horizontalTreesBefore];

    //    horizontalTreesBeforeCount: where horizontalTreesBefore<targetTree;
    //    horizontalTreesBeforeCountFinal: count (first horizontalTreesBeforeCount), horizontalTreesBeforeCount where 1=horizontalTreesBeforeCount-(prev horizontalTreesBeforeCount);
    //    if[0=count horizontalTreesBeforeCount;horizontalTreesBeforeCountFinal: 0];

    horizontalTreesAfter: horizontalTreesSelected[(til countColumns) except (til 1+last targetComb)];
    horizontalTreesAfterStop: first where horizontalTreesAfter>=targetTree;
    horizontalTreesAfterCountFinal: $[not null horizontalTreesAfterStop;count til (1+horizontalTreesAfterStop);count horizontalTreesAfter];
    //    horizontalTreesAfterCount: where horizontalTreesAfter<targetTree;
    //    horizontalTreesAfterCountFinal: count (first horizontalTreesAfterCount), horizontalTreesAfterCount where 1=horizontalTreesAfterCount-(prev horizontalTreesAfterCount);
    //    if[0=count horizontalTreesAfterCount;horizontalTreesAfterCountFinal: 0];

    // horizontalVisibilityBefore: not count horizontalTreesBefore where horizontalTreesBefore>=targetTree;
    // horizontalVisibilityAfter: not count horizontalTreesAfter where horizontalTreesAfter>=targetTree;
    // visibilityHorizontal: any horizontalVisibilityBefore,horizontalVisibilityAfter;



    // countVisibilityHorizontal: count horizontalTreesSelected where horizontalTreesSelected<targetTree;
    //    topTrees: (til first targetComb) cross last targetComb;
    //    lowTrees: ((-1+countRows)-til (1+countRows-first targetComb)) cross last targetComb;
    //    leftTrees: (first targetComb) cross (til last targetComb);
    //    rightTrees: (first targetComb) cross ((-1+countColumns)-til (1+countColumns-last targetComb));
    //    if[(first targetComb=0) or (first targetComb)=(-1+countRows); visibilityVertical: 1b];
    //    if[(last targetComb=0) or (last targetComb)=(-1+countColumns); visibilityHorizontal: 1b];
    //    :([] enlist targetComb;visibilityVertical;visibilityHorizontal)
    :([] enlist targetComb;res: verticalTreesBeforeCountFinal*verticalTreesAfterCountFinal*horizontalTreesBeforeCountFinal*horizontalTreesAfterCountFinal)
    };

resFinal: raze checkCombination[;initialTable;countRows;countColumns] each combinations;
exec max res from resFinal
268800
select from res where (visibilityVertical) or (visibilityHorizontal)
1736
