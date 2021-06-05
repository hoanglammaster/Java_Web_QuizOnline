USE master
CREATE DATABASE QuizOnline
GO
USE QuizOnline
CREATE TABLE Questions(
	quesID INT IDENTITY(1,1) PRIMARY KEY,
	quesContent NVARCHAR(500) NOT NULL UNIQUE,
    createdDate DATE DEFAULT GETDATE(),
)

CREATE TABLE Answers(
	ansID INT PRIMARY KEY,
	ansContent1 NVARCHAR(500) NOT NULL,
	ansContent2 NVARCHAR(500) NOT NULL,
	ansContent3 NVARCHAR(500) NOT NULL,
	ansContent4 NVARCHAR(500) NOT NULL,
    trueAnswer INT NOT NULL,
	FOREIGN KEY (ansID) REFERENCES Questions(quesID)
)

CREATE TABLE Accounts(
	accId INT IDENTITY(1000,1) PRIMARY KEY,
	userName NVARCHAR(50) UNIQUE NOT NULL,
	passwords NVARCHAR(50) NOT NULL,
	isTeacher BIT NOT NULL,
	email NVARCHAR(50) NOT NULL
)

CREATE PROCEDURE AddQuestion  (@quesContent NVARCHAR(500), @ans1 NVARCHAR(500), @ans2 NVARCHAR(500), @ans3 NVARCHAR(500),@ans4 NVARCHAR(500),@trueAns INT)
AS
BEGIN
	INSERT INTO dbo.Questions(quesContent) VALUES(@quesContent);
	INSERT INTO dbo.Answers(ansID,ansContent1, ansContent2, ansContent3, ansContent4,trueAnswer) VALUES((SELECT quesID FROM dbo.Questions WHERE quesContent = @quesContent),@ans1, @ans2, @ans3, @ans4,@trueAns)
END

EXEC AddQuestion 'The name caption ?','Sai Gon','Ho Chi Minh','Ha Noi','Ha Tay',2

SELECT COUNT(quesID) from Questions

SELECT * FROM Questions
SELECT * FROM Answers

SELECT TOP(1)* FROM (SELECT * FROM Questions ORDER BY NEWID())
SELECT TOP(1) * FROM Questions
SELECT * FROM Answers WHERE ansID = 1
SELECT TOP(1) * FROM Questions ORDER BY NEWID()