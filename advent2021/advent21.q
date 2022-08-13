system "c 300 300";
//Player 1 starting position: 6
//Player 2 starting position: 3
positions: 1+til 10;

posOne: 6;
posTwo: 3;

dice: 1+til 100;
numTurn: 1;

scoreOne: 0;
scoreTwo: 0;
dicePos: 0;

//166*6
//while[(scoreOne<1000) and (scoreTwo<1000);
while[numTurn<168;
    show numTurn;
    show "dicePos: ",string dicePos;
    dicePosOne: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosTwo: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosThree: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosFour: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosFive: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosSix: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    stepsOne: dicePosOne+dicePosTwo+dicePosThree;
    stepsTwo: dicePosFour+dicePosFive+dicePosSix;
    newPosOne: "J"$last string (posOne+stepsOne);
    newPosTwo: "J"$last string (posTwo+stepsTwo);
    if[newPosOne=0;newPosOne: 10];
    if[newPosTwo=0;newPosTwo: 10];
    // "J"$last string (posOne+dicePosOne)
    scoreOne: scoreOne+newPosOne;
    scoreTwo: scoreTwo+newPosTwo;

    posOne: newPosOne;
    posTwo: newPosTwo;

    show "newPosOne: ",string newPosOne;
    show "newPosTwo: ",string newPosTwo;
    numTurn: numTurn+1;
    ];

990%6
(168*6)-3
scoreOne
743*(3+167*6) // 757512j too high // 746715 // too low
745
(scoreTwo-newPosTwo)*999 // not right 748251
749*999 // not right 748251
749*1005 // 752745



system "c 300 300";
//Player 1 starting position: 6
//Player 2 starting position: 3
positions: 1+til 10;

posOne: 6;
posTwo: 3;

dice: 1+til 100;
numTurn: 1;

scoreOne: 0;
scoreTwo: 0;
dicePos: 0;

///////////////////////////////////////////////////////////////////////////
while[(scoreOne<21) and (scoreTwo<21);
    show numTurn;
    show "dicePos: ",string dicePos;
    dicePosOne: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosTwo: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosThree: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosFour: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosFive: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    dicePosSix: dice[dicePos];
    dicePos: dicePos+1;
    if[dicePos=100;dicePos: 0];
    stepsOne: dicePosOne+dicePosTwo+dicePosThree;
    stepsTwo: dicePosFour+dicePosFive+dicePosSix;
    newPosOne: "J"$last string (posOne+stepsOne);
    newPosTwo: "J"$last string (posTwo+stepsTwo);
    if[newPosOne=0;newPosOne: 10];
    if[newPosTwo=0;newPosTwo: 10];
    // "J"$last string (posOne+dicePosOne)
    scoreOne: scoreOne+newPosOne;
    scoreTwo: scoreTwo+newPosTwo;

    posOne: newPosOne;
    posTwo: newPosTwo;

    show "newPosOne: ",string newPosOne;
    show "newPosTwo: ",string newPosTwo;
    numTurn: numTurn+1;
    ];
