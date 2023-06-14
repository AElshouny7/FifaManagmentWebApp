
CREATE DATABASE Project
USE Project
-- 2.1
GO
CREATE PROCEDURE createAllTables
AS
CREATE TABLE SystemUser
(
  username VARCHAR(20) NOT NULL,
  password VARCHAR(20) NOT NULL,
  PRIMARY KEY (username)
)

CREATE TABLE Stadium_Manager
(
  name VARCHAR(20) NOT NULL,
  id INT NOT NULL IDENTITY,
  username VARCHAR(20),
  PRIMARY KEY (username),
  CONSTRAINT fk_smU FOREIGN KEY (username) REFERENCES SystemUser(username),
  UNIQUE (id)
)

CREATE TABLE Club_representative
(
  id INT NOT NULL IDENTITY,
  name VARCHAR(20) NOT NULL,
  username VARCHAR(20),
  PRIMARY KEY (username),
  CONSTRAINT fk_crU FOREIGN KEY (username) REFERENCES SystemUser(username),
  UNIQUE (id)
)

CREATE TABLE Fan
(
  national_id VARCHAR(20) NOT NULL,
  status BIT NOT NULL,
  address VARCHAR(20) NOT NULL,
  name VARCHAR(20) NOT NULL,
  phone_No VARCHAR(20) NOT NULL,
  birth_date DATE NOT NULL,
  username VARCHAR(20),
  PRIMARY KEY (username),
  CONSTRAINT fk_fSmU FOREIGN KEY (username) REFERENCES SystemUser(username),
  UNIQUE (national_id)
)

CREATE TABLE Sports_Association_Manager
(
  id INT NOT NULL IDENTITY,
  name VARCHAR(20) NOT NULL,
  username VARCHAR(20),
  PRIMARY KEY (username),
  CONSTRAINT fk_samSmU FOREIGN KEY (username) REFERENCES SystemUser(username),
  UNIQUE (id)
)

CREATE TABLE System_Admin
(
  id INT NOT NULL IDENTITY,
  name VARCHAR(20) NOT NULL,
  username VARCHAR(20),
  PRIMARY KEY (username),
  CONSTRAINT fk_saSmu FOREIGN KEY (username) REFERENCES SystemUser(username),
  UNIQUE (id)
)

CREATE TABLE Stadium
(
  id INT NOT NULL IDENTITY,
  name VARCHAR(20) NOT NULL,
  capacity INT NOT NULL,
  location VARCHAR(20) NOT NULL,
  status BIT NOT NULL,
  username VARCHAR(20),
  PRIMARY KEY (id),
  CONSTRAINT fk_sSmU FOREIGN KEY (username) REFERENCES Stadium_Manager(username)
)

CREATE TABLE Club
(
  name VARCHAR(20) NOT NULL,
  id INT NOT NULL IDENTITY,
  location VARCHAR(20) NOT NULL,
  crUsername VARCHAR(20),
  PRIMARY KEY (id),
  CONSTRAINT fk_cCrU FOREIGN KEY (crUsername) REFERENCES Club_representative(username)
)

CREATE TABLE Host_request
(
  id INT NOT NULL IDENTITY,
  status VARCHAR(20) DEFAULT 'Pending',
  match_id INT NOT NULL,
  username VARCHAR(20),
  crUsername VARCHAR(20),
  PRIMARY KEY (id),
  CONSTRAINT fk_hrSmU FOREIGN KEY (username) REFERENCES Stadium_Manager(username),
  CONSTRAINT fk_hrCrU FOREIGN KEY (crUsername) REFERENCES Club_representative(username)
)

CREATE TABLE Match
(
  id INT NOT NULL IDENTITY,
  start_time DATETIME NOT NULL,
  end_time DATETIME NOT NULL,
  plays_as_guestid INT,
  plays_as_hostid INT,
  sID INT,
  PRIMARY KEY (id),
  CONSTRAINT fk_mCgid FOREIGN KEY (plays_as_guestid) REFERENCES Club(id),
  CONSTRAINT fk_mChid FOREIGN KEY (plays_as_hostid) REFERENCES Club(id),
  CONSTRAINT fk_mSid FOREIGN KEY (sID) REFERENCES Stadium(id)
)

