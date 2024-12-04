initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input8_1_2.txt);
instruction: raze initialTable[0];
instruction: ssr[instruction;"L";"0"];
instruction: ssr[instruction;"R";"1"];

instruction: "J"$string instruction;
table: 2_initialTable;
table: update (" = " vs) each x from table;
table: select pos: `$x[;0], options: x[;1] from table;
table: update ssr[;"(";""] each options from table;
table: update ssr[;")";""] each options from table;
table: update `$(", " vs) each options from table;

currentElement: `AAA;
//instr: 0
getInstruction:{[currentElement;table;instr]
    show currentElement;
    res: first exec options from table where pos=currentElement;
    :res[instr]
    };

x: 0;
y: 0;
while[currentElement<>`ZZZ;
    instr: instruction[x];
    currentElement: getInstruction[currentElement;table;instr];
    x: x+1;
    y: y+1;
    if[x=count[instruction];
        x: x-count[instruction]
        ];
    ];
y // 17287j


select options[;0] from table

