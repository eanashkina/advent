initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input5_1.txt);
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
humidityToLocation: 1_select from initialTable where isGroup=`$"humidity-to-location map:";

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
seedToSoilNum: processOneLine[seedsInt;seedToSoil];
soilToFertilizerNum: processOneLine[seedToSoilNum;soilToFertilizer];
fertilizerToWaterNum: processOneLine[soilToFertilizerNum;fertilizerToWater];
waterToLightNum: processOneLine[fertilizerToWaterNum;waterToLight];
lightToTemperatureNum: processOneLine[waterToLightNum;lightToTemperature];
temperatureToHumidityNum: processOneLine[lightToTemperatureNum;temperatureToHumidity];
humidityToLocationNum: processOneLine[temperatureToHumidityNum;humidityToLocation];
//min humidityToLocationNum // 324724204

// Part 2
processOneTable:{[targetTable]
    line: select x from targetTable;
    line: update {"F"$(" " vs x)} each x from line;
    line: update destRange: x[;0], sourceRange: x[;1], length: "j"$x[;2] from line;
    line: update destRangeEnd: destRange+length-1 from line;
    line: update diff: destRange-sourceRange from line;
    line: update sourceRangeEnd: sourceRange+length-1 from line;
    // transformation: update newSeeds: seedsToUpdate+diff from transformation;
    :line
    };
seedToSoilNew: processOneTable seedToSoil;
map: (`s#0 50 97 99 100)!(0 2 2 48 0)
tab: ([] x: 50 97 98 100; y: 2 0 48 0);
) aj tab
aj[`x;([] x:1 49 50 51 96 97 98 99 100 101);tab]
soilToFertilizerNew: processOneTable soilToFertilizer;
fertilizerToWaterNew: processOneTable fertilizerToWater;
waterToLightNew: processOneTable waterToLight;
lightToTemperatureNew: processOneTable lightToTemperature;
temperatureToHumidityNew: processOneTable temperatureToHumidity;
humidityToLocationNew: processOneTable humidityToLocation;

combined: seedToSoilNew,soilToFertilizerNew,fertilizerToWaterNew,waterToLightNew,
    lightToTemperatureNew,temperatureToHumidityNew,humidityToLocationNew;



pairs: ([] x: 2 cut seedsInt);
pairs: select start: x[;0], range: "j"$x[;1] from pairs;
'"Running the next line will cause wsfull"

raze exec {x+til y}'[start;range] from 1#pairs


seedsInt: raze exec {x+til y}'[start;range] from pairs;