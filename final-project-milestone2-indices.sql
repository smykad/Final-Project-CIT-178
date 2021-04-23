USE myHotel
GO
CREATE INDEX idx_Employee ON Jobs(JobID)
GO
CREATE INDEX idx_Employee_Hotel ON Hotels(HotelID)
GO
CREATE INDEX idx_Guest_Zip ON Guests(ZipID);
GO
CREATE INDEX idx_Guest ON Reservations(GuestID);
GO
CREATE INDEX idx_Guest_Hotel ON Reservations(HotelID)
GO
CREATE INDEX idx_Hotel_Zip ON Hotels(ZipID)