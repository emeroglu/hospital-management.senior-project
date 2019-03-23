DELETE FROM hosTransaction
DELETE FROM hosPrescription
DELETE FROM hosDiagnosis
DELETE FROM hosDisease
DELETE FROM hosBooking
DELETE FROM hosComplaintExamination
DELETE FROM hosExamination
DELETE FROM hosComplaint
DELETE FROM hosMedication
DELETE FROM hosRoom
DELETE FROM hosPatient
DELETE FROM hosInsurance
DELETE FROM hosDoctor
DELETE FROM hosUser
GO

DBCC CHECKIDENT (hosTransaction, RESEED, 0)
DBCC CHECKIDENT (hosPrescription, RESEED, 0)
DBCC CHECKIDENT (hosDiagnosis, RESEED, 0)
DBCC CHECKIDENT (hosDisease, RESEED, 0)
DBCC CHECKIDENT (hosBooking, RESEED, 0)
DBCC CHECKIDENT (hosComplaintExamination, RESEED, 0)
DBCC CHECKIDENT (hosExamination, RESEED, 0)
DBCC CHECKIDENT (hosComplaint, RESEED, 0)
DBCC CHECKIDENT (hosMedication, RESEED, 0)
DBCC CHECKIDENT (hosRoom, RESEED, 0)
DBCC CHECKIDENT (hosPatient, RESEED, 0)
DBCC CHECKIDENT (hosInsurance, RESEED, 0)
DBCC CHECKIDENT (hosDoctor, RESEED, 0)
DBCC CHECKIDENT (hosUser, RESEED, 0)
GO

INSERT INTO hosUser VALUES ('admin','1234',0,GETDATE())
INSERT INTO hosUser VALUES ('alyildirim','1234',0,GETDATE())
INSERT INTO hosUser VALUES ('emeroglu','1234',0,GETDATE())
INSERT INTO hosUser VALUES ('ahmet','1234',0,GETDATE())
INSERT INTO hosUser VALUES ('hasan','1234',0,GETDATE())
INSERT INTO hosUser VALUES ('emo','1234',0,GETDATE())
INSERT INTO hosUser VALUES ('arda','1234',0,GETDATE())
GO

INSERT INTO hosDoctor VALUES (2,'Alper Ekrem','Yýldýrým',22,'alper@yil.com','+90 530 037 6462')
INSERT INTO hosDoctor VALUES (3,'Erhan Emre','Eroðlu',48,'emeroglu@gmail.com','+90 530 037 6462')
INSERT INTO hosDoctor VALUES (4,'Ahmet','Altýntop',65,'memo@gold.com','+90 550 236 9586')
GO

INSERT INTO hosInsurance VALUES ('Super Insurance',50)
INSERT INTO hosInsurance VALUES ('Medium Insurance',35)
INSERT INTO hosInsurance VALUES ('Minimal Insurance',25)
GO

INSERT INTO hosPatient VALUES (5,'Hasan','Yaðýz',35,'memo@asd.com','+90 550 236 9586',1)
INSERT INTO hosPatient VALUES (6,'Emre','Aksu',35,'kazim@qwe.com','+90 535 369 8545',3)
INSERT INTO hosPatient VALUES (7,'Arda','Marda',35,'ardarda@aasdd.com','+90 532 023 6589',2)
GO

INSERT INTO hosRoom VALUES ('1001',1,0)
INSERT INTO hosRoom VALUES ('1002',1,0)
INSERT INTO hosRoom VALUES ('2001',2,0)
INSERT INTO hosRoom VALUES ('2002',2,0)
INSERT INTO hosRoom VALUES ('2003',2,0)
INSERT INTO hosRoom VALUES ('2004',2,0)
INSERT INTO hosRoom VALUES ('3001',3,0)
INSERT INTO hosRoom VALUES ('3002',3,0)
INSERT INTO hosRoom VALUES ('3003',3,0)
INSERT INTO hosRoom VALUES ('3004',3,0)
INSERT INTO hosRoom VALUES ('4001',4,0)
INSERT INTO hosRoom VALUES ('4002',4,0)
INSERT INTO hosRoom VALUES ('4003',4,0)
INSERT INTO hosRoom VALUES ('4004',4,0)
INSERT INTO hosRoom VALUES ('5001',5,0)
INSERT INTO hosRoom VALUES ('5002',5,0)
GO

--INSERT INTO hosComplaint VALUES (1,1,'Cancer','I think I have cancer.',0)
--INSERT INTO hosComplaint VALUES (2,1,'Cancer','I think I have cancer.',0)
--INSERT INTO hosComplaint VALUES (3,3,'Prostat','I think I have prostat.',1)
--GO

