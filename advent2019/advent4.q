table: ([] string 111111+til 888889);

table: update digit1: "F"$string raze {1#x} each x from table;
table: update digit2: "F"$string raze {1_2#x} each x from table;
table: update digit3: "F"$string raze {2_3#x} each x from table;
table: update digit4: "F"$string raze {3_4#x} each x from table;
table: update digit5: "F"$string raze {4_5#x} each x from table;
table: update digit6: "F"$string raze {5_6#x} each x from table;
table: update x: "F"$x from table;
table: select from table where x within (357253 892942);
table

smallTable: select from table where digit1<=digit2, digit2<=digit3, digit3<=digit4, digit4<=digit5, digit5<=digit6;

select from smallTable where ((digit1=digit2) and (not digit2=digit3))
    or ((digit2=digit3)and (not digit1=digit2) and (not (digit3=digit4)))
    or ((digit3=digit4)and (not digit2=digit3) and (not (digit4=digit5)))
    or ((digit4=digit5)and (not digit3=digit4) and (not (digit5=digit6)))
    or ((digit5=digit6)and (not digit4=digit5))