USE `car-dealership-database`;

SELECT v.*
FROM vehicles AS v JOIN inventory AS i
ON v.VIN = i.VIN
JOIN dealerships AS d
ON i.DealershipID = d.DealershipID
WHERE d.DealershipID = 1;