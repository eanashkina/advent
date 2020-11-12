tableFromFile: `orbit xcol ([] read0 `:D:/Coding/advent2019/input6.txt);
// tableFromFile: `orbit xcol ([] ("COM)B";"B)C";"C)D";"D)E";"E)F";"B)G";"G)H";"D)I";"E)J";"J)K";"K)L"));

// tableFromFile: `orbit xcol ([] ("COM)B";"B)C";"C)D";"D)E"));
tableFromFile: update orbitParsed: `$")" vs 'orbit from tableFromFile;
tableFromFile: update planet: first each orbitParsed, satellite: last each orbitParsed from tableFromFile;

noSatellites: (exec distinct satellite from tableFromFile) except (exec distinct planet from tableFromFile);

findWayToCentre:{[targetSatellite;tableFromFile]
    targetPlanet: first exec planet from tableFromFile where satellite=targetSatellite;
    listOfPlanets: targetSatellite;
    while[not targetPlanet=`COM;
        targetSatellite: targetPlanet;
        listOfPlanets: listOfPlanets,targetSatellite;
        targetPlanet: first exec planet from tableFromFile where satellite=targetSatellite;
        show targetSatellite;
        ];
    listOfPlanets: listOfPlanets,`COM;
    res: ([] listOfPlanets);
    res: update countNum: (count listOfPlanets)-(i+1) from res;
    :res
    };

resTotal: raze findWayToCentre[;tableFromFile] each noSatellites;
resTotalDistinct: select sum countNum from distinct resTotal;

fromYou: findWayToCentre[`YOU;tableFromFile];
fromSan: findWayToCentre[`SAN;tableFromFile];

fromYouSan: select count i, first countNum by listOfPlanets from fromYou,fromSan;

divergePlanet: exec last listOfPlanets from 0!`countNum xasc select from fromYouSan where x=2;
fromDiv: findWayToCentre[divergePlanet;tableFromFile];

SAN	172j
YOU	256j

JZW	64j

(171+255)-(64*2) //300 - too high