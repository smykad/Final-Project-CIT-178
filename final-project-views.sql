/* Final Project Views 

USE myHotel;
GO

--  View #1  
-- updatable view --
CREATE VIEW CurrentEmployees
AS
SELECT EmployeeID, JobID, HotelID, ELastName, EFirstName, HoursWorked
FROM Employees;
GO

--original data--
SELECT * FROM Employees;

-- updating price --

GO
UPDATE CurrentEmployees
SET HoursWorked = 40
WHERE EmployeeID=10001;
GO

-- displaying new data--

SELECT * FROM CurrentEmployees;

--  View #2

--  creating view --
GO
CREATE VIEW GuestReservations
AS
SELECT Reservations.ResvID, Reservations.GuestID, ZipID, GLastName, GFirstName, PhoneNum, Reservations.HotelID 
FROM Reservations JOIN Guests ON Reservations.GuestID = Guests.GuestID;
GO

-- using the view to display the data --
SELECT * FROM GuestReservations;

-- View #3 

-- creating view --
GO
CREATE VIEW ResvOver150
AS
SELECT GuestID, ArrivalDate, DepartureDate FROM Reservations
WHERE ResvRate > 150;
GO

-- using the view to display the data --
SELECT * FROM ResvOver150;

-- View #4

-- creating view --
GO
CREATE VIEW CustomerContact
AS
SELECT GFirstName, GLastName, PhoneNum FROM Guests;
GO

-- using the view to display the data --
SELECT * FROM CustomerContact;*/