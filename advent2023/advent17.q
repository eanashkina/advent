initialTable: "F"$string each read0 `:C:/Users/anash/MyPC/Coding/advent/advent2023/input17_1.txt;
//([] initialTable)

bgn: til count raze initialTable;
end: bgn;
width: first count each initialTable;
length: count initialTable;

table:([] x: bgn) cross ([] y: end);
table: update absDiff: abs[x-y] from table;
table: update isNeighbour: (absDiff=1) or (absDiff=width) from table;
table: update isEndNewLine: 0=(y mod width) from table;
table: update isStartNewLine: 0=(x mod width) from table;
table: update isNeighbour: 0b from table where isNeighbour, (x-y)=1, isStartNewLine;
table: update isNeighbour: 0b from table where isNeighbour, (y-x)=1, isEndNewLine;
table: update isNeighbour: 1b from table where x=y;

//pivot:{[t]
//    u: `$string asc distinct last f:flip key t;
//    pf:{x#(`$string y)!z};
//    p:?[t;();g!g:-1_ k;(pf;`u;last k:key f;last key flip value t)];
//    p
//    };
//
dist: `src`dst`dist xcol (select x, y from table where isNeighbour) lj `y xkey update y: i from ([] values: raze initialTable);

cm:{[bgn;dist]
  nn:count bgn;                         / number of nodes
  res:(2#nn)#0w;  / default whole matrix to nopath
  ip:flip bgn?/:dist`src`dst;              / index pairs
  res:./[res;ip;:;`float$dist`dist];     / set reachable index pairs
  ./[res;til[nn],'til[nn];:;0f]       / zero on diagonal to exclude a node with itself
  };

bridge:{x & x('[min;+])\: x};
// IN the bridge you can add conditions about 3 blocks and direction
res: (bridge/) cm[bgn;dist;`inf];
([] res)

iters: (bridge\) cm[bgn;dist;`inf];
count iters
iters .\: bgn?(min[bgn];max[bgn])