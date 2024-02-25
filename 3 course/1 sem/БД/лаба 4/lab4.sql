use mshoad
go

drop table UserResponses;

-- �������� ������� ��� ������� �� �������
CREATE TABLE UserResponses (
    ResponseID INT PRIMARY KEY,
    UserID INT,
    RequestID INT, 
    ResponseText NVARCHAR(MAX),
    ResponseDate DATETIME,
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RequestID) REFERENCES Requests(RequestID)
);

ALTER TABLE UserResponses
ADD OperatorName NVARCHAR(100);

CREATE TABLE Operators (
    OperatorID INT PRIMARY KEY,
    OperatorName NVARCHAR(100)
);

INSERT INTO Operators (OperatorID, OperatorName)
VALUES
    (1, '�������� 1'),
    (2, '�������� 2'),
    (3, '�������� 3');

-- 1 add data

-- ���������� ������ � ������� Users
INSERT INTO Users (UserID, FirstName, LastName, Username, Email, Role)
VALUES
    (1, 'John', 'Doe', 'johndoe', 'johndoe@example.com', 'User'),
    (2, 'Jane', 'Smith', 'janesmith', 'janesmith@example.com', 'User'),
    (3, 'Admin', 'Admin', 'admin', 'admin@example.com', 'Admin');

-- ���������� ������ � ������� Requests
INSERT INTO Requests (RequestID, Title, Description, Status, Priority, CreatedAt, UpdatedAt, UserID, UserFullName, KnowledgeBaseID)
VALUES
    (1, 'Request 1', 'Description for Request 1', 'Open', 'High', GETDATE(), GETDATE(), 1, 'John Doe', 1),
    (2, 'Request 2', 'Description for Request 2', 'Open', 'Medium', GETDATE(), GETDATE(), 2, 'Jane Smith', 2);

-- ���������� ������ � ������� Incidents
INSERT INTO Incidents (IncidentID, Title, Description, Status, Priority, CreatedAt, ClosedAt, UserID, UserFullName)
VALUES
    (1, 'Incident 1', 'Description for Incident 1', 'Open', 'High', GETDATE(), NULL, 1, 'John Doe'),
    (2, 'Incident 2', 'Description for Incident 2', 'Closed', 'Medium', GETDATE(), GETDATE(), 2, 'Jane Smith');

-- ���������� ������ � ������� Comments
INSERT INTO Comments (CommentID, Text, CreatedAt, UserID, UserFullName, RequestID, IncidentID)
VALUES
    (1, 'Comment 1 for Request 1', GETDATE(), 1, 'John Doe', 1, NULL),
    (2, 'Comment 2 for Request 1', GETDATE(), 2, 'Jane Smith', 1, NULL),
    (3, 'Comment 1 for Incident 1', GETDATE(), 1, 'John Doe', NULL, 1),
    (4, 'Comment 2 for Incident 1', GETDATE(), 2, 'Jane Smith', NULL, 1);

-- ���������� ������ � ������� Reports
INSERT INTO Reports (ReportID, ReportType, CreatedAt, ReportData, UserID, UserFullName, RequestType)
VALUES
    (1, 'Monthly Report', GETDATE(), 'Data for the report', 1, 'John Doe', 'Request'),
    (2, 'Yearly Report', GETDATE(), 'Data for the report', 2, 'Jane Smith', 'Incident');

-- ���������� ������ � ������� KnowledgeBase
INSERT INTO KnowledgeBase (ArticleID, Title, Content, Category, CreatedAt)
VALUES
	(13, 'How to Use SQL', 'Learn SQL basics', 'Tutorials', GETDATE()),
	(14, 'Database Design', 'Tips for designing databases', 'Tutorials', GETDATE());

-- ���������� ������ � ������� UserResponses
INSERT INTO UserResponses VALUES
    (1, 1, 1, 'Response to Request 1', GETDATE(), '�������� 1'),
    (2, 1, 1, 'Another response to Request 1', GETDATE(), '�������� 2'),
    (3, 2, 2, 'Response to Request 2', GETDATE(), '�������� 3'),
	(4, 2, 2, 'Another response to Request 2', '16.01.2023', '�������� 4');


