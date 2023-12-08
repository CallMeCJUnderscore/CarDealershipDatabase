USE `car-dealership-database`;

SELECT s.*
FROM sales_contracts AS s JOIN inventory AS i
ON s.VIN = i.VIN
JOIN dealerships AS d
ON i.DealershipID = d.DealershipID 
WHERE (SaleDate BETWEEN "2020-11-11" AND "2024-01-01") AND (d.DealershipID = 1);