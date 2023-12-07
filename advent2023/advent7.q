initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input7_2.txt);
map: `A`K`Q`J`T`9`8`7`6`5`4`3`2!(reverse til 13);

initialTable: select cards: x[;0], num: "F"$x[;1] from update (" " vs) each x from initialTable;
initialTable: update grouped: {count each group x} each cards from initialTable;
initialTable: update amount: value each grouped from initialTable;

initialTable: update name: `7_five from initialTable where 5j in/:amount;
initialTable: update name: `6_four from initialTable where 4j in/:amount;
initialTable: update name: `5_fullHouse
    from (update isFullHouse: {all x in (2 3j)} each amount from initialTable)
    where isFullHouse;
initialTable: update name: `4_three from initialTable where null name, 3j in/:amount;
initialTable: update name: `3_twoPairs
    from (update isTwoPairs: {2=(count x where x=2j)} each amount from initialTable)
    where isTwoPairs;
initialTable: update name: `2_onePair from initialTable where null name, 2j in/:amount;
initialTable: update name: `1_high from initialTable where null name;

initialTable: update cardsSym: `$string cards from initialTable;
initialTable: update mapping: {map each x} each cardsSym from initialTable;

select sum (loc*num) from update loc: 1+i from `name`mapping xasc initialTable
//249748283f

// Part 2
initialTable: ([] read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input7_2.txt);
map: `A`K`Q`T`9`8`7`6`5`4`3`2`J!(reverse til 13);

initialTable: select cards: x[;0], num: "F"$x[;1] from update (" " vs) each x from initialTable;
initialTable: update grouped: {count each group x} each cards from initialTable;
initialTable: update amount: value each grouped from initialTable;
initialTable: update cardsSym: `$string cards from initialTable;
initialTable: update mapping: {map each x} each cardsSym from initialTable;
initialTable: update countJokers: {count x where x=`J} each cardsSym from initialTable;
initialTable: update isJoker: countJokers>0 from initialTable;
initialTable: update name: `7_five from initialTable where not isJoker, 5j in/:amount;
initialTable: update name: `6_four from initialTable where not isJoker, 4j in/:amount;
initialTable: update name: `5_fullHouse
    from (update isFullHouse: {all x in (2 3j)} each amount from initialTable)
    where not isJoker, isFullHouse;
initialTable: update name: `4_three from initialTable where not isJoker, null name, 3j in/:amount;
initialTable: update name: `3_twoPairs
    from (update isTwoPairs: {2=(count x where x=2j)} each amount from initialTable)
    where not isJoker, isTwoPairs;
initialTable: update name: `2_onePair from initialTable where not isJoker, null name, 2j in/:amount;
initialTable: update name: `1_high from initialTable where not isJoker, null name;

initialTable: update name: `7_five from initialTable where (countJokers=5) or (countJokers=4);
initialTable: update name: `7_five from initialTable where not isJoker, null name, 2j in/:amount;
initialTableNotJ: delete from initialTable where isJoker, countJokers in (1 2 3);
initialTableJ: select from initialTable where isJoker, countJokers in (1 2 3);

initialTableJ: update cardsNoJ: ssr[;"J";""] each cards from initialTableJ;
initialTableJ: update groupedNoJ: {count each group x} each cardsNoJ from initialTableJ;
initialTableJ: update amountNoJ: value each groupedNoJ from initialTableJ;
initialTableJ: update name: `7_five from initialTableJ
    where ((countJokers=1) and (4j in/:amountNoJ)) or ((countJokers=2) and (3j in/:amountNoJ))
        or ((countJokers=3) and (2j in/:amountNoJ));
initialTableJ: update name: `6_four from initialTableJ
    where ((countJokers=1) and (3j in/:amountNoJ)) or ((countJokers=2) and (2j in/:amountNoJ))
        or ((countJokers=3) and (1j in/:amountNoJ)) and null name;
// On this stage there are no more cards with 3 Jokers.
initialTableJ: update isTwoPairsNoJ: {2=(count x where x=2j)} each amountNoJ from initialTableJ;
initialTableJ: update name: `5_fullHouse from initialTableJ
    where (countJokers=1) and isTwoPairsNoJ;
initialTableJ: update name: `4_three
    from (update isSingle: {all x=1j} each amountNoJ from initialTableJ)
    where null name, isSingle, countJokers=2;
initialTableJ: update name: `4_three from initialTableJ where null name, countJokers=1, 2j in/:amount;
initialTableJ: update name: `2_onePair from initialTableJ where null name, countJokers=1;
initialTableJ: delete cardsNoJ, groupedNoJ, amountNoJ, isTwoPairsNoJ, isSingle from initialTableJ;

finalTable: initialTableNotJ,initialTableJ;


select sum (loc*num) from update loc: 1+i from `name`mapping xasc finalTable
// 248029057f