-- Dataset: avocado_data (my own project), table: avocado_prices

-- 31. Add up the three bag sizes and compare with Total_Bags
-- The calculation Small_Bags + Large_Bags + XLarge_Bags is done for each row and saved as Total_Bags_Calc.
-- It matches Total_Bags, apart from tiny rounding differences. Returned 18,249 rows.
SELECT
 Date,
 Region,
 Small_Bags,
 Large_Bags,
 XLarge_Bags,
 Total_Bags,
 Small_Bags + Large_Bags + XLarge_Bags AS Total_Bags_Calc
FROM
 `project-cc781377-6842-4add-a3a.avocado_data.avocado_prices`;

-- 32. Percent of bags that are small, with no filter (returns an error)
-- (Small_Bags / Total_Bags) * 100 gives the percent of small bags.
-- Some rows have Total_Bags = 0, and dividing by 0 causes the error "division by zero".
SELECT
 Date,
 Region,
 Small_Bags,
 Total_Bags,
 (Small_Bags / Total_Bags) * 100 AS Small_Bags_Percent
FROM
 `project-cc781377-6842-4add-a3a.avocado_data.avocado_prices`;

-- 33. Percent of small bags, skipping rows with no bags
-- WHERE Total_Bags <> 0 removes the rows that would divide by 0. <> means "not equal to".
-- Returned 18,234 rows, so 15 rows were removed.
SELECT
 Date,
 Region,
 Small_Bags,
 Total_Bags,
 (Small_Bags / Total_Bags) * 100 AS Small_Bags_Percent
FROM
 `project-cc781377-6842-4add-a3a.avocado_data.avocado_prices`
WHERE
 Total_Bags <> 0;

-- 34. Same query, using != instead of <>
-- != also means "not equal to", so the result is the same. Returned 18,234 rows.
SELECT
 Date,
 Region,
 Small_Bags,
 Total_Bags,
 (Small_Bags / Total_Bags) * 100 AS Small_Bags_Percent
FROM
 `project-cc781377-6842-4add-a3a.avocado_data.avocado_prices`
WHERE
 Total_Bags != 0;