CREATE TABLE Ticket
(
  status BIT NOT NULL,
  id INT NOT NULL IDENTITY,
  mID INT,
  Fusername VARCHAR(20),
  PRIMARY KEY (id),
  CONSTRAINT fk_tMid FOREIGN KEY (mID) REFERENCES Match(id),
  CONSTRAINT fk_tFSmU  FOREIGN KEY (Fusername) REFERENCES Fan(username)
)
GO


GO
CREATE PROCEDURE dropAllTables
AS

DROP TABLE dbo.Ticket
DROP TABLE dbo.Match
DROP TABLE dbo.Host_request
DROP TABLE dbo.Club
DROP TABLE dbo.Stadium
DROP TABLE dbo.System_Admin
DROP TABLE dbo.Sports_Association_Manager
DROP TABLE dbo.Fan
DROP TABLE dbo.Club_representative
DROP TABLE dbo.Stadium_Manager
DROP TABLE dbo.SystemUser

GO
CREATE PROCEDURE dropAllProceduresFunctionsViews
AS

-- PROCEDURES

DROP PROCEDURE acceptRequest
DROP PROCEDURE addAssociationManager
DROP PROCEDURE addClub
DROP PROCEDURE addFan
DROP PROCEDURE addHostRequest
DROP PROCEDURE addNewMatch
DROP PROCEDURE addRepresentative
DROP PROCEDURE addStadium
DROP PROCEDURE addStadiumManager
DROP PROCEDURE addTicket
DROP PROCEDURE blockFan
DROP PROCEDURE clearAllTables
DROP PROCEDURE createAllTables
DROP PROCEDURE dropAllTables
DROP PROCEDURE deleteStadium
DROP PROCEDURE deleteClub
DROP PROCEDURE deleteMatch
DROP PROCEDURE deleteMatchesOnStadium
DROP PROCEDURE purchaseTicket
DROP PROCEDURE rejectRequest
DROP PROCEDURE unblockFan
DROP PROCEDURE updateMatchHost

-- VIEWS

DROP VIEW allAssocManagers
DROP VIEW allClubRepresentatives
DROP VIEW allClubs
DROP VIEW allFans
DROP VIEW allMatches
DROP VIEW allRequests
DROP VIEW allStadiumManagers
DROP VIEW allStadiums
DROP VIEW allTickets
DROP VIEW clubsWithNoMatches
DROP VIEW matchesPerTeam
DROP VIEW clubsNeverMatched

-- FUNCTIONS
DROP FUNCTION allUnassignedMatches
DROP FUNCTION allPendingRequests
DROP FUNCTION viewAvailableStadiumsOn
DROP FUNCTION upcomingMatchesOfClub
DROP FUNCTION availableMatchesToAttend
DROP FUNCTION clubsNeverPlayed
DROP FUNCTION matchWithHighestAttendance
DROP FUNCTION matchesRankedByAttendance
DROP FUNCTION requestsFromClub

GO
CREATE PROCEDURE clearAllTables
AS

ALTER TABLE dbo.Club DROP CONSTRAINT fk_cCrU
ALTER TABLE dbo.Club_representative DROP CONSTRAINT fk_crU
ALTER TABLE dbo.Fan DROP CONSTRAINT fk_fSmU
ALTER TABLE dbo.Host_request DROP CONSTRAINT fk_hrCrU
ALTER TABLE dbo.Host_request DROP CONSTRAINT fk_hrSmU
ALTER TABLE dbo.Match DROP CONSTRAINT fk_mCgid
ALTER TABLE dbo.Match DROP CONSTRAINT fk_mChid
ALTER TABLE dbo.Match DROP CONSTRAINT fk_mSid
ALTER TABLE dbo.Sports_Association_Manager DROP CONSTRAINT fk_samSmU
ALTER TABLE dbo.Stadium DROP CONSTRAINT fk_sSmU
ALTER TABLE dbo.Stadium_Manager DROP CONSTRAINT fk_smU
ALTER TABLE dbo.System_Admin DROP CONSTRAINT fk_saSmu
ALTER TABLE dbo.Ticket DROP CONSTRAINT fk_tFSmU
ALTER TABLE dbo.Ticket DROP CONSTRAINT fk_tMid

