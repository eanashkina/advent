system "c 300 300";

initialTableData: ([] read0 `:C:/Users/anash/Desktop/advent/advent2020/inputDay16_data.txt);
initialMyTicket: ([] read0 `:C:/Users/anash/Desktop/advent/advent2020/inputDay16_my_ticket.txt);
initialNearbyTickets: ([] read0 `:C:/Users/anash/Desktop/advent/advent2020/inputDay16_nearby_tickets.txt);

// Part 1
initialTableData: ([] ("class: 1-3 or 5-7";"row: 6-11 or 33-44";"seat: 13-40 or 45-50"));
initialNearbyTickets: ([] ("7,3,47";"40,4,50";"55,2,20";"38,6,12"));

// Add comma in the end of ticket lines to improve raze.

initialNearbyTickets: update {x,","} each x from initialNearbyTickets; // there is an adverb for that!
allNearbyNumbers: "F"$"," vs raze exec x from initialNearbyTickets;

parsedTableData: update firstParse: ":" vs x from initialTableData;
