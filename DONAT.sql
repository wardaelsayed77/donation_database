CREATE TABLE Admin(
    Admin_Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(73) NOT NULL,
    Email VARCHAR(166) UNIQUE NOT NULL,
    Password VARCHAR(106) NOT NULL
);
CREATE TABLE Users(
    UserId INT PRIMARY KEY IDENTITY(1,1), 
    Name  VARCHAR(88) NOT NULL,
    Email VARCHAR(155) UNIQUE NOT NULL,
	Password VARCHAR(106) NOT NULL,
	Image text ,
    Address TEXT NULL,
    UserType VARCHAR(10) CHECK (UserType IN ('Donor', 'Acceptor')) NOT NULL,  

    Admin_Id INT NULL,
CONSTRAINT  Admin_Id  FOREIGN KEY (Admin_Id) REFERENCES Admin(Admin_Id) ON DELETE SET NULL,
    
);
alter Table users drop column Fname,Lname;
ALTER TABLE Users ADD Fname varchar(88);
ALTER TABLE Users ADD Lname varchar(88);
CREATE TABLE UserPhones (
    PhoneId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT NOT NULL,
    Phone CHAR(11) NOT NULL,
   CONSTRAINT UserId FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

CREATE TABLE DonationTypes (
    Don_Type_Id INT PRIMARY KEY identity(1,1),
    TypeName VARCHAR(40) UNIQUE NOT NULL
);
INSERT INTO  DonationTypes (TypeName) VALUES ('Money'), ('Clothes'), ('Food'), ('Books');
INSERT INTO  DonationTypes (TypeName) VALUES('blood'),('other')
select *from DonationTypes;
CREATE TABLE Campaigns (
    Camp_Id INT PRIMARY KEY IDENTITY(1,1), 
    CampName VARCHAR(122) NOT NULL, 
    Description TEXT NULL, 
    StartDate DATE NOT NULL, 
    EndDate DATE NOT NULL, 
	Image text ,
    Admin_Id INT NOT NULL, 
	Don_Type_Id INT NOT NULL,
	CONSTRAINT Don_Type_Id
FOREIGN KEY (Don_Type_Id) REFERENCES DonationTypes(Don_Type_Id),
    CONSTRAINT FK_Campaigns_Admin FOREIGN KEY (Admin_Id) REFERENCES Admin(Admin_Id) 
);
alter table Campaigns add Amount NUMERIC(15,2) NOT NULL;
alter table Campaigns add  Address TEXT NULL;
CREATE TABLE Donations(
    Donation_Id INT PRIMARY KEY IDENTITY(1,1),
    Amount NUMERIC(15,2) NOT NULL,
    Donation_Date DATE NOT NULL ,
    Donor_Id INT NOT NULL,
    Camp_Id INT NULL,
    Acceptor_Id INT NULL,
    Don_Type_Id INT NOT NULL,
 CONSTRAINT Donor_Id   FOREIGN KEY (Donor_Id) REFERENCES Users(UserId) ,
 CONSTRAINT  Camp_Id   FOREIGN KEY (Camp_Id) REFERENCES Campaigns(Camp_Id) ,
  CONSTRAINT Acceptor_Id  FOREIGN KEY (Acceptor_Id) REFERENCES Users(UserId) ,
  CONSTRAINT Don_Type_Idfk  FOREIGN KEY (Don_Type_Id) REFERENCES DonationTypes(Don_Type_Id) 
);

CREATE TABLE Delivery (
    Delivery_Id INT PRIMARY KEY IDENTITY(1,1),
    Donation_Id INT NOT NULL,
    Scheduled_Date DATE NOT NULL,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Scheduled', 'In Transit', 'Delivered', 'Cancelled')),
 CONSTRAINT  Donation_Id   FOREIGN KEY (Donation_Id) REFERENCES Donations(Donation_Id)
);
CREATE TABLE Requests (
    Request_Id INT PRIMARY KEY IDENTITY(1,1), 
    Acceptor_Id INT NOT NULL,  
    Don_Type_Id INT NOT NULL, 
    Amount DECIMAL(10,2), 
	description text,
    Status VARCHAR(20) NOT NULL ,
    Date DATE,
	Level_Of_Need text,
    Admin_Id INT NULL,
    FOREIGN KEY (Acceptor_Id) REFERENCES Users(UserId) ON DELETE CASCADE,
    FOREIGN KEY (Don_Type_Id) REFERENCES DonationTypes(Don_Type_Id) ON DELETE CASCADE,
    FOREIGN KEY (Admin_Id) REFERENCES Admin(Admin_Id) ON DELETE SET NULL
);
INSERT INTO Admin (Name, Email, Password) VALUES
('Ahmed Mohamed', 'ahmed.mohamed@gmail.com', 'password12$3'),
('Fatma Ali', 'fatma.ali@gmail.com', 'securep456') ,
('Youssef Hassan', 'youssef.hassan@gmail.com', 'Youssef9!'),
('Mariam Abdel-Rahman', 'mariam.abdel@gmail.com', 'MariamPass321'),
('Mona Ali', 'mona.ali@gmail.com', 'aylee456');
select*from Admin;
select*from Users;
Alter table Users add  Password VARCHAR(106);
INSERT INTO Users (Name,Password ,Email, Address,Image, UserType, Admin_Id) VALUES
('Omar Mohamed','Xy9@pLmAqZt3#', 'omar.mohamed@gmail.com', 'Cairo, Egypt','uevuj.jpg', 'Donor', 1),
('Aisha Khalil','RfG7&uTqWzNp1!', 'aisha.khalil@gmail.com', 'Alexandria, Egypt','hfg.jpg', 'Donor', 2),
('Karim Ibrahim','QmB8*LkXoYvE2$', 'karim.ibrahim@gmail.com', 'Giza, Egypt','gcze.jpg', 'Donor', 3),
('Layla Farid', 'ZaT5@YrNpQwV9#','layla.farid@gmail.com', 'Luxor, Egypt', 'qdfgf.jpg','Acceptor', 3),
('Nour Amin', 'MnP3&XqLvTzK8!','nour.amin@gmail.com', 'Aswan, Egypt','czsd.jpg', 'Acceptor', 4),
('Samir Rashad','JqT4*ZxNpYvR7$', 'samir.rashad@gmail.com', 'Sharm El-Sheikh, Egypt','vghjk.jpg', 'Acceptor', 5),
('Mohamed Ibrahim', 'WvN1@YqTzXpK6#','mohamed.ibrahim@gmail.com', '10 El Tahrir St, Cairo','vnfre.jpg', 'Donor', 5),
('Yasmine Khaled','QpM2&LxNzTrV5!', 'yasmine.khaled@gmail.com', '25 Nasr City, Cairo','veioo.jpg', 'Acceptor', 2),
('Omar Mostafa','XpY9*RzTqNwK3$', 'omar.mostafa@gmail.com', '15 Giza St, Giza','ethv.jpg', 'Donor', 4),
('Nourhan Adel','VqN7@TzXpYwL1#', 'nourhan.adel@gmail.com', '20 Zamalek, Cairo','nbjh.jpg', 'Acceptor', 1),
('Youssef Mahmoud','KpT5&YqNzXvR8!', 'youssef.mahmoud@gmail.com', '15 Nile St, Cairo','nopl.jpg', 'Donor', 3),
('Aisha  Hassan','LxQ4*ZpTqYwN2$', 'aisha.hassan@gmail.com', '22 Pyramids Rd, Giza','bido.jpg', 'Acceptor', 1),
('Omar Ibrahim', 'NpY3@VqTzXwK7#','omar.ibrahim@gmail.com', '7 Suez Canal St, Port Said', 'hael.jpg','Donor', 2),
('Nouran Khaled', 'RzT9&XpYqNwL5!','nouran.khaled@gmail.com', '10 Alexandria Corniche, Alexandria', 'gigo.jpg','Acceptor', 1);
select*from Users;
INSERT INTO Users (Name,Password ,Email, Address,Image, UserType, Admin_Id) VALUES
('Omarss Mohamed','Xyss9@pLmAqZt3#', 'omasr.ssmohamed@gmail.com', 'Caissro, Egypt','uevussj.jpg', 'gfhuiol', 1);

ALTER TABLE UserPhones ADD CONSTRAINT unique_phone UNIQUE (Phone);
INSERT INTO UserPhones (UserId, Phone) 
VALUES 
(11, '01012345678'),
(2, '01198765432'),
(3, '01234567890'),
(4, '01555555555'),
(5, '01001234567'), 
(6, '01119876543'), 
(7, '01223334455'),  
(8, '01005556666'), 
(9, '01111222333'), 
(10, '01504443322'),
(11,'01052345678' ),
(12, '01298774432'),
(13, '01255512345'),
(14, '01511122233'),
(4, '01044455566'),
(7, '01188997766'), 
(10,'01277665544')
;  select*from UserPhones;
INSERT INTO Campaigns (CampName, Description, StartDate, EndDate, Image, Admin_Id, Don_Type_Id, Amount, Address)  
VALUES ('Food Drive', 'A campaign to collect food for the needy.', '2025-04-01', '2025-04-30', 'food_drive.jpg', 1, 3, 5000.00, 'Downtown Center'),  
    ('Blood Donation', 'Blood donation event for hospitals.', '2025-05-10', '2025-05-15', 'blood_donation.png', 2, 5, 2000.00, 'City Hospital'),  
    ('Education Fund', 'Raising funds for school children.', '2025-06-01', '2025-06-30', 'education_fund.jpg', 3, 4, 10000.00, 'Community Hall'),  
    ('Medical Aid', 'Providing medical supplies for remote areas.', '2025-07-01', '2025-07-15', 'medical_aid.jpg', 4, 6, 7500.00, 'Health Center'),  
    ('Winter Clothes', 'Collecting winter clothes for the homeless.', '2025-08-01', '2025-08-31', 'winter_clothes.jpg', 5, 2, 3000.00, 'Charity House'),
	('Disaster Relief', 'Financial aid for disaster victims.', '2025-02-15', '2025-05-15', 'image4.jpg', 1, 1, 100000.00, 'Aswan, Egypt'); 
	select *from Campaigns;
INSERT INTO Donations (Amount, Donation_Date, Donor_Id, Camp_Id, Acceptor_Id, Don_Type_Id) VALUES
(5000.00, '2023-03-15', 1, 1, 4, 3),
(200.50, '2023-09-10', 2, 2, 5, 5),    
(1500.00, '2023-11-20', 3, NULL, 6, 2),
(200.00, '2025-03-12', 10,4, 2, 6),
(3, '2025-03-15', 7, 2, 8, 5),
(10, '2025-03-17', 9, 6, 14,1),
(500.00, '2024-03-15', 7, 1, NULL, 3),
(200.00, '2024-01-20', 9, 2, NULL, 5),
(1000.00, '2024-03-20', 2, 3, NULL, 4),
(300.00, '2024-02-01', 11,2, NULL, 5),
(150.00, '2024-02-05', 13,5, NULL, 2),
(750.00, '2024-03-25', 1, null, 5, 1),
(400.00, '2024-02-10', 3, null, 4, 3),
(400.00, '2024-02-10', 2, null, 4, 2);
select *from Donations;
delete from Donations where Acceptor_Id=2;
INSERT INTO Donations (Amount, Donation_Date, Donor_Id, Camp_Id, Acceptor_Id, Don_Type_Id) VALUES(200.00, '2025-03-12', 10,4, 12, 6);
delete from Donations where Acceptor_Id=2;
INSERT INTO Donations (Amount, Donation_Date, Donor_Id, Camp_Id, Acceptor_Id, Don_Type_Id) VALUES(200.00, '2025-03-12', 11,4, 12, 6);
select distinct UserType,Donor_Id from Users join Donations on Users.UserId=Donations.Donor_Id;
select distinct UserType,Acceptor_Id from Users join Donations on Users.UserId=Donations.Acceptor_Id;
INSERT INTO Delivery (Donation_Id, Scheduled_Date, Status) VALUES
(1, '2024-03-17', 'Scheduled'),
(2, '2024-01-22', 'In Transit'),
(3, '2024-03-22', 'Scheduled'),
(11, '2024-02-03', 'In Transit'),
(6, '2024-03-27', 'Delivered'),
(7, '2024-02-12', 'Delivered'),
(8, '2024-04-05', 'Cancelled'),
(9, '2024-03-30', 'Scheduled'),
(10, '2024-04-10', 'In Transit');
INSERT INTO Requests (Acceptor_Id, Don_Type_Id, Amount, Description, Status, Date, Level_Of_Need, Admin_Id) VALUES 
(4, 6, 500.00, 'Request for medical assistance', 'Pending', '2025-03-10', 'High', 1),
(5, 3, NULL, 'Request for food supplies', 'Approved', '2025-03-11', 'Medium', 2),
(6, 2, NULL, 'Need for clothing donations', 'Pending', '2025-03-12', 'Low', 3),
(8, 1, 1000.00, 'Financial aid for surgery', 'Approved', '2025-03-13', 'High', 1),
(12, 6, NULL, 'Request for shelter assistance', 'Rejected', '2025-03-14', 'High', NULL),
(14, 3, NULL, 'Need for daily meals', 'Pending', '2025-03-15', 'Medium', 2),
(4, 2, NULL, 'Clothing for winter season', 'Approved', '2025-03-16', 'Low', 3),
(6, 5, 750.00, 'Help with medical bills', 'Pending', '2025-03-17', 'High', 1),
(12, 4, NULL, 'Request for books', 'Approved', '2025-03-18', 'High', 2),
(14, 3, NULL, 'Food packages for family', 'Rejected', '2025-03-19', 'Medium', NULL),
(5, 1, 300.00, 'need for education', 'Pending', '2025-03-20', 'High', 3),
(8, 2, NULL, 'Winter clothes for children', 'Approved', '2025-03-21', 'Low', 1);
select distinct UserType,Acceptor_Id from Users join Requests on Users.UserId=Requests.Acceptor_Id;
SELECT * FROM Admin;
SELECT * FROM Users;
SELECT * FROM UserPhones;
SELECT * FROM Campaigns;
SELECT * FROM Donations;
SELECT * FROM DonationTypes;
SELECT * FROM Delivery;
SELECT *FROM Users where UserType='Donor';
SELECT *FROM Users where UserType='Acceptor';
select @@SERVERNAME
SELECT COUNT(Donation_Id) AS number, TypeName 
FROM DonationTypes 
JOIN Donations ON DonationTypes.Don_Type_Id = Donations.Don_Type_Id
GROUP BY TypeName;
SELECT COUNT(Request_Id) AS number, 
       CONVERT(NVARCHAR(MAX), Level_Of_Need) AS Level_Of_Need
FROM Requests 
GROUP BY CONVERT(NVARCHAR(MAX), Level_Of_Need);
SELECT * FROM Donations;
SELECT COUNT(Donation_Id) AS number 
FROM Donations where Camp_Id IS NULL ;
SELECT COUNT(Donation_Id) AS number 
FROM Donations where Camp_Id IS NOT NULL ;
SELECT   sUM(Amount) AS number, Name 
FROM Users 
JOIN Donations ON Users.UserId = Donations.Acceptor_Id
GROUP BY Name;
SELECT TOP 6 SUM(Amount) AS number, Name 
FROM Users 
JOIN Donations ON Users.UserId = Donations.Donor_Id
GROUP BY Name
ORDER BY number DESC;