TRUNCATE TABLE dbo.Club
TRUNCATE TABLE dbo.Match
TRUNCATE TABLE dbo.Stadium
TRUNCATE TABLE dbo.Club_representative
TRUNCATE TABLE dbo.Fan
TRUNCATE TABLE dbo.Stadium_Manager
TRUNCATE TABLE dbo.SystemUser
TRUNCATE TABLE dbo.Sports_Association_Manager
TRUNCATE TABLE dbo.System_Admin
TRUNCATE TABLE dbo.Host_request
TRUNCATE TABLE dbo.Ticket

ALTER TABLE Stadium_Manager ADD CONSTRAINT fk_smU FOREIGN KEY (username) REFERENCES SystemUser(username)
ALTER TABLE Club_representative ADD CONSTRAINT fk_crU FOREIGN KEY (username) REFERENCES SystemUser(username)
ALTER TABLE Fan ADD CONSTRAINT fk_fSmU FOREIGN KEY (username) REFERENCES SystemUser(username)
ALTER TABLE Sports_Association_Manager ADD CONSTRAINT fk_samSmU FOREIGN KEY (username) REFERENCES SystemUser(username)
ALTER TABLE System_Admin ADD CONSTRAINT fk_saSmu FOREIGN KEY (username) REFERENCES SystemUser(username)
ALTER TABLE Stadium ADD CONSTRAINT fk_sSmU FOREIGN KEY (username) REFERENCES Stadium_Manager(username)
ALTER TABLE Club ADD CONSTRAINT fk_cCrU FOREIGN KEY (crUsername) REFERENCES Club_representative(username)
ALTER TABLE Host_request ADD CONSTRAINT fk_hrSmU FOREIGN KEY (username) REFERENCES Stadium_Manager(username)
ALTER TABLE Host_request ADD CONSTRAINT fk_hrCrU FOREIGN KEY (crUsername) REFERENCES Club_representative(username)
ALTER TABLE MATCH ADD CONSTRAINT fk_mCgid FOREIGN KEY (plays_as_guestid) REFERENCES Club(id)
ALTER TABLE MATCH ADD CONSTRAINT fk_mChid FOREIGN KEY (plays_as_hostid) REFERENCES Club(id)
ALTER TABLE MATCH ADD CONSTRAINT fk_mSid FOREIGN KEY (sID) REFERENCES Stadium(id)
ALTER TABLE Ticket ADD CONSTRAINT fk_tMid FOREIGN KEY (mID) REFERENCES Match(id)
ALTER TABLE Ticket ADD CONSTRAINT fk_tFSmU  FOREIGN KEY (Fusername) REFERENCES Fan(username)


-- 2.2

GO
CREATE VIEW allAssocManagers
AS
  SELECT SAM.username AS 'SAM username' , SU.password AS 'SU Password' , SAM.name AS 'SAM name'
  FROM Sports_Association_Manager SAM , SystemUser SU
  WHERE SAM.username = SU.username


GO
CREATE VIEW allClubRepresentatives
AS
  SELECT CR.username AS 'CR username' , SU.password AS 'SU Password' , CR.name AS 'CR name'  , C.name AS 'C name'
  FROM Club_representative CR , Club C , SystemUser SU
  WHERE CR.username = C.crUsername AND CR.username = SU.username


GO
CREATE VIEW allStadiumManagers
AS
  SELECT SM.username AS 'SM username', SU.password AS 'SU Password' , SM.name AS 'SM name' , S.name
  FROM Stadium_Manager SM , Stadium S , SystemUser SU
  WHERE SM.username = S.username AND SM.username = SU.username


GO
CREATE VIEW allFans
AS
  SELECT SU.username AS 'Username' , SU.password AS 'Password' , F.name AS 'name', F.national_id AS 'national_id' , F.birth_date AS 'birth_date' , F.status AS 'status'
  FROM Fan F, SystemUser SU
  WHERE F.username = SU.username


GO
CREATE VIEW allMatches
AS
  SELECT CH.name AS 'Host Club' , CG.name AS 'Guest Club' , M.start_time AS 'StartsAt' , M.end_time AS 'EndsAt'
  FROM Match M , Club CG , Club CH
  WHERE M.plays_as_guestid = CG.id AND M.plays_as_hostid = CH.id


