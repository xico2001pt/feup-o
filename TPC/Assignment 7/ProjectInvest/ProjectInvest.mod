/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Francisco Cerqueira
 * Creation Date: 17/04/2023 at 11:40:21
 *********************************************/

 range N = 1..5;
 
 int costs[N] = ...;
 int utilities[N] = ...;
 
 dvar boolean x[N];
 
 maximize sum(i in N) utilities[i] * x[i];
 
 subject to {
   sum (i in N) costs[i] * x[i] <= 30;
   
   sum(i in 1..4) x[i] >= 2;
   
   x[1] - x[3] == 0;
   
   x[1] - x[5] <= 0;
}