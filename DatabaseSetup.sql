# ---------------------------------------------------------------------- #
# Target DBMS:           MySQL                                           #
# Project name:          car-dealership-database                         #
# Author: Joshua Weinstein aka CallMeCJ_                                 #
# ---------------------------------------------------------------------- #

# ---------------------------------------------------------------------- #
# STEP 1                                                                 #
# Create Database    													 #
# ---------------------------------------------------------------------- #
DROP DATABASE IF EXISTS `car-dealership-database`;
CREATE DATABASE IF NOT EXISTS `car-dealership-database`;
USE `car-dealership-database`;


# ---------------------------------------------------------------------- #
# STEP 2																 #
# Create Database Tables												 #
# ---------------------------------------------------------------------- #
CREATE TABLE dealerships(
DealershipID INT AUTO_INCREMENT PRIMARY KEY,
DealershipName VARCHAR(50) NOT NULL,
DealershipAddress VARCHAR(50),
DealershipPhone CHAR(12),
CHECK (DealershipPhone REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$'));

CREATE TABLE vehicles(
VIN INT UNIQUE PRIMARY KEY,
YearOfManufacture INT NOT NULL,
Make VARCHAR(30) NOT NULL,
Model VARCHAR(30) NOT NULL,
Color VARCHAR(10) NOT NULL,
VehicleType ENUM("Sedan", "SUV", "Pickup Truck", "Station Wagon", "Hatchback", "Minivan", "Other") NOT NULL,
Odometer INT DEFAULT 0,
Price DOUBLE NOT NULL,
SoldStatus SMALLINT DEFAULT 0, -- 0=Unsold, 1=Sold via Sale, 2=Sold via Lease
CHECK (Color REGEXP '^[a-zA-Z]+$'));

CREATE TABLE inventory(
DealershipID INT NOT NULL,
VIN INT UNIQUE NOT NULL,
FOREIGN KEY(DealershipID) REFERENCES dealerships(DealershipID),
FOREIGN KEY(VIN) REFERENCES vehicles(VIN));

CREATE TABLE sales_contracts(
SaleID INT AUTO_INCREMENT,
SaleDate DATE DEFAULT(CURRENT_DATE),
CustomerName VARCHAR(40) NOT NULL,
CustomerContact VARCHAR(40) NOT NULL,
VIN INT UNIQUE NOT NULL,
PRIMARY KEY (SaleID),
FOREIGN KEY(VIN) REFERENCES vehicles(VIN));

CREATE TABLE lease_contracts(
LeaseID INT AUTO_INCREMENT,
SaleDate DATE DEFAULT(CURRENT_DATE),
CustomerName VARCHAR(40) NOT NULL,
CustomerContact VARCHAR(40) NOT NULL,
VIN INT UNIQUE NOT NULL,
PRIMARY KEY (LeaseID),
FOREIGN KEY(VIN) REFERENCES vehicles(VIN));


# ---------------------------------------------------------------------- #
# STEP 3                                                                 #
# Populate tables with sample data                    					 #
# ---------------------------------------------------------------------- #
INSERT INTO dealerships (DealershipName, DealershipAddress, DealershipPhone)
VALUES
("Car World", "123 Main St", "555-123-4567"),
("Speedy G's", "999 Some Rd", "999-999-9999"),
("Dave's Discount Drives", "5 Another Dr", "123-456-7890");

INSERT INTO vehicles (VIN, YearOfManufacture, Make, Model, VehicleType, Color, Odometer, Price)
VALUES
(12345, 2014, "Toyota", "Camry", "Sedan", "Silver", 12000, 15995),
(10567, 2018, "Honda", "Civic", "Sedan", "Black", 8000, 18995),
(10987, 2017, "Ford", "Escape", "SUV", "White", 25000, 20995),
(11000, 2018, "Chevrolet", "Malibu", "Sedan", "Red", 12000, 16995),
(11111, 2019, "Toyota", "RAV4", "SUV", "Blue", 10000, 27995);
UPDATE vehicles SET SoldStatus = 1
WHERE VIN = 10987;
UPDATE vehicles SET SoldStatus = 2
WHERE VIN = 11000;

INSERT INTO inventory
VALUES
(1, 12345),
(3, 10567),
(1, 10987),
(2, 11000),
(2, 11111);

INSERT INTO sales_contracts (VIN, CustomerName, CustomerContact)
VALUES (10987, "Dana Wyatt", "dana@texas.com");

INSERT INTO lease_contracts (VIN, CustomerName, CustomerContact)
VALUES (11000, "Zachary Westly", "zach@texas.com");