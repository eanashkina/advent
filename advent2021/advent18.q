system "c 300 300";
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2021/input18_0.txt);


decimals: 16 sv/: "0123456789ABCDEF"?/:/: string initialTable;
binaries:  ([] numbers: 2 vs/: decimals);
binaries: update countNum: 4-count each numbers from binaries;
binaries: update addition: {x#0}'[countNum] from binaries where countNum>0;
binaries: update {x,y}'[addition;numbers] from binaries;
binaries: raze exec numbers from binaries;
version: 0;

binaries: subPacket;
version: version+ 2 sv 3#binaries;
rest: 3_binaries;
packetTypeId: 2 sv 3#rest;
rest: 3_rest;

$[packetTypeId=4;
    [
        show "Literal";
        literal: 5 cut rest;
        firstNums: first where literal[;0]=0;
        number: 2 sv raze literal[til 1+firstNums;1+til 4];
        ];
    [
        show "Operator";
        lengthTypeId: first 1#rest;
        rest: 1_rest;
        $[lengthTypeId=0;
            [
                totalLength: 2 sv 15#rest;
                rest: 15_rest;
                subPacket: totalLength sublist rest;
                // TODO: parse subPacket
                1 0 1 1 0 0 0 1 0 0 1 1 1 1 1 0 0 0 1 0 1 1 0 1 0 1 0 0 0 0 1 0 0j
                1 1 0 0 1 0 0 0 0 1 1 1 0 1 1 1j
                rest: totalLength _ rest;
                ];
            [
                totalPackets: 2 sv 11#rest;
                rest: 11_rest;
                // First pack
                version: version+ 2 sv 3#rest;
                rest: 3_rest;
                packetTypeId: 2 sv 3#rest;
                rest: 3_rest;
                // Inside there are 2 packs
                    // First

                    // Second

                // TODO: Second pack
                version: version+ 2 sv 3#rest;
                rest: 3_rest;
                packetTypeId: 2 sv 3#rest;
                rest: 3_rest;

                ]
            ]
        ]
    ];