GO
CREATE VIEW allTickets
AS
  SELECT CH.name AS 'hostClub' , CG.name AS 'guestClub' , S.name AS 'stadiumName', M.start_time AS 'startsAt'
  FROM Club CG , Club CH , Stadium S , Match M , Ticket T
  WHERE M.plays_as_guestid = CG.id AND M.plays_as_hostid = CH.id AND M.sID = S.id AND T.mID = M.id AND T.status = 1



GO
CREATE VIEW allClubs
AS
  SELECT name AS 'Club name' , location AS 'Club location'
  FROM Club


GO
CREATE VIEW allStadiums
AS
  SELECT name AS 'Stadium name' , location AS 'Stadium location' , capacity AS 'Stadium capacity' , status AS 'Stadium status'
  FROM Stadium


GO
CREATE VIEW allRequests
AS
  SELECT CR.username AS 'CR Username' , SM.username AS 'SM Username' , HR.status AS 'HR status'
  FROM Host_request HR , Club_representative CR , Stadium_Manager SM
  WHERE HR.crUsername = CR.username AND HR.username = SM.username 

-- 2.3

GO
CREATE PROCEDURE addAssociationManager
  @name VARCHAR(20),
  @username VARCHAR(20),
  @password VARCHAR(20)
AS
INSERT INTO SystemUser
  (username , password)
VALUES
  (@username , @password)

INSERT INTO Sports_Association_Manager
  (name , username)
VALUES
  (@name , @username)


GO
CREATE PROCEDURE addNewMatch
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20),
  @start_datetime DATETIME,
  @end_datetime DATETIME
AS

DECLARE @host_club_id INT
DECLARE @host_club_location VARCHAR(20)
DECLARE @guest_club_id INT

SELECT @host_club_id = id
FROM Club
WHERE @host_name = name


SELECT @host_club_location = location
FROM Club
WHERE @host_name = name

SELECT @guest_club_id = id
FROM Club
WHERE @guest_name = name

INSERT INTO Match
  (start_time , end_time, plays_as_guestid , plays_as_hostid , sID)
VALUES
  (@start_datetime, @end_datetime , @guest_club_id , @host_club_id , null)


GO
CREATE VIEW clubsWithNoMatches
AS
      SELECT C.name AS 'Club Name'
    FROM Match M , Club C
  EXCEPT
    (
    SELECT C1.name
    FROM Club C1 , Match M1
    WHERE (C1.id = m1.plays_as_guestid) OR (C1.id = m1.plays_as_hostid)
)

GO
CREATE PROCEDURE deleteMatch
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20)
AS
DECLARE @host_club_id INT
DECLARE @guest_club_id INT
DECLARE @match_id INT

SELECT @host_club_id = id
FROM Club
WHERE @host_name = name

SELECT @guest_club_id = id
FROM Club
WHERE @guest_name = name

SELECT @match_id = id
FROM Match
WHERE (plays_as_hostid = @host_club_id) AND ( plays_as_guestid = @guest_club_id)

DELETE Ticket
WHERE mID = @match_id

delete from Match 
where @match_id = id


GO
CREATE PROCEDURE deleteMatchesOnStadium
  @stadium_name VARCHAR(20)
AS

DECLARE @stadium_id INT
DECLARE @match_id INT

SELECT @stadium_id = id
FROM Stadium
WHERE name = @stadium_name

SELECT @match_id = id
FROM Match
WHERE sID = @stadium_id AND (start_time > GETDATE())

UPDATE Ticket
SET mID = NULL
WHERE mID = @match_id

DELETE
FROM Match 
WHERE @match_id = id


GO
CREATE PROCEDURE addClub
  @club_name VARCHAR(20),
  @club_location VARCHAR(20)
AS
INSERT INTO Club
  (name , location)
VALUES
  (@club_name , @club_location)
GO


CREATE PROCEDURE addTicket
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20),
  @datetime DATETIME
AS

DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT

SELECT @host_id = id
FROM Club
WHERE @host_name = name

SELECT @guest_id = id
FROM Club
WHERE @guest_name = name

