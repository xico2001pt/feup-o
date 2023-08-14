/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Francisco Cerqueira
 * Creation Date: 18/02/2023 at 10:32:24
 *********************************************/
// Declare data

{string} Products = ...;  // Products

float profit[Products] = ...;
float machining[Products] = ...;
float sanding[Products] = ...;
float assembly[Products] = ...;

float timeMachining = ...;
float timeSanding = ...;
float timeAssembly = ...;

// Decision variables
dvar int+ x[Products];

maximize sum(i in Products) profit[i] * x[i];

subject to {
  sum (i in Products) machining[i] * x[i] <= timeMachining;
  sum (i in Products) sanding[i] * x[i] <= timeSanding;
  sum (i in Products) assembly[i] * x[i] <= timeAssembly;
  
  x["chair"] - 4 * x["table"] == 0;
}

execute OUTPUT_RESULTS {
  var file = new IloOplOutputFile ("solutionTablesChairsProblem.txt", true)
  file.writeln ("Objective Function = ", cplex.getObjValue());
  for (var i in Products)
  	file.writeln ("Variable x[", i, "] = ", x[i]);
}
