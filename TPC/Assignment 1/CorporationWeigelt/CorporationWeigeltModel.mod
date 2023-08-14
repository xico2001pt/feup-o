/*********************************************
 * OPL 22.1.1.0 Model
 * Author: Francisco Cerqueira
 * Creation Date: 18/02/2023 at 12:06:13
 *********************************************/

{string} Factories = ...;  // Factories
{string} Prod_Sizes = ...;  // Product Sizes
 
float Profit[Prod_Sizes] = ...;
float SalesForecast[Prod_Sizes] = ...;
float SpaceRequired[Prod_Sizes] = ...;
float SpaceAvailable[Factories] = ...;
float ProdCapacity[Factories] = ...;
 
// Decision variables
 
dvar float+ x[Factories][Prod_Sizes];
 
maximize sum(j in Prod_Sizes) sum(i in Factories) Profit[j] * x[i][j];

subject to {
  // Production Capacity
  forall (i in Factories)
	sum (j in Prod_Sizes) x[i][j] <= ProdCapacity[i];
	
  // Storage Capacity
  forall (i in Factories)
    sum (j in Prod_Sizes) SpaceRequired[j] * x[i][j] <= SpaceAvailable[i];
  
  // Sales
  forall (j in Prod_Sizes)
    sum (i in Factories) x[i][j] <= SalesForecast[j];
  
  // Same production percentage
  forall (i in Factories)
    forall(j in Factories)
      if (i != j)  // If different factories
        // Check if the percentage of products is the same for both factories
      	(sum (k in Prod_Sizes) x[i][k]) / ProdCapacity[i] == (sum (k in Prod_Sizes) x[j][k]) / ProdCapacity[j];
}
