/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Francisco Cerqueira
 * Creation Date: 18/02/2023 at 11:08:22
 *********************************************/
// Declare data

{string} Products = ...;  // Products
{string} Sections = ...;  // Sections

float Profit[Products] = ...;
float TimePerSection[Sections][Products] = ...;

float AvailableTime[Sections] = ...;

// Decision variables

dvar float+ x[Products];

maximize sum(i in Products) Profit[i] * x[i];

subject to {
  forall (i in Sections)
    sum (j in Products) TimePerSection[i, j] * x[j] <= AvailableTime[i];
}

execute OUTPUT_RESULTS {
  var file = new IloOplOutputFile("solutionTablesChairsProblem.txt", true);
  file.writeln("Objective Function = ", cplex.getObjValue());
  for (var i in Products)
  	file.writeln("Variable x[", i, "] = ", x[i]);
}