SELECT @match_id = id
FROM Match
WHERE @guest_id = plays_as_guestid AND @host_id = plays_as_hostid AND @datetime = start_time

INSERT INTO Ticket
  (status , mID )
VALUES
  (1 , @match_id)


GO
CREATE PROCEDURE deleteClub
  @club_name VARCHAR(20)
AS

DECLARE @club_id INT
DECLARE @match_id INT

SELECT @club_id = id
FROM Club
where @club_name = name

SELECT @match_id = id
FROM Match
WHERE plays_as_guestid = @club_id OR plays_as_hostid = @club_id

DELETE Ticket
WHERE mID = @match_id

DELETE Match 
WHERE id = @match_id

DELETE FROM Club WHERE 
  (name = @club_name)


GO
CREATE PROCEDURE addStadium
  @stadium_name VARCHAR(20),
  @stadium_location VARCHAR(20),
  @capacity INT
AS
INSERT INTO Stadium
  (name , capacity , location , status)
VALUES
  (@stadium_name , @capacity , @stadium_location , 1)


GO
CREATE PROCEDURE deleteStadium
  @stadium_name VARCHAR(20)
AS

DECLARE @stadium_id INT

SELECT @stadium_id = id
FROM Stadium
WHERE name = @stadium_name

UPDATE Match
SET sID = NULL
WHERE sID = @stadium_id

DELETE FROM Stadium WHERE 
  (id = @stadium_id)


GO
CREATE PROCEDURE blockFan
  @fan_id VARCHAR(20)
AS
UPDATE Fan
SET status = 0 WHERE national_id = @fan_id


GO
CREATE PROCEDURE unblockFan
  @fan_id VARCHAR(20)
AS
UPDATE Fan
SET status = 1 WHERE national_id = @fan_id


GO
CREATE PROCEDURE addRepresentative
  @name VARCHAR(20),
  @club_name VARCHAR(20),
  @username VARCHAR(20),
  @password VARCHAR(20)
AS

UPDATE Club
SET crUsername = @username
WHERE name = @club_name

INSERT INTO SystemUser
  (username , password)
VALUES
  (@username , @password)

INSERT INTO Club_representative
  (name , username )
VALUES
  (@name, @username )


GO
CREATE FUNCTION viewAvailableStadiumsOn (@datetime DATETIME)
RETURNS @tempTable TABLE
(
  name VARCHAR(20),
  location VARCHAR(20),
  capacity INT,
  avaiableOn DATETIME
  )
AS
BEGIN

  INSERT INTO @tempTable
    (name , location , capacity, avaiableOn)
  SELECT S.name AS 'Name' , S.location AS 'Location' , S.capacity AS 'Capacity' , M.start_time AS 'avaiableOn'
  FROM Stadium S, Match M
  WHERE status = 1 AND M.start_time >= @datetime


  RETURN
END


GO
CREATE PROCEDURE addHostRequest
  @club_name VARCHAR(20),
  @stadium_name VARCHAR(20),
  @datetime DATETIME
AS

DECLARE @club_id INT
DECLARE @stadium_id INT
DECLARE @match_id INT
DECLARE @cr_username VARCHAR(20)
DECLARE @sm_username VARCHAR(20)

SELECT @club_id = id
FROM Club
WHERE @club_name = name

SELECT @stadium_id = id
FROM Stadium
WHERE @stadium_name = name

SELECT @match_id = id
FROM Match
WHERE @datetime = start_time AND (@club_id = plays_as_guestid OR @club_id = plays_as_hostid)

SELECT @cr_username = crUsername
FROM Club
WHERE @club_id = id

SELECT @sm_username = username
FROM Stadium
WHERE @stadium_id = id

INSERT INTO Host_request
  (match_id , username , crUsername , status)
VALUES
  (@match_id , @sm_username , @cr_username , 'Pending')


GO
CREATE FUNCTION allUnassignedMatches (@club_name VARCHAR(20)) 
RETURNS @tempTable TABLE
(
  guest_name VARCHAR(20),
  start_time DATETIME
)
AS
BEGIN

  INSERT INTO @tempTable
    (guest_name , start_time)
  SELECT CG.name AS 'Guest Name' , M.start_time AS 'Start Time'
  FROM Match M , Club CH , Club CG
  WHERE @club_name = CH.name AND CH.id = M.plays_as_hostid AND
    CG.id =  M.plays_as_guestid AND M.sID = NULL

  RETURN
