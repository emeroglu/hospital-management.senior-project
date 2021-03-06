CREATE TABLE hosUser
(
	ID int primary key identity(1,1),
	Username varchar(100),
	Password varchar(100),
	Online bit,
	LastSeen datetime
)
GO

CREATE TABLE hosDoctor
(
	ID int primary key identity(1,1),
	UserID int foreign key references hosUser(ID),
	Name varchar(250),
	Surname varchar(100),
	Age int,
	Email varchar(250),
	Phone varchar(50)
)
GO

CREATE TABLE hosInsurance
(
	ID int primary key identity(1,1),
	Name varchar(250),
	Discount decimal
)
GO

CREATE TABLE hosPatient
(
	ID int primary key identity(1,1),
	UserID int foreign key references hosUser(ID),
	Name varchar(250),
	Surname varchar(100),
	Age int,
	Email varchar(250),
	Phone varchar(50),
	InsuranceID int foreign key references hosInsurance(ID)
)
GO

CREATE TABLE hosComplaint
(
	ID int primary key identity(1,1),
	PatientID int foreign key references hosPatient(ID)
)
GO

CREATE TABLE hosAppointment
(
	ID int primary key identity(1,1),
	PatientID int foreign key references hosPatient(ID),
	DoctorID int foreign key references hosDoctor(ID),	
	Date datetime,
	Status int
)
GO

CREATE TABLE hosRoom
(
	ID int primary key identity(1,1),
	Number int,
	Floor int,		
	PrescriptionID int foreign key references hosPrescription(ID),
	StartDate datetime,
	EndDate datetime,
	Status int
)
GO

CREATE TABLE hosTransaction
(
	ID int primary key identity(1,1),
	PrescriptionID int foreign key references hosPrescription(ID),
	PaymentMethod int,
	Amount decimal,
	ProvisionDate datetime,
	Date datetime,
	Status int
)
GO

CREATE TABLE hosExamination
(
	ID int primary key identity(1,1),
	Name varchar(250),
	Fee decimal,
	NeedsRoom int
)
GO