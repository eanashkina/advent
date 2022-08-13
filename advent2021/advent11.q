system "c 300 300";
initialTable: ([] "J"$string raze read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input11_1.txt);
step: 10;

updateOneNormalLocation:{[res;step;targetLocation]
    stepValues: (step-1)+til 3;
    neighbours: asc raze ((targetLocation-1);(targetLocation+1);(targetLocation-stepValues);(targetLocation+stepValues));
    neighbours: neighbours where neighbours within (0;(-1+step*step));
    res: update x+1 from res where i in neighbours;
    :res
    };

updateOneCornerLocation:{[res;step;targetLocation]
    if[targetLocation in 10*til 10;
        // left side
        neighbours: asc raze ((targetLocation+1);(targetLocation-(step - til 2));(targetLocation+(step + til 2)));
        ];
    if[targetLocation in -1+10*1+til 10;
        // right side
        neighbours: asc raze ((targetLocation-1);(targetLocation-(step + til 2));(targetLocation+(step - til 2)));
        ];

    neighbours: neighbours where neighbours within (0;(-1+step*step));

    res: update x+1 from res where i in neighbours;
    :res
    };

res: initialTable+1;
targetStep: 0;
sumFlash: 0;
flashLocations: ();
//adressFlashes:{[res;targetStep]
while[(count flashLocations)<=99;
    show "Step: ",string targetStep+1;
    flashLocations: exec i from res where x>9;
    cornerCases: (neg 1)+asc (1+step*til step),(step*1+til step);
    cornerFlashes: flashLocations where flashLocations in cornerCases;
    normalFlashes: flashLocations where not flashLocations in cornerCases;
    // targetLocation: 2;

    finalRes: res updateOneNormalLocation[;step;]/ normalFlashes;
    finalRes: finalRes updateOneCornerLocation[;step;]/ cornerFlashes;
    finalRes: update x: 0 from finalRes where i in flashLocations;
    newFlashLocations: exec i from finalRes where x>9, not i in flashLocations;
    if[0<count newFlashLocations;
        while[0<count newFlashLocations;

            cornerFlashes: newFlashLocations where newFlashLocations in cornerCases;
            normalFlashes: newFlashLocations where not newFlashLocations in cornerCases;
            finalRes: finalRes updateOneNormalLocation[;step;]/ normalFlashes;
            finalRes: finalRes updateOneCornerLocation[;step;]/ cornerFlashes;
            flashLocations: flashLocations,newFlashLocations;
            finalRes: update x: 0 from finalRes where i in flashLocations;
            newFlashLocations: exec i from finalRes where x>9, not i in flashLocations;
            ];
        ];
    show flashLocations;

    res: finalRes;
    //([] 10 cut res)
    //([] 10 cut finalRes)
    res: res+1;
    targetStep: targetStep+1;
    sumFlash: sumFlash+count flashLocations;
    show sumFlash;
    //:([] num: enlist targetStep; count flashLocations)
    ];
// 1723
//