END


GO
CREATE PROCEDURE addStadiumManager
  @name VARCHAR(20),
  @stadium_name VARCHAR(20),
  @username VARCHAR(20),
  @password VARCHAR(20)
AS

UPDATE Stadium
SET username = @username
WHERE name = @stadium_name

INSERT INTO SystemUser
  (username , password)
VALUES
  (@username , @password)

INSERT INTO Stadium_Manager
  (name , username )
VALUES
  (@name, @username )


GO
CREATE FUNCTION allPendingRequests (@sm_username VARCHAR(20))
RETURNS @tempTable TABLE
(
  crNameP VARCHAR(20),
  hostClubNameP VARCHAR(20),
  guestClubNameP VARCHAR(20),
  startTimeP DATETIME,
  endTimeP DATETIME,
  status VARCHAR(20)
)
AS
BEGIN

  INSERT INTO @tempTable
    (crNameP ,hostClubNameP, guestClubNameP , startTimeP , endTimeP , status)
  SELECT CR.name , CH.name , CG.name , M.start_time , M.end_time , HR.status
  FROM Stadium_Manager SM , Club_representative CR , Host_request HR , Club CH , Club CG , Match M
  WHERE HR.username = @sm_username AND
    HR.crUsername = CR.username AND
    CH.crUsername = HR.crUsername AND
    M.plays_as_hostid = CH.id AND
    M.plays_as_guestid = CG.id AND
    HR.match_id = M.id AND
    HR.status = 'Pending'

  RETURN
END


GO
CREATE FUNCTION RequestsFromAll (@sm_username VARCHAR(20))
RETURNS @tempTable TABLE
(
  crName VARCHAR(20),
  hostClubName VARCHAR(20),
  guestClubName VARCHAR(20),
  startTime DATETIME,
  endTime DATETIME,
  status VARCHAR(20)
)
AS
BEGIN

  INSERT INTO @tempTable
    (crName ,hostClubName, guestClubName , startTime , endTime , status)
  SELECT CR.name , CH.name , CG.name , M.start_time , M.end_time , HR.status
  FROM Stadium_Manager SM , Club_representative CR , Host_request HR , Club CH , Club CG , Match M
  WHERE HR.username = @sm_username AND
    HR.crUsername = CR.username AND
    CH.crUsername = HR.crUsername AND
    M.plays_as_hostid = CH.id AND
    M.plays_as_guestid = CG.id AND
    HR.match_id = M.id

  RETURN
END


GO
CREATE PROCEDURE acceptRequest
  @sm_username VARCHAR(20),
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20),
  @start_time DATETIME
AS

DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT
DECLARE @stadium_id INT
DECLARE @capacity INT
DECLARE @index INT

SELECT @host_id = id
FROM Club
WHERE @host_name = name

SELECT @guest_id = id
FROM Club
WHERE @guest_name = name

SELECT @match_id = id
FROM Match
WHERE @guest_id = plays_as_guestid AND @host_id = plays_as_hostid AND @start_time = start_time

SELECT @stadium_id = id , @capacity = capacity
FROM Stadium
WHERE username = @sm_username


UPDATE Match
SET sID = @stadium_id
WHERE @match_id = id

SET @index = 0
WHILE @index < @capacity
  BEGIN
  EXECUTE addTicket @host_name , @guest_name , @start_time
  SET @index = @index + 1
END;

UPDATE Host_request
SET status = 'Accepted' 
WHERE @match_id = match_id AND @sm_username = username


GO
CREATE PROCEDURE rejectRequest
  @sm_username VARCHAR(20),
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20),
  @start_time DATETIME
AS

DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT

SELECT @host_id = id
FROM Club
WHERE @host_name = name

SELECT @guest_id = id
FROM Club
WHERE @guest_name = name

SELECT @match_id = id
FROM Match
WHERE @guest_id = plays_as_guestid AND @host_id = plays_as_hostid AND @start_time = start_time

UPDATE Host_request
SET status = 'Rejected'
WHERE @match_id = match_id AND @sm_username = username


GO
CREATE PROCEDURE addFan
  @name VARCHAR(20),
  @national_id_number VARCHAR(20),
  @birth_date DATETIME,
  @address VARCHAR(20),
  @phone_number VARCHAR(20),
  @username VARCHAR(20),
  @password VARCHAR(20)
AS
INSERT INTO SystemUser
  (username , password)
VALUES
  (@username , @password)

insert into Fan
  (username, national_id , address , name , phone_No , birth_date , status)
VALUES
  (@username, @national_id_number , @address , @name , @phone_number , @birth_date , 1)

GO
CREATE FUNCTION upcomingMatchesOfClub (@cname varchar(20))
RETURNS @match TABLE (
  host varchar(20),
  guest varchar(20),
  starttime datetime,
  endtime datetime,
  stad varchar(20))
AS
BEGIN
  INSERT INTO @match
    (host,guest,starttime,endtime, stad)
  SELECT C1.name AS Host, C2.name AS Guest, M.start_time, M.end_time, S.name
  FROM Match M INNER JOIN Club C1 ON M.plays_as_hostid=C1.id
    INNER JOIN Club C2 ON M.plays_as_guestid=C2.ID, Stadium S
  WHERE (C1.name=@cname or c2.name=@cname) and M.start_time>GETDATE() and M.sID IS NOT NULL;

  INSERT INTO @match
    (host,guest,starttime,endtime)
  SELECT C1.name AS Host, C2.name AS Guest, M.start_time, M.end_time
  FROM Match M INNER JOIN Club C1 ON M.plays_as_hostid=C1.id
    INNER JOIN Club C2 ON M.plays_as_guestid=C2.ID
  WHERE (C1.name=@cname or c2.name=@cname) and M.start_time>GETDATE() and M.sID IS NULL;

  RETURN;
END;


GO
CREATE FUNCTION availableMatchesToAttend (@dateTime DATETIME)
RETURNS @tempTable TABLE 
(
  host_club VARCHAR (20),
  guest_club VARCHAR (20),
  start_time DATETIME,
  stadium VARCHAR (20),
  location VARCHAR (20)
)
AS
BEGIN
  INSERT INTO @tempTable
    (host_club , guest_club , start_time , stadium , location)
  SELECT CH.name, CG.name, M.start_time,S.name , S.location
  FROM MATCH M, STADIUM S , Ticket T , Club CH , Club CG
  WHERE M.start_time >= @dateTime AND T.mID = M.id AND T.status = 1 AND M.plays_as_hostid = CH.id AND M.plays_as_guestid = CG.id

  RETURN
END


GO
CREATE PROCEDURE purchaseTicket
  @national_id VARCHAR(20),
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20),
  @start_time DATETIME
AS
DECLARE @fan_username VARCHAR(20)
DECLARE @fan_status BIT
DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT
DECLARE @ticket_id INT

SELECT @fan_username = username , @fan_status = status
FROM Fan
WHERE @national_id = national_id


BEGIN
  SELECT @host_id = id
  FROM Club
  WHERE @host_name = name

  SELECT @guest_id = id
  FROM Club
  WHERE @guest_name = name

  SELECT @match_id = id
  FROM Match
  WHERE @guest_id = plays_as_guestid AND @host_id = plays_as_hostid AND @start_time = start_time

  SET @ticket_id = 
(
  SELECT TOP 1
    id
  FROM Ticket
  WHERE status = 1 AND mID = @match_id
)

  UPDATE Ticket
SET status = 0 , Fusername = @fan_username 
WHERE @ticket_id = id
END



GO
CREATE PROCEDURE updateMatchHost
  @host_name VARCHAR(20),
  @guest_name VARCHAR(20),
  @start_time DATETIME
AS

DECLARE @host_id INT
DECLARE @guest_id INT
DECLARE @match_id INT
DECLARE @new_host_id INT
DECLARE @new_guest_id INT
DECLARE @new_host_location INT

SELECT @host_id = id
FROM Club
WHERE @host_name = name

SELECT @guest_id = id
FROM Club
WHERE @guest_name = name

SELECT @match_id = id
FROM Match
WHERE @guest_id = plays_as_guestid AND @host_id = plays_as_hostid AND @start_time = start_time

