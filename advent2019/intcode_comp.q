runOneInstruction:{[input;tableFromFile] // works in 3.6, does not work in 3.5
    // Tasks 2_1, 2_2, 5_1, 7_1.
     show tableFromFile;
    countNum: 0;
    //input: 5; // 1 for task 5_1
    output: 0;
    while[tableFromFile[countNum]<>99;
        show countNum;
        instruction: string tableFromFile[countNum];
        while[5>count instruction; // update if >3 inputs of instructions
            instruction: "0",instruction
            ];
        opcode: -2 sublist instruction;
        modes: 3 sublist instruction; // 3=5-2
        firstMode: last modes;
        secondMode: last -1_ modes;
        thirdMode: last -2_modes;
        $[all (opcode="1") or (opcode="01") or (opcode="2") or (opcode="02");
            [
                valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                $[all (opcode="1") or (opcode="01");valueThird: valueFirst+valueSecond;valueThird: valueFirst*valueSecond];
                // $[thirdMode="0";tableFromFile[tableFromFile[countNum+3]]: valueThird;thirdMode="1";tableFromFile[tableFromFile[countNum+3]]: valueThird;show "Wrong mode"]
                tableFromFile[tableFromFile[countNum+3]]: valueThird;
                countNum: countNum+4
                ];
            (all (opcode="3") or (opcode="03"));
                [
                    show "Input ", "," sv string input;
                    $[0<count input;
                        [
                            tableFromFile[tableFromFile[countNum+1]]: input[0];
                            input: 1_input;
                            ];
                        show "Waiting for input"
                        ];
                    countNum: countNum+2
                    ];
                (all (opcode="4") or (opcode="04"));
                    [
                        show "Output ",string output;
                        output: tableFromFile[tableFromFile[countNum+1]];
                        countNum: countNum+2
                        ];
                    (all (opcode="5") or (opcode="05"));
                        [
                            checkValue: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                            $[checkValue;
                                $[secondMode="0";countNum: tableFromFile[tableFromFile[countNum+2]];secondMode="1";countNum: tableFromFile[countNum+2];show "Wrong mode"];
                                countNum: countNum+3]
                            ];
                        (all (opcode="6") or (opcode="06"));
                            [
                                checkValue: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                                $[not checkValue;
                                    $[secondMode="0";countNum: tableFromFile[tableFromFile[countNum+2]];secondMode="1";countNum: tableFromFile[countNum+2];show "Wrong mode"];
                                    countNum: countNum+3]
                                ];
                            (all (opcode="7") or (opcode="07"));
                                [
                                    valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                                    valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                                    positionThird: tableFromFile[countNum+3]; // do I need to add mode?
                                    $[valueFirst<valueSecond;tableFromFile[positionThird]: 1;tableFromFile[positionThird]: 0];
                                    countNum: countNum+4
                                    ];
                                (all (opcode="8") or (opcode="08"));
                                    [
                                        valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                                        valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                                        positionThird: tableFromFile[countNum+3]; // do I need to add mode?
                                        $[valueFirst=valueSecond;tableFromFile[positionThird]: 1;tableFromFile[positionThird]: 0];
                                        countNum: countNum+4
                                        ];
                    show "Invalid input ",string  tableFromFile[countNum]
            ]; //all (opcode="1") or (opcode="01") or (opcode="2") or (opcode="02")
        // show tableFromFile;
        ]; //while
    countNum: countNum+1;
    :output // tableFromFile[0]
    };

runOneInstructionAmpl:{[input;tableFromFile;countNum] // works in 3.6, does not work in 3.5
    // Tasks 7_2.
     show tableFromFile;
    // countNum: 0;
    //input: 5; // 1 for task 5_1
    output: 0N;
    while[(tableFromFile[countNum]<>99) and (0<count input);
        show countNum;
        instruction: string tableFromFile[countNum];
        while[5>count instruction; // update if >3 inputs of instructions
            instruction: "0",instruction
            ];
        opcode: -2 sublist instruction;
        modes: 3 sublist instruction; // 3=5-2
        firstMode: last modes;
        secondMode: last -1_ modes;
        thirdMode: last -2_modes;
        $[all (opcode="1") or (opcode="01") or (opcode="2") or (opcode="02");
            [
                valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                $[all (opcode="1") or (opcode="01");valueThird: valueFirst+valueSecond;valueThird: valueFirst*valueSecond];
                // $[thirdMode="0";tableFromFile[tableFromFile[countNum+3]]: valueThird;thirdMode="1";tableFromFile[tableFromFile[countNum+3]]: valueThird;show "Wrong mode"]
                tableFromFile[tableFromFile[countNum+3]]: valueThird;
                countNum: countNum+4
                ];
            (all (opcode="3") or (opcode="03"));
                [
                    show "Input ", "," sv string input;
                    $[0<count input;
                        [
                            tableFromFile[tableFromFile[countNum+1]]: input[0];
                            input: 1_input;
                            countNum: countNum+2
                            ];
                        show "Waiting for input"
                        ];
                    ];
                (all (opcode="4") or (opcode="04"));
                    [
                        show "Output ",string output;
                        output: tableFromFile[tableFromFile[countNum+1]];
                        countNum: countNum+2
                        ];
                    (all (opcode="5") or (opcode="05"));
                        [
                            checkValue: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                            $[checkValue;
                                $[secondMode="0";countNum: tableFromFile[tableFromFile[countNum+2]];secondMode="1";countNum: tableFromFile[countNum+2];show "Wrong mode"];
                                countNum: countNum+3]
                            ];
                        (all (opcode="6") or (opcode="06"));
                            [
                                checkValue: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                                $[not checkValue;
                                    $[secondMode="0";countNum: tableFromFile[tableFromFile[countNum+2]];secondMode="1";countNum: tableFromFile[countNum+2];show "Wrong mode"];
                                    countNum: countNum+3]
                                ];
                            (all (opcode="7") or (opcode="07"));
                                [
                                    valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                                    valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                                    positionThird: tableFromFile[countNum+3]; // do I need to add mode?
                                    $[valueFirst<valueSecond;tableFromFile[positionThird]: 1;tableFromFile[positionThird]: 0];
                                    countNum: countNum+4
                                    ];
                                (all (opcode="8") or (opcode="08"));
                                    [
                                        valueFirst: $[firstMode="0";tableFromFile[tableFromFile[countNum+1]];firstMode="1";tableFromFile[countNum+1];show "Wrong mode"];
                                        valueSecond: $[secondMode="0";tableFromFile[tableFromFile[countNum+2]];secondMode="1";tableFromFile[countNum+2];show "Wrong mode"];
                                        positionThird: tableFromFile[countNum+3]; // do I need to add mode?
                                        $[valueFirst=valueSecond;tableFromFile[positionThird]: 1;tableFromFile[positionThird]: 0];
                                        countNum: countNum+4
                                        ];
                    show "Invalid input ",string  tableFromFile[countNum]
            ]; //all (opcode="1") or (opcode="01") or (opcode="2") or (opcode="02")
        show tableFromFile;
        ]; //while
    table: ([] enlist countNum;enlist output;tableFromFile[countNum]);
    countNum: countNum+1;
    :table
    };