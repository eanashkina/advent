initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input5_2.txt);
seeds: exec first x from initialTable;

initialTable: 2_initialTable;
initialTable: update isGroup: {?[x like "*:*";`$x;`]} each x from initialTable;
initialTable: update fills isGroup from initialTable;

seedToSoil: -1_1_select from initialTable where isGroup=`$"seed-to-soil map:";
soilToFertilizer: -1_1_select from initialTable where isGroup=`$"soil-to-fertilizer map:";
fertilizerToWater: -1_1_select from initialTable where isGroup=`$"fertilizer-to-water map:";
waterToLight: -1_1_select from initialTable where isGroup=`$"water-to-light map:";
lightToTemperature: -1_1_select from initialTable where isGroup=`$"light-to-temperature map:";
temperatureToHumidity: -1_1_select from initialTable where isGroup=`$"temperature-to-humidity map:";
humidityToLocation: -1_1_select from initialTable where isGroup=`$"humidity-to-location map:";

//exec distinct isGroup from initialTable

processOneLine:{[seedsTarget;targetTable]
    line: select x from targetTable;
    line: update {"F"$(" " vs x)} each x from line;
    line: update destRange: x[;0], sourceRange: x[;1], length: "j"$x[;2] from line;
    line: update sourceRangeEnd: sourceRange+length-1 from line;
    line: update seedsTarget: (count line)#enlist seedsTarget from line;
    line: update seedsToUpdate: {[x;y;z] z where z within (x;y)}'[sourceRange;sourceRangeEnd;seedsTarget] from line;
    seedsToStay: seedsTarget except raze exec seedsToUpdate from line;
    transformation: ungroup select destRange, sourceRange, seedsToUpdate from line;
    transformation: update diff: destRange-sourceRange from transformation;
    transformation: update newSeeds: seedsToUpdate+diff from transformation;
    seedsToChange: exec newSeeds from transformation;
    :seedsToStay,seedsToChange
    };

seedsInt: ("F"$" " vs seeds) except 0n;
pairs: ([] x: 2 cut seedsInt);
pairs: select start: x[;0], range: "j"$x[;1] from pairs;
'"Running the next line will cause wsfull"

raze exec {x+til y}'[start;range] from 1#pairs


seedsInt: raze exec {x+til y}'[start;range] from pairs;

seedToSoilNum: processOneLine[seedsInt;seedToSoil];
soilToFertilizerNum: processOneLine[seedToSoilNum;soilToFertilizer];
fertilizerToWaterNum: processOneLine[soilToFertilizerNum;fertilizerToWater];
waterToLightNum: processOneLine[fertilizerToWaterNum;waterToLight];
lightToTemperatureNum: processOneLine[waterToLightNum;lightToTemperature];
temperatureToHumidityNum: processOneLine[lightToTemperatureNum;temperatureToHumidity];
humidityToLocationNum: processOneLine[temperatureToHumidityNum;humidityToLocation];
//min humidityToLocationNum // 324724204