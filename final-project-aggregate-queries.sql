USE myHotel;

SELECT COUNT(Employees.EmployeeID) AS [Total Employees],
	   SUM(Employees.HoursWorked) AS [Total Hours Worked]
FROM Employees;

SELECT MIN(Employees.HoursWorked) AS [Minimum Hours Worked],
	   MAX(Employees.HoursWorked) AS [Maximum Hours Worked],
	   AVG(Employees.HoursWorked) AS [Average Hours Worked]
FROM Employees;

SELECT SUM(Employees.HoursWorked * Jobs.HourlyRate) AS [ Total Pay ],
	   MIN(Employees.HoursWorked * Jobs.HourlyRate) AS [ Lowest Pay ],
	   MAX(Employees.HoursWorked * Jobs.HourlyRate) AS [ Highest Pay ],
	   AVG(Employees.HoursWorked * Jobs.HourlyRate) AS [ Average Pay ]
FROM Employees
JOIN Jobs ON Employees.JobID = Jobs.JobID;

SELECT COUNT(Reservations.ResvID) AS [Total Reservations],
	   MIN(DATEDIFF(day, ArrivalDate,  DepartureDate) * Reservations.ResvRate) AS [Lowest Reservation],
	   MAX(DATEDIFF(day, ArrivalDate,  DepartureDate) * Reservations.ResvRate) AS [Highest Reservation],
	   AVG(DATEDIFF(day, ArrivalDate,  DepartureDate) * Reservations.ResvRate) AS [Average Reservation],
	   SUM(DATEDIFF(day, ArrivalDate,  DepartureDate) * Reservations.ResvRate) AS [Total Sales]
FROM Reservations;

