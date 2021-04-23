CREATE DATABASE myHotel;

GO
USE myHotel;
CREATE TABLE Employees(
	EmployeeID int NOT NULL,
	JobID char(2) NOT NULL,
	HotelID varchar(3) NOT NULL,
	ELastName char(30) NOT NULL,
	EFirstName char(20) NOT NULL,
	HoursWorked int,
	PRIMARY KEY(EmployeeID),
);
GO
CREATE TABLE Zipcode(
	ZipID varchar(10) NOT NULL,
	City varchar(50) NOT NULL,
	StateID char(2) NOT NULL,
	PRIMARY KEY(ZipID)
);
GO
CREATE TABLE Guests(
	GuestID int NOT NULL,
	ZipID varchar(10) NOT NULL,
	GLastName varchar(30) NOT NULL, 
	GFirstName varchar(20) NOT NULL,
	PhoneNum varchar(15) NOT NULL,
	PRIMARY KEY(GuestID)
);
GO
CREATE TABLE Reservations(
	ResvID int NOT NULL,
	GuestID int NOT NULL,
	HotelID varchar(3) NOT NULL,
	ArrivalDate date,
	DepartureDate date,
	ResvRate money,
	PRIMARY KEY(ResvID)
);
GO
CREATE TABLE Hotels(
	HotelID varchar(3) NOT NULL,
	ZipID varchar(10) NOT NULL,
	HotelName varchar(50) NOT NULL,
	PRIMARY KEY(HotelID)
);
GO
CREATE TABLE Jobs(
	JobID char(2) NOT NULL,
	HourlyRate money NOT NULL,
	JobDescription varchar(200) NOT NULL,
	JobTitle varchar(50) NOT NULL,
	PRIMARY KEY(JobID)
);