-- 2 
SELECT
    CASE
        WHEN ResponseDate >= DATEADD(MONTH, -1, GETDATE()) THEN '�� ��������� �����'
        WHEN ResponseDate >= DATEADD(QUARTER, -1, GETDATE()) THEN '�� ��������� �������'
        WHEN ResponseDate >= DATEADD(MONTH, -6, GETDATE()) THEN '�� ��������� �������'
        WHEN ResponseDate >= DATEADD(YEAR, -1, GETDATE()) THEN '�� ��������� ���'
        ELSE '������ ������'
    END AS Period,
    ResponseText
FROM UserResponses;


-- 3
WITH AggregatedData AS (
    SELECT
        r.UserID,
        r.RequestID,
        AVG(DATEDIFF(MINUTE, rq.CreatedAt, r.ResponseDate)) AS AvgResponseTime,
        COUNT(DISTINCT r.RequestID) AS RequestCount,
        COUNT(DISTINCT CASE WHEN DATEDIFF(MINUTE, rq.CreatedAt, r.ResponseDate) = 0 THEN r.RequestID END) AS OneTimeRequestCount
    FROM UserResponses r
    JOIN Requests rq ON r.RequestID = rq.RequestID
    GROUP BY r.UserID, r.RequestID
)
SELECT
    UserID,
    AVG(AvgResponseTime) AS AvgResponseTime,
    (AVG(AvgResponseTime) / AVG(AvgResponseTime) OVER ()) * 100 AS AvgResponseTimePercent,
    (SUM(OneTimeRequestCount) * 1.0 / SUM(RequestCount)) * 100 AS OneTimeRequestPercent,
    (SUM(OneTimeRequestCount) * 1.0 / SUM(RequestCount) OVER ()) * 100 AS OneTimeRequestPercentTotal
FROM AggregatedData
GROUP BY UserID, AvgResponseTime, RequestCount;

INSERT INTO Operators (OperatorID, OperatorName)
VALUES
    (4, '�������� 4'),
    (5, '�������� 5'),
    (6, '�������� 6'),
	(7, '�������� 7'),
	(8, '�������� 8'),
	(9, '�������� 9'),
	(10, '�������� 10'),
	(11, '�������� 11'),
	(12, '�������� 12'),
	(13, '�������� 13'),
	(14, '�������� 14'),
	(15, '�������� 15'),
	(16, '�������� 16'),
	(17, '�������� 17'),
	(18, '�������� 18');

-- 4
WITH RankedData AS (
    SELECT OperatorName,
        ROW_NUMBER() OVER (ORDER BY OperatorName) AS RowNum
    FROM Operators
)

SELECT * FROM RankedData
WHERE RowNum BETWEEN 1 AND 20; -- ������ between

-- 5 
WITH NumberedResults AS (
    SELECT
        ResponseID,
        UserID,
        RequestID,
        ResponseText,
        ResponseDate,
        ROW_NUMBER() OVER (PARTITION BY RequestID ORDER BY ResponseID) AS RowNum
    FROM UserResponses
)
DELETE FROM NumberedResults
WHERE RowNum > 1;

-- 6 
SELECT
    UserID,
    DATEPART(YEAR, ResponseDate) AS ResponseYear,
    DATEPART(MONTH, ResponseDate) AS ResponseMonth,
    COUNT(DISTINCT RequestID) AS CustomersServed
FROM UserResponses
WHERE ResponseDate >= DATEADD(MONTH, -4, GETDATE()) -- �� ��������� 4 ������
GROUP BY UserID, DATEPART(YEAR, ResponseDate), DATEPART(MONTH, ResponseDate)
ORDER BY UserID, ResponseYear, ResponseMonth;


-- 7
WITH ClientServiceCounts AS (
    SELECT
        ur.UserID,
        u.UserFullName AS ClientName,
        o.OperatorName AS EmployeeName,
        COUNT(ur.RequestID) AS ServiceCount
    FROM UserResponses ur
    JOIN Requests r ON ur.RequestID = r.RequestID
    JOIN Users u ON r.UserID = u.UserID
    JOIN Operators o ON ur.UserID = o.OperatorID
    GROUP BY ur.UserID, u.UserFullName, o.OperatorName
)

SELECT
    UserID,
    ClientName,
    EmployeeName,
    ServiceCount
FROM (
    SELECT
        *,
        RANK() OVER (PARTITION BY UserID ORDER BY ServiceCount DESC) AS Rank
    FROM ClientServiceCounts
) RankedClientServiceCounts
WHERE Rank = 1
ORDER BY ServiceCount DESC;