SET @new_host_id = @guest_id
SET @new_guest_id = @host_id
SELECT @new_host_location = location
FROM Club
WHERE @new_host_id = id

UPDATE Match 
SET plays_as_hostid = @new_host_id , plays_as_guestid = @new_guest_id , sID = @new_host_location
WHERE plays_as_hostid = @host_id AND plays_as_guestid = @guest_id


GO
CREATE VIEW matchesPerTeam
AS
  SELECT C.name AS 'C Name' , COUNT(M.id) AS 'M Played'
  FROM Club C , Match M
  WHERE  (C.id = M.plays_as_guestid ) OR (C.id = M.plays_as_hostid) AND getdate() > M.start_time
  GROUP BY C.name
  

GO
CREATE VIEW clubsNeverMatched
AS
      SELECT C1.name AS 'C1 Name', C2.name AS 'C2 Name'
    FROM Club C1 , Club C2 , Match M
    WHERE C1.id > C2.id
  EXCEPT
    (
    SELECT C1.name AS 'C1 Name', C2.name AS 'C2 Name'
    FROM Club C1 , Club C2 , Match M
    WHERE ((C1.id = M.plays_as_guestid AND C2.id = M.plays_as_hostid) OR
      (C1.id = M.plays_as_hostid AND C2.id = M.plays_as_guestid)) AND M.start_time < GETDATE() 
)


GO
CREATE FUNCTION clubsNeverPlayed (@club_name VARCHAR(20))
RETURNS @tempTable TABLE
(
  club_name VARCHAR(20)
)
AS
BEGIN

  DECLARE @club_id INT
  SELECT @club_id = id
  FROM Club
  WHERE @club_name = name

  INSERT INTO @tempTable
  SELECT name AS club_name
  FROM Club
  WHERE @club_name <> name AND
    NOT EXISTS
  (
    SELECT *
    FROM Club C , Match M
    WHERE (M.plays_as_guestid = @club_id AND C.id = M.plays_as_hostid)
      OR (M.plays_as_hostid = @club_id AND C.id = M.plays_as_guestid)
  )

  RETURN
END


GO
CREATE FUNCTION matchWithHighestAttendance ()
RETURNS @tempTable TABLE
(
  host_name VARCHAR(20),
  guest_name VARCHAR(20)
)
AS
BEGIN

  INSERT INTO @tempTable
    (host_name , guest_name)
  SELECT CH.name , CG.name
  FROM Club CH , Club CG , Match M , Ticket T
  WHERE CH.id = M.plays_as_hostid AND CG.id = M.plays_as_guestid AND T.mID IN (
SELECT TOP 1
      mID
    FROM Ticket
    WHERE status = 0
    GROUP BY mID
    ORDER BY COUNT(id) DESC
)

  RETURN
END 


GO
CREATE FUNCTION matchesRankedByAttendance ()
RETURNS @tempTable TABLE
(
  host_name VARCHAR(20),
  guest_name VARCHAR(20)
)
AS
BEGIN

  INSERT INTO @tempTable
    (host_name , guest_name)
  SELECT CH.name , CG.name
  FROM Club CH , Club CG , Match M , Ticket T
  WHERE CH.id = M.plays_as_hostid AND CG.id = M.plays_as_guestid AND T.status = 0 AND M.id = T.mID
  GROUP BY CH.name , CG.name
  ORDER BY COUNT(T.id) DESC

  RETURN
END 


GO
CREATE FUNCTION requestsFromClub (@stadium_name VARCHAR(20) , @club_name VARCHAR(20))
RETURNS @tempTable TABLE
(
  host_name VARCHAR(20),
  guest_name VARCHAR(20)
)
AS
BEGIN

  INSERT INTO @tempTable
    (host_name , guest_name)
  SELECT CH.name , CG.name
  FROM Stadium S , Match M , Host_request HR , Club CS , Club CH , Club CG
  WHERE S.name = @stadium_name AND M.sID = S.id AND
    CH.id = M.plays_as_hostid AND CG.id = M.plays_as_guestid AND
    CS.name = @club_name AND CS.crUsername = HR.crUsername

  RETURN
END 
GO

