listOfNames: ("zero";"one";"two";"three") ; / /;"four";"five";"six";"seven";"eight";"nine");
tableOfNames: ([] name: listOfNames; num: til count listOfNames);
targetStrBegin: 10?listOfNames;
targetStrInitial: raze targetStrBegin;
targetStr: 0N?targetStrInitial;

// "zero";
// targetStr where not places

// count targetStr

targetNum: "zero";

finalList: ();

findAndRemove:{[targetStrNew;targetLetter]
    show targetLetter;
    targetStrNew: targetStrNew _ (targetStrNew?targetLetter);
    :targetStrNew
    };


{x+x} 2

removeOneNum:{[targetStr;targetNum;tableOfNames]
    show "NEW LOOP";
    targetStrNew: targetStr;
    targetStrNew: targetStrNew {:x _ (x?y)}/ targetNum;
    show targetStr;
    show targetStrNew;
    show targetNum;
    show (count targetStr)-(count targetStrNew);
    show (count targetNum);
    $[((count targetStr)-(count targetStrNew))=(count targetNum);
        [
            show targetStrNew;
            targetNumber: exec num from tableOfNames where name like targetNum;
            finalList,::targetNumber;
            :targetStrNew;
            ];
        :targetStr
        ];
    };


while[0<count targetStr
    targetStr: targetStr removeOneNum[;;tableOfNames]/  listOfNames;
    ]





// will not work for three and seven!
findOneNum:{[targetNum;targetStr]
    places: ();
    iteration: 0;
    show targetNum;
    while[(((count distinct places)=(count targetNum)) and (all places<(count targetStr))) or (iteration=0);
        show iteration;
        places: targetStr?targetNum;
        show places;
        show targetStr;
        if[((count distinct places)=(count targetNum)) and (all places<(count targetStr));
            targetStr:: targetStr _/  places;
            show targetStr;
            finalList,::targetNum; // can be dictionary
            ];
        iteration: iteration+1;
        ];

    :targetStr

    };


res: findOneNum[;targetStr] each listOfNames;