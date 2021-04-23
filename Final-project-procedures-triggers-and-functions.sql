/* Final Project Procedures 

-- Retrieves and displays data

USE myHotel;
GO
CREATE PROC spGuests
AS
SELECT * FROM Guests
ORDER BY GLastName;
GO

EXEC spGuests;


-- Takes an input parameter
USE myHotel;
GO
CREATE PROC spGetGuest
	@GuestID int
AS
BEGIN
	SELECT * FROM Guests
	WHERE GuestID = @GuestID;
END
GO
EXEC spGetGuest 10101


-- Takes one input parameter and returns three output parameters
USE myHotel;
GO
CREATE PROC spGuestContact
	@GuestID int,
	@FirstName nvarchar(30) OUTPUT,
	@LastName nvarchar(50) OUTPUT,
	@PhoneNumber nvarchar(30) OUTPUT 
AS
SELECT @FirstName = GFirstName, @LastName = GLastName, @PhoneNumber = PhoneNum
FROM Guests 
WHERE GuestID = @GuestID;
GO
-- Run the procedure
DECLARE @FirstName nvarchar(30);
DECLARE @LastName nvarchar(50);
DECLARE @Phone nvarchar(30);
EXEC spGuestContact 30101, @FirstName OUTPUT, @LastName OUTPUT, @Phone OUTPUT;
SELECT @FirstName AS 'First Name', @LastName AS 'Last Name', @Phone AS 'Phone Number';

-- Stored procedure that has a return value 
USE myHotel;
GO
CREATE PROC spGuestCount
AS
DECLARE @GuestCount int;
SELECT @GuestCount = COUNT(*)
FROM Guests 
RETURN @GuestCount;
GO

DECLARE @GuestCount int;
EXEC @GuestCount = spGuestCount;
PRINT 'There are ' + CONVERT(varchar, @GuestCount) + ' guests in your database';
GO

--- Final Project User Defined Functions 

-- creates the function

USE myHotel;
GO
CREATE FUNCTION fnGetHourlyRate
    (@JobTitle nvarchar(50) = '%')
    RETURNS int
BEGIN
    RETURN (SELECT HourlyRate FROM Jobs WHERE JobTitle Like @JobTitle);
END;

-- uses the function

SELECT JobTitle, HourlyRate FROM Jobs 
WHERE HourlyRate = dbo.fnGetHourlyRate('Manager%'); 

USE myHotel;
GO
CREATE FUNCTION fnHotels
	(@HotelName nvarchar(50) = '%')
	RETURNS table
RETURN
	(SELECT * FROM Hotels WHERE HotelName LIKE @HotelName);
GO
SELECT * FROM dbo.fnHotels('%L%');

---------------------------------------------------------------------------------

 -- Final Project Triggers 

 -- create archive table by copying customer table without any rows
 USE myHotel;
 GO
 SELECT * INTO GuestTransaction
 FROM Guests
 WHERE 1=0;

 -- update CustomerTransaction table and add activity column for status
 ALTER TABLE GuestTransaction
 ADD Activity varchar(50);
 GO

 -- create insert trigger
 CREATE TRIGGER GuestTransaction_INSERT ON Guests
    AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @GuestID int
	DECLARE @ZipID nvarchar(10)
	DECLARE @GFirstName nvarchar(20)
	DECLARE @GLastName nvarchar(30)
	DECLARE @PhoneNum nvarchar(15)

    SELECT @GuestID =INSERTED.GuestID, @ZipID = INSERTED.ZipID, @GFirstName = INSERTED.GFirstName, @GLastName = INSERTED.GLastName, @PhoneNum = INSERTED.PhoneNum
	FROM INSERTED

    INSERT INTO GuestTransaction VALUES(@GuestID, @ZipID, @GFirstName, @GLastName, @PhoneNum, 'Inserted' )
END
GO
-- add row into customer to test insert trigger
INSERT INTO Guests VALUES(40101,'11561','Fred','Flintstone','(231)-123-4567','NULL');
GO
-- view data in customer archive
SELECT * FROM GuestTransaction;
GO
 -- create delete trigger
 CREATE TRIGGER CustomerTransaction_Delete ON Guests
    AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @GuestID int
	DECLARE @ZipID nvarchar(10)
	DECLARE @GFirstName nvarchar(20)
	DECLARE @GLastName nvarchar(30)
	DECLARE @PhoneNum nvarchar(15)

    SELECT @GuestID =DELETED.GuestID, @ZipID = DELETED.ZipID, 
		   @GFirstName = DELETED.GFirstName, @GLastName = DELETED.GLastName, 
		   @PhoneNum = DELETED.PhoneNum
	FROM DELETED

    INSERT INTO GuestTransaction VALUES(@GuestID, @ZipID, @GFirstName, @GLastName, @PhoneNum, 'Deleted' )
END
GO
-- delete row from customer to test delete trigger
DELETE FROM Guests WHERE GuestID = 40101;
GO

-- view data in customer archive
SELECT * FROM GuestTransaction;

GO
 -- create update trigger
 CREATE TRIGGER GuestTransaction_Update ON Guests
    AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @GuestID int
	DECLARE @ZipID nvarchar(10)
	DECLARE @GFirstName nvarchar(20)
	DECLARE @GLastName nvarchar(30)
	DECLARE @PhoneNum nvarchar(15)

    SELECT @GuestID =INSERTED.GuestID, @ZipID = INSERTED.ZipID,  @GFirstName = INSERTED.GFirstName, @GLastName = INSERTED.GLastName,
		   @PhoneNum = INSERTED.PhoneNum
	FROM INSERTED

	-- Since all the data is being written to the archive table, there is no need to identify what was changed
    INSERT INTO GuestTransaction VALUES(@GuestID,@ZipID, @GFirstName, @GLastName, @PhoneNum, 'Updated' )
END
GO
-- insert a new row and then update the row (this will test the insert and update triggers)
INSERT INTO Guests VALUES(60101,'11561','Wilma','Flintstone','(231)-123-4567','NULL');
GO
UPDATE Guests 
SET GFirstName = 'Pebbles'
WHERE GuestID = 60101;
GO
-- view data in customer archive
SELECT * FROM GuestTransaction; */