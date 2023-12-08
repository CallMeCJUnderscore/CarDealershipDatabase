USE `car-dealership-database`;

SELECT d.*
FROM dealerships AS d JOIN inventory AS i
ON i.DealershipID = d.DealershipID
JOIN vehicles AS v
ON v.VIN = i.VIN
WHERE v.VehicleType = "Sedan";