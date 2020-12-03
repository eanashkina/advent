initialTable: ([] read0 `:D:/Coding/advent/advent2020/input2_1.txt);
initialTable: update parsed: " " vs  'x from initialTable;
initialTable: update numOfLetters: parsed[;0], letter: parsed[;1], password: parsed[;2] from initialTable;
initialTable: update numOfLetters:  "-" vs 'numOfLetters, letter: `$ssr[;":";""] each letter from initialTable;
initialTable: update minNum: "J"$numOfLetters[;0], maxNum: "J"$numOfLetters[;1] from initialTable;

countLetters:{[row]
    passwordSelected: row[`password];
    letterSelected: row[`letter];
    countLetters: count ss[passwordSelected;string letterSelected];
    isValid: $[countLetters within (row[`minNum];row[`maxNum]);1b;0b];
    :update isValid from row
    };

finalRes: countLetters each initialTable;
exec count i from finalRes where isValid //458

checkPosition:{[row]
    passwordSelected: row[`password];
    letterSelected: row[`letter];
    positionOne: `$passwordSelected[row[`minNum]-1];
    positionTwo: `$passwordSelected[row[`maxNum]-1];
    isValid: $[(letterSelected=positionOne) or (letterSelected=positionTwo);1b;0b];
    if[(letterSelected=positionOne) and (letterSelected=positionTwo);isValid: 0b];
    :update isValid from row
    };

finalRes: checkPosition each initialTable;
exec count i from finalRes where isValid //342