INSERT INTO hosExamination VALUES ('General Medical Exam',150,0)
INSERT INTO hosExamination VALUES ('Eye Exam',180,0)
INSERT INTO hosExamination VALUES ('Physical Exam',60,1)
INSERT INTO hosExamination VALUES ('MR Scan',230,0)
INSERT INTO hosExamination VALUES ('Pulmonary Function Test',165,0)
INSERT INTO hosExamination VALUES ('Blood Test',105,0)
INSERT INTO hosExamination VALUES ('Scratch Test',60,0)
GO

--INSERT INTO hosComplaintExamination VALUES (1,4)
--INSERT INTO hosComplaintExamination VALUES (2,4)
--INSERT INTO hosComplaintExamination VALUES (3,3)
--GO

--INSERT INTO hosBooking VALUES (1,3,GETDATE(),GETDATE() + 5,1)
--INSERT INTO hosBooking VALUES (2,1,GETDATE(),GETDATE() + 5,1)
--INSERT INTO hosBooking VALUES (3,2,GETDATE(),GETDATE() + 5,1)
--GO

INSERT INTO hosDisease VALUES ('Allergy')
INSERT INTO hosDisease VALUES ('Asthma')
INSERT INTO hosDisease VALUES ('Fever')
INSERT INTO hosDisease VALUES ('Headache')
INSERT INTO hosDisease VALUES ('Backache')
INSERT INTO hosDisease VALUES ('Sore throat')
INSERT INTO hosDisease VALUES ('Kidney stone')
INSERT INTO hosDisease VALUES ('Bronchitis')
INSERT INTO hosDisease VALUES ('Smallpox')
INSERT INTO hosDisease VALUES ('Freckle')
INSERT INTO hosDisease VALUES ('Skin cancer')
INSERT INTO hosDisease VALUES ('Toothache')
INSERT INTO hosDisease VALUES ('Acne')
INSERT INTO hosDisease VALUES ('Stroke')
INSERT INTO hosDisease VALUES ('Hernia')
INSERT INTO hosDisease VALUES ('Flu')
INSERT INTO hosDisease VALUES ('Goiter')
INSERT INTO hosDisease VALUES ('Diarrhea') 
INSERT INTO hosDisease VALUES ('Mumps')
INSERT INTO hosDisease VALUES ('Cataract')
INSERT INTO hosDisease VALUES ('Rubeola')
INSERT INTO hosDisease VALUES ('Mad')
INSERT INTO hosDisease VALUES ('Otitis')
INSERT INTO hosDisease VALUES ('Leucemia')
INSERT INTO hosDisease VALUES ('Migraine')
INSERT INTO hosDisease VALUES ('Myopy')
INSERT INTO hosDisease VALUES ('Keratoma')
INSERT INTO hosDisease VALUES ('Cold')
INSERT INTO hosDisease VALUES ('Rheumatics')
INSERT INTO hosDisease VALUES ('Deafness')
INSERT INTO hosDisease VALUES ('Epilepsy')
INSERT INTO hosDisease VALUES ('Malaria')
INSERT INTO hosDisease VALUES ('Sinusitis')
INSERT INTO hosDisease VALUES ('Diabetes')
INSERT INTO hosDisease VALUES ('Tension')
INSERT INTO hosDisease VALUES ('Spotted fever')
INSERT INTO hosDisease VALUES ('Tubercular')
INSERT INTO hosDisease VALUES ('Pneumonia')
GO

--INSERT INTO hosDiagnosis VALUES (1,1,'You''re gonna die')
--INSERT INTO hosDiagnosis VALUES (2,1,'You''re not gonna die')
--INSERT INTO hosDiagnosis VALUES (3,2,'Go fuck yourself')
--GO

INSERT INTO hosMedication VALUES ('Operation')
INSERT INTO hosMedication VALUES ('Vitamin')
INSERT INTO hosMedication VALUES ('Augmentin')
INSERT INTO hosMedication VALUES ('Majezik')
INSERT INTO hosMedication VALUES ('Novalgine')
INSERT INTO hosMedication VALUES ('Syrup')
GO

--INSERT INTO hosPrescription VALUES (1,2,'Hadi aslaným')
--INSERT INTO hosPrescription VALUES (2,2,'Hadi aslaným')
--INSERT INTO hosPrescription VALUES (3,1,'Hadi aslaným')
--GO

--INSERT INTO hosTransaction VALUES (1,1,50,GETDATE(),NULL,0)
--INSERT INTO hosTransaction VALUES (2,1,40,GETDATE() - 2,GETDATE(),1)
--GO



SELECT * FROM hosUser
SELECT * FROM hosDoctor
SELECT * FROM hosInsurance
SELECT * FROM hosPatient
SELECT * FROM hosRoom
SELECT * FROM hosBooking
SELECT * FROM hosComplaint
SELECT * FROM hosDiagnosis
SELECT * FROM hosDisease
SELECT * FROM hosMedication
SELECT * FROM hosPrescription
SELECT * FROM hosTransaction
SELECT * FROM hosExamination
SELECT * FROM hosComplaintExamination