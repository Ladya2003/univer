--1. db13 connection sys - 12345Sys - creation of ADMIN user


ALTER SESSION SET "_ORACLE_SCRIPT"=true


CREATE TABLESPACE TS_USER
    DATAFILE 'TS_foruser_cdb.dbf'
    SIZE 7M
    AUTOEXTEND ON NEXT 5M
    MAXSIZE 20M
    EXTENT MANAGEMENT LOCAL;
    
CREATE TEMPORARY TABLESPACE  TS_USER_TEMP
    TEMPFILE 'TS_foruser_temp_cdb.dbf'
    SIZE 5M
    AUTOEXTEND ON NEXT 3M
    MAXSIZE 30M
    EXTENT MANAGEMENT LOCAL;
    
CREATE ROLE RL_ADMINCORE;

grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view,
      drop any procedure 
to RL_ADMINCORE;
GRANT CREATE ROLE TO RL_ADMINCORE;
GRANT CREATE USER TO RL_ADMINCORE;
GRANT GRANT ANY PRIVILEGE TO RL_ADMINCORE;


drop role rl_usercore;
CREATE ROLE RL_USERCORE;
grant create procedure,
drop any procedure,
create table,
drop any table
to RL_USERCORE;
--для курсача
CREATE ROLE RL_USERCORE;
GRANT CREATE SESSION TO RL_USERCORE;
GRANT EXECUTE ON AddNewOrder TO RL_USERCORE;
GRANT EXECUTE ON UpdateIsTestDriveToZero TO RL_USERCORE;
GRANT EXECUTE ON UpdateQuantity TO RL_USERCORE;
GRANT EXECUTE ON getallcarinfo TO RL_USERCORE;
GRANT EXECUTE ON UpdateQuantity TO RL_USERCORE;
GRANT EXECUTE ON UpdateQuantityDecrement TO RL_USERCORE;



GRANT EXECUTE ON UpdateIsTestDrive TO RL_USERCORE;
GRANT UPDATE ON OrderTable to RL_USERCORE;
GRANT SELECT ON ADMINCORE.OrderTable to RL_USERCORE;
GRANT SELECT ON ADMINCORE.Client to RL_USERCORE;
GRANT SELECT ON ADMINCORE.Account to RL_USERCORE;

GRANT EXECUTE ON UpdateIsTestDriveToZero TO RL_USERCORE;
GRANT EXECUTE ON UpdateQuantity TO RL_USERCORE;
GRANT EXECUTE ON UpdateQuantityDecrement TO RL_USERCORE;

GRANT EXECUTE ON getallcarinfo TO RL_USERCORE;
GRANT SELECT ON Car TO RL_USERCORE;
GRANT SELECT ON Equipment TO RL_USERCORE;
GRANT SELECT ON EquipmentList TO RL_USERCORE;
GRANT SELECT ON Supplier TO RL_USERCORE;

GRANT SELECT ON USERCORE.Client to RL_ADMINCORE;
GRANT SELECT ON USERCORE.Car to RL_ADMINCORE;
commit;


CREATE PROFILE PF_ADMINCORE LIMIT
    PASSWORD_LIFE_TIME 180
    SESSIONS_PER_USER 5
    FAILED_LOGIN_ATTEMPTS 7
    PASSWORD_LOCK_TIME 1
    PASSWORD_REUSE_TIME 10
    PASSWORD_GRACE_TIME DEFAULT
    CONNECT_TIME 180
    IDLE_TIME 30;
    
create user ADMINCORE identified by 12345
default tablespace TS_USER quota unlimited on TS_USER
temporary tablespace TS_USER_TEMP
profile PF_ADMINCORE
account unlock;

create user USERCORE identified by 12345
default tablespace TS_USER quota unlimited on TS_USER
temporary tablespace TS_USER_TEMP
profile PF_ADMINCORE
account unlock;

grant RL_ADMINCORE to ADMINCORE;
grant RL_USERCORE to USERCORE;


--2. db13 ADMINCORE-12345 - creation of the main infrastructure

-- Создание таблицы Client
CREATE TABLE Client (
  id INT PRIMARY KEY,
  name VARCHAR(40),
  surname VARCHAR(40),
  age INT,
  email VARCHAR(50)
) TABLESPACE TS_USER;

-- Создание таблицы Account
CREATE TABLE Account (
  id INT PRIMARY KEY,
  idClient INT,
  login VARCHAR(40),
  password VARCHAR(40),
  FOREIGN KEY (idClient) REFERENCES Client(id)
) TABLESPACE TS_USER;

-- Создание таблицы EquipmentList
CREATE TABLE EquipmentList (
  id INT PRIMARY KEY,
  description VARCHAR2(40)
) TABLESPACE TS_USER;

-- Создание таблицы Supplier
CREATE TABLE Supplier (
  id INT PRIMARY KEY,
  company_name VARCHAR(40),
  email VARCHAR(40)
) TABLESPACE TS_USER;

-- Создание таблицы Car
drop table car;
drop table Equipment;
drop table OrderTable;

CREATE TABLE Car (
  id INT PRIMARY KEY,
  idSupplier INT,
  imgSource varchar(40),
  brand VARCHAR(40),
  model VARCHAR(40),
  color VARCHAR(40),
  weight FLOAT,
  cost FLOAT,
  carRating int,
  FOREIGN KEY (idSupplier) REFERENCES Supplier(id),
  CONSTRAINT CHK_Rating CHECK (carRating IN (1, 2, 3, 4, 5))
) TABLESPACE TS_USER;
--alter table car add carRating int;
--ALTER TABLE car ADD CONSTRAINT CHK_Rating CHECK (carRating IN (1, 2, 3, 4, 5));
--ALTER TABLE car drop CONSTRAINT CHK_Rating; 
--alter table car drop column idEquipment;
commit;

-- Создание таблицы Equipment
CREATE TABLE Equipment (
  id INT PRIMARY KEY,
  idEquipmentList INT,
  idCar int,
  FOREIGN KEY (idEquipmentList) REFERENCES EquipmentList(id),
  FOREIGN KEY (idCar) REFERENCES Car(id)
) TABLESPACE TS_USER;
--alter table Equipment drop column value;
--alter table Equipment add idCar int;
--ALTER TABLE Equipment ADD CONSTRAINT fk_Equipment_Car FOREIGN KEY (idCar) REFERENCES Car(id);
select * from Equipment;

-- Создание таблицы Order
CREATE TABLE OrderTable (
  id INT PRIMARY KEY,
  idClient INT,
  idCar INT,
  quantity INT,
  IsTestDrive number(1),
  FOREIGN KEY (idClient) REFERENCES ADMINCORE.Client(id),
  FOREIGN KEY (idCar) REFERENCES ADMINCORE.Car(id),
  CONSTRAINT CHK_IsTestDrive CHECK (IsTestDrive IN (0, 1))
) TABLESPACE TS_USER;
--ALTER TABLE ADMINCORE.OrderTable
--MODIFY (idClient INT REFERENCES USERCORE.Client(id),
        --idCar INT REFERENCES USERCORE.Car(id));

drop table OrderTable;

--create table Client (
    --id INT PRIMARY KEY
--) TABLESPACE TS_USER;
--create table Car (
    --id INT PRIMARY KEY
--) TABLESPACE TS_USER;

--3) db13 ADMINCORE-12345 - insertion of all data  

INSERT ALL
    INTO Client (id, name, surname, age, email) VALUES (1, 'John', 'Doe', 30, 'john.doe@gmail.com')
    INTO Client (id, name, surname, age, email) VALUES (2, 'Jane', 'Smith', 25, 'jane.smith@gmail.com')
    INTO Client (id, name, surname, age, email) VALUES (3, 'Michael', 'Johnson', 35, 'michael.johnson@gmail.com')
    INTO Client (id, name, surname, age, email) VALUES (4, 'Emma', 'Williams', 28, 'emma.williams@gmail.com')
    INTO Client (id, name, surname, age, email) VALUES (5, 'David', 'Brown', 32, 'david.brown@gmail.com')
    INTO Client (id, name, surname, age, email) VALUES 6, 'admin', '', 100, '')
SELECT * FROM DUAL;    
commit;       
SELECT * FROM Client order by id;  
--DELETE FROM Client WHERE id = 7;


INSERT ALL
    INTO Account (id, idClient, login, password) values (1, 1, 'john', '123')
    INTO Account (id, idClient, login, password) values (2, 2, 'jane', '123')
    INTO Account (id, idClient, login, password) values (3, 3, 'michael', '123')
    INTO Account (id, idClient, login, password) values (4, 4, 'emma', '123')
    INTO Account (id, idClient, login, password) values (5, 5, 'david', '123')
    INTO Account (id, idClient, login, password) values (6, 6, 'admin', '123')
commit;
select * from Account order by id;
--delete from Account where id = 7;
--DELETE FROM Account WHERE id = 6;


INSERT ALL
    INTO EquipmentList (id, description) VALUES (1, 'Seats')
    INTO EquipmentList (id, description) VALUES (2, 'Roof')
    INTO EquipmentList (id, description) VALUES (3, 'Camera')
    INTO EquipmentList (id, description) VALUES (4, 'Radio')
select * from dual;   
commit;
select * from EquipmentList;       
      

INSERT ALL
    INTO Equipment (id, idEquipmentList, idCar) VALUES (1, 1, 1)
    INTO Equipment (id, idEquipmentList, idCar) VALUES (2, 2, 1)
    INTO Equipment (id, idEquipmentList, idCar) VALUES (3, 3, 2)
    INTO Equipment (id, idEquipmentList, idCar) VALUES (4, 4, 3)
select * from dual;
commit;
select * from Equipment order by id;
delete from Equipment where id = 2;
update Equipment set id = 2 where id = 8;
insert into Equipment values (5, 2, 4);
insert into Equipment values (6, 3, 5);


INSERT ALL
    INTO Supplier (id, company_name, email) VALUES (1, 'ChineseDepartment', 'chineseDepartment@gmail.com')
    INTO Supplier (id, company_name, email) VALUES (2, 'AsiaTransport', 'asiaTransport@gmail.com')
    INTO Supplier (id, company_name, email) VALUES (3, 'BelarusUnited', 'belarusUnited@gmail.com')
select * from dual;
commit;
select * from Supplier;
       

INSERT ALL
    INTO Car (id, idSupplier, idEquipment, imgSource, brand, model, color, weight, cost) VALUES (1, 1, 1, '/Assets/auto1.jpg', 'Toyota', 'Supra', 'Orange', 1500, 45000)
    INTO Car (id, idSupplier, idEquipment, imgSource, brand, model, color, weight, cost) VALUES (2, 2, 2, '/Assets/auto2.jpg', 'Chevrollet', 'Impala', 'Black', 1900, 32000)
    INTO Car (id, idSupplier, idEquipment, imgSource, brand, model, color, weight, cost) VALUES (3, 1, 3, '/Assets/auto3.jpg', 'Bugatti', 'Chiron', 'Blue', 2500, 25000000)
    INTO Car (id, idSupplier, idEquipment, imgSource, brand, model, color, weight, cost) VALUES (4, 3, 4, '/Assets/auto4.jpg', 'Dodge', 'Charger', 'Black', 2100, 35000)
    INTO Car (id, idSupplier, idEquipment, imgSource, brand, model, color, weight, cost) VALUES (5, 2, 1, '/Assets/auto5.jpg', 'Nissan', 'NFT', 'White', 1700, 120000)
select * from dual;
commit;
select * from Car order by id;
update car set carrating = 2 where id = 5;
delete from car where id = 9;


EXPLAIN PLAN FOR
select * from car c
join supplier s on s.id = c.idSupplier TABLESPACE TS_USER;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

EXPLAIN PLAN FOR
select * from car c
join ordertable o on o.idCar = c.id
join supplier s on s.id = c.idSupplier;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);


select * from equipmentlist eq
join equipment e on eq.id = e.idEquipmentList
join car c on e.idCar = c.id
where eq.id >1000 and eq.id < 1500;


SELECT index_name
FROM all_ind_columns
WHERE table_name = 'CAR' AND column_name = 'IDSUPPLIER'
UNION
SELECT index_name
FROM all_ind_columns
WHERE table_name = 'SUPPLIER' AND column_name = 'ID';

drop index idx_car_idSupplier;
drop index SYS_C008001;


CREATE INDEX idx_car_idSupplier ON car (idSupplier) TABLESPACE TS_USER;
CREATE INDEX idx_order_idCar ON ordertable (idCar) TABLESPACE TS_USER;
--CREATE INDEX idx_supplier_id ON supplier (id) TABLESPACE TS_USER;




INSERT ALL
    INTO OrderTable (id, idClient, idCar, quantity, IsTestDrive) VALUES (1, 1, 1, 2, 0)
    INTO OrderTable (id, idClient, idCar, quantity, IsTestDrive) VALUES (2, 2, 3, 1, 0)
select * from dual; 
commit;
select * from OrderTable order by id;
select * from admincore.OrderTable order by id;
delete from ordertable where id = 4;

--для нахождения индекса
select *
       from V$SQL_PLAN
      where object_name = upper('idx_idClient');
      
CREATE INDEX idx_idClient ON admincore.Account(idClient) TABLESPACE TS_USER;
drop index admincore.idx_idClient;
explain plan 
for 
select * from admincore.Account order by id;
select * from (dbms_xplan.display(format => 'ALL'));

select * from Client order by id;
SELECT index_name, visibility FROM user_indexes WHERE index_name ='idx_idClient';
SELECT * FROM v$session_longops WHERE opname LIKE '%Index%';

CREATE INDEX idx_idClient ON admincore.Account(idClient) TABLESPACE TS_USER;

CREATE INDEX idx_idSupplier ON Car(idSupplier) TABLESPACE TS_USER;

CREATE INDEX idx_idEquipmentList ON Equipment(idEquipmentList) TABLESPACE TS_USER;

CREATE INDEX idx_idCar ON Equipment(idCar) TABLESPACE TS_USER;

CREATE INDEX idx_idCar2 ON OrderTable(idCar) TABLESPACE TS_USER;

CREATE INDEX idx_idCar ON OrderTable(idClient) TABLESPACE TS_USER;

select * from table(dbms_xplan.display_cursor(sql_id=>'4zag66guk28s9', format=>'ALLSTATS LAST'));
;


--4) db13 ADMINCORE-12345 - creation of all procedures

--procedures for users
--1!) insert new user on signing up
CREATE OR REPLACE PROCEDURE insertuser(
    insertlogin IN account.login%TYPE,
    insertpassword IN account.password%TYPE,
    insertname IN client.name%TYPE,
    insertsurname IN client.surname%TYPE,
    insertage IN client.age%TYPE,
    insertemail IN client.email%TYPE
)
IS
    clientid NUMBER;
    accountid NUMBER;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1 INTO clientid FROM client;
    SELECT COALESCE(MAX(id), 0) + 1 INTO accountid FROM account;
    INSERT INTO client(id, name, surname, age, email)
    VALUES (clientid, insertname, insertsurname, insertage, insertemail);
    INSERT INTO account(id, login, password)
    VALUES (accountid, insertlogin, insertpassword);
    COMMIT;
END;
--test01
EXEC insertuser('123', '123', '123', '123', 19, '123');
delete from Client where id = 7;
--update OrderTable set id = 2 where id = 3; 
select * from Client order by id;


--2!) viewing all Car + Equipment + EquipmentList + Supplier info
create or replace procedure getallcarinfo (
    cars out sys_refcursor
)
IS
BEGIN
    OPEN cars FOR 
    SELECT c.id, c.idsupplier, c.imgsource, c.brand, c.model, c.color, c.weight, c.cost, c.carrating,
    e.idCar, e.idEquipmentList, 
    l.description,
    s.company_name, s.email
    FROM ADMINCORE.Car c
    JOIN ADMINCORE.Equipment e ON c.id = e.idCar
    Join ADMINCORE.EquipmentList l on e.idEquipmentList = l.id
    Join ADMINCORE.Supplier s on c.idSupplier = s.id
    order by id;
END;

--test02
VAR carCursor REFCURSOR;
EXEC getallcarinfo(:carCursor);
PRINT carCursor;
select * from car order by id;


--!!!!! for admin as well
--3!) insert to order table 
CREATE OR REPLACE PROCEDURE AddNewOrder(
    p_id IN INT,
    p_idClient IN INT,
    p_idCar IN INT,
    p_quantity IN INT,
    p_IsTestDrive IN NUMBER
)
IS
BEGIN
    INSERT INTO admincore.OrderTable (id, idClient, idCar, quantity, IsTestDrive)
    VALUES (p_id, p_idClient, p_idCar, p_quantity, p_IsTestDrive);
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('New order has been added successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--test03
EXEC admincore.AddNewOrder(9, 2, 3, 1, 0);
delete from OrderTable where id = 7;
--update OrderTable set id = 2 where id = 3; 
select * from admincore.OrderTable order by id;

--4!) request for test-drive 
CREATE OR REPLACE PROCEDURE UpdateIsTestDrive(orderId IN INT)
IS
BEGIN
  UPDATE admincore.OrderTable SET IsTestDrive = 1 WHERE id = orderId;
  COMMIT;
END;

--test04
EXEC admincore.UpdateIsTestDrive(1);
select * from admincore.OrderTable order by id;
update OrderTable set IsTestDrive = 0 where id = 1;

--5!) request for cancel test-drive
CREATE OR REPLACE PROCEDURE UpdateIsTestDriveToZero(orderId IN INT)
IS
BEGIN
  UPDATE OrderTable SET IsTestDrive = 0 WHERE id = orderId;
  COMMIT;
END;

--test05
EXEC admincore.UpdateIsTestDrive(1);
select * from admincore.OrderTable order by id;
EXEC admincore.UpdateIsTestDriveToZero(1);


--!!!!! for admin as well
--6!) for viewing all clients + account info
CREATE OR REPLACE PROCEDURE getclients(
    clients OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN clients FOR 
    SELECT c.name, c.surname, c.age, c.email, a.login, a.password
    FROM client c
    JOIN account a ON c.id = a.idClient;
END;

--test06
VAR clientCursor REFCURSOR;
EXEC getclients(:clientCursor);
PRINT clientCursor;


--procedures for admin 
--7!) get all orders
create or replace procedure getallOrderinfo (
    orders out sys_refcursor
)
IS
BEGIN
    OPEN orders FOR 
    SELECT o.id, c.brand, c.model, c.weight, c.cost, el.description, cl.name, cl.surname, o.quantity, o.IsTestDrive, o.idCar    
    FROM OrderTable o
    Join Car c on o.idCar = c.id
	JOIN Equipment e ON c.id = e.idCar
    JOIN EquipmentList el ON e.idEquipmentList = el.id
    Join Client cl on o.idClient = cl.id
    order by o.id;
END;

--test07
VAR orderCursor2 REFCURSOR;
EXEC getallOrderinfo(:orderCursor2);
PRINT orderCursor2;
select * from car order by id;


--3) insert of new order is already existing (prcedure -- 3)


--8!) update order table 
CREATE OR REPLACE PROCEDURE UpdateOrder(
    p_id IN INT,
    p_idClient IN INT,
    p_idCar IN INT,
    p_quantity IN INT,
    p_IsTestDrive IN NUMBER
)
IS
BEGIN
    UPDATE OrderTable SET idClient = p_idClient where id = p_id;
    UPDATE OrderTable SET idCar = p_idCar where id = p_id;
    UPDATE OrderTable SET quantity = p_quantity where id = p_id;
    UPDATE OrderTable SET IsTestDrive = p_IsTestDrive where id = p_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Order has been updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;
       
--test08
EXEC UpdateOrder(1, 3, 4, 1, 0);
select * from ordertable order by id;
select * from car order by id;


--9!) delete order table 
CREATE OR REPLACE PROCEDURE DeleteOrder(
    p_id IN INT
)
IS
BEGIN
    DELETE from OrderTable where id = p_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Order has been deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;
       
--test09
EXEC DeleteOrder(3);
select * from ordertable order by id;


--10!) viewing Supplier
create or replace procedure getallsupplierinfo (
    supplier out sys_refcursor
)
IS
BEGIN
    OPEN supplier FOR 
    SELECT id, company_name, email
    FROM Supplier;
END;

--test10
VAR carCursor REFCURSOR;
EXEC getallsupplierinfo(:carCursor);
PRINT carCursor;
select * from car order by id;

--11!) update client table 
CREATE OR REPLACE PROCEDURE UpdateClient(
    p_id in client.id%TYPE,
    insertlogin IN account.login%TYPE,
    insertpassword IN account.password%TYPE,
    insertname IN client.name%TYPE,
    insertsurname IN client.surname%TYPE,
    insertage IN client.age%TYPE,
    insertemail IN client.email%TYPE
)
IS
BEGIN
    UPDATE Account SET login = insertlogin where id = p_id;
    UPDATE Account SET password = insertpassword where id = p_id;
    UPDATE Client SET name = insertname where id = p_id;
    UPDATE Client SET surname = insertsurname where id = p_id;
    UPDATE Client SET age = insertage where id = p_id;
    UPDATE Client SET email = insertemail where id = p_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Client has been updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--12!) update car table
CREATE OR REPLACE PROCEDURE UpdateCar(
    p_id in car.id%TYPE,
    insertbrand IN car.brand%TYPE,
    insertmodel IN car.model%TYPE,
    insertcolor IN car.color%TYPE,
    insertweight IN car.weight%TYPE,
    insertcost IN car.cost%TYPE,
    insertdescription IN equipment.idEquipmentList%TYPE,
    insertcompanyname IN car.idSupplier%TYPE,
    insertratingCar IN car.carrating%TYPE
)
IS
BEGIN
    UPDATE Car SET brand = insertbrand where id = p_id;
    UPDATE Car SET model = insertmodel where id = p_id;
    UPDATE Car SET color = insertcolor where id = p_id;
    UPDATE Car SET weight = insertweight where id = p_id;
    UPDATE Car SET cost = insertcost where id = p_id;
    UPDATE Equipment SET idEquipmentList = insertdescription where idCar = p_id;
    UPDATE Car SET idSupplier = insertcompanyname where id = p_id;
    UPDATE Car SET carrating = insertratingCar where id = p_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Car has been updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--13xx) update supplier table
CREATE OR REPLACE PROCEDURE UpdateSupplier(
    p_id in supplier.id%TYPE,
    insertcompanyName IN supplier.company_name%TYPE,
    insertemail IN supplier.email%TYPE
)
IS
BEGIN
    UPDATE Supplier SET company_name = insertcompanyName where id = p_id;
    UPDATE Supplier SET email = insertemail where id = p_id;
    
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Client has been updated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--14!) insert car table
CREATE OR REPLACE PROCEDURE InsertCar(
    insertbrand IN car.brand%TYPE,
    insertmodel IN car.model%TYPE,
    insertcolor IN car.color%TYPE,
    insertweight IN car.weight%TYPE,
    insertcost IN car.cost%TYPE,
    insertimgsource IN car.imgsource%TYPE,
    insertcompanyname IN car.idSupplier%TYPE,
    insertratingCar IN car.carrating%TYPE
)
IS
    caridNew number;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1 INTO caridNew FROM car;
    INSERT INTO car(id, idSupplier, imgSource, brand, model, color, weight, cost, carrating)
    VALUES (caridNew, insertcompanyname, insertimgsource, insertbrand, insertmodel, insertcolor, insertweight, insertcost, insertratingCar);
    
    COMMIT;    
    DBMS_OUTPUT.PUT_LINE('Car has been inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;


--15!) delete client table
CREATE OR REPLACE PROCEDURE DeleteClient(
    p_id IN INT
)
IS
BEGIN
    DELETE from Client where id = p_id;
    DELETE from Account where idClient = p_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('CLient has been deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--16!) delete car table
CREATE OR REPLACE PROCEDURE DeleteCar(
    p_id IN INT
)
IS
BEGIN
    DELETE from Car where id = p_id;
    DELETE from Equipment where idCar = p_id;
    
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Car has been deleted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--17хх) insert equipment
CREATE OR REPLACE PROCEDURE InsertEquipment(
    insertEquipmentListId equipment.idEquipmentList%TYPE,
    insertCarId equipment.idCar%TYPE
)
IS
    equipmentidNew number;
BEGIN
    SELECT COALESCE(MAX(id), 0) + 1 INTO equipmentidNew FROM equipment;
    insert into equipment (id, idEquipmentList, idCar) 
    VALUES (equipmentidNew, insertEquipmentListId, insertCarId);
    
    COMMIT;    
    DBMS_OUTPUT.PUT_LINE('Equipment has been inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error occured while adding a new order. ' || SQLERRM);
END;

--18!) update quantity
CREATE OR REPLACE PROCEDURE UpdateQuantity(orderId IN INT)
IS
BEGIN
  UPDATE admincore.OrderTable SET Quantity = Quantity + 1 WHERE id = orderId;
  COMMIT;
END;

EXEC admincore.UpdateQuantity(1);
select * from admincore.OrderTable order by id;
update OrderTable set IsTestDrive = 0 where id = 1;
EXEC admincore.UpdateQuantityDecrement(1);
--!
CREATE OR REPLACE PROCEDURE UpdateQuantityDecrement(orderId IN INT)
IS
BEGIN
  UPDATE admincore.OrderTable SET Quantity = Quantity - 1 WHERE id = orderId;
  COMMIT;
END;



--5) xml
E:\Apps\Oracle\oracle\bin\expdp ADMINCORE/12345@db13 tables=Client directory=EXPORT_DIR dumpfile=client.dmp logfile=client.log content=data_only
xsltproc client.xsl client.dmp > client.xml

create or replace procedure XMLImportDriver 
is
    driverid number;
begin
    select count(*) into driverid from driver;
    insert into driver (ID,name, surname, email, age)
    WITH t AS (SELECT xmltype (bfilename ('TEST_DIR', '123.xml'), nls_charset_id('WE8IS08859P1')) xmlcol FROM dual) 
    SELECT
    driverid,
    extractValue(value (x),'/DRIVER/NAME') drivername,
    extractValue(value (x), '/DRIVER/SURNAME') driversurname,
    extractValue(value (x), '/DRIVER/EMAIL') driveremail,
    extractValue(value (x),'/DRIVER/AGE') driverage
    FROM t,TABLE (XMLSequence (extract (t.xmlcol,'/DRIVERS/DRIVER'))) x; 
end;

GRANT CREATE ANY DIRECTORY TO ADMINCORE;
grant drop any DIRECTORY TO ADMINCORE;
GRANT READ, WRITE ON DIRECTORY TEST_DIR TO ADMINCORE;
CREATE DIRECTORY TEST_DIR AS 'E:\Универ\Лабораторные работы\4 семестр\Курсач\DB_Kursovoi_2023\xml';
drop DIRECTORY TEST_DIR;
select * from TEST_DIR;

create or replace procedure XMLImportClient 
is
    clientid number;
begin
    select max(id) into clientid from client;
    insert into client (ID,name, surname, email, age)
    WITH t AS (SELECT xmltype (bfilename ('TEST_DIR', 'clients.xml'), nls_charset_id('WE8IS08859P1')) xmlcol FROM dual) 
    SELECT
    clientid,
    extractValue(value (x),'/CLIENT/NAME') clientname,
    extractValue(value (x), '/CLIENT/SURNAME') clientsurname,
    extractValue(value (x), '/CLIENT/EMAIL') clientemail,
    extractValue(value (x),'/CLIENT/AGE') clientage
    FROM t,TABLE (XMLSequence (extract (t.xmlcol,'/CLIENTS/CLIENT'))) x; 
end;
exec XMLImportClient; 


Create Or Replace Procedure XMLExportDriver (xmlfile varchar2 ) as 
    doc xmldom.DOMDocument;
    ret xmldom.DOMNode;
    peoplenode xmldom.DOMNode;
    Cursor cur_people is select * from driver;
    procedure addperson (doc xmldom.DOMDocument, driver xmldom.DOMNode,
                        v_pid varchar2,v_name varchar2,v_surname varchar2, v_email varchar2,v_age varchar2 )
is
    personelem xmldom.DOMElement; personnode xmldom.DOMNode; itemelem xmldom.DOMElement; itemnode xmldom.DOMNode; 
    text xmldom.DOMText;
begin
    personelem:=xmldom.createElement(doc, ' DRIVER ');
    xmldom.setAttribute(personelem, ' DRIVERID ',v_pid);
    personnode:=xmldom.appendChild(peoplenode,xmldom.makeNode(personelem));
    itemelem:=xmldom.createElement(doc, ' NAME ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_name);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text ));
    itemelem:=xmldom.createElement(doc, ' SURNAME ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem)); 
    text:=xmldom.createTextNode(doc,v_surname);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text )); 
    itemelem:=xmldom.createElement(doc, ' EMAIL ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_email);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text )); 
    itemelem:=xmldom.createElement(doc, ' AGE ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_age);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text ));
end addperson;
begin
    doc:=xmldom.newDOMDocument;
    peoplenode:=xmldom.makeNode(xmldom.createElement(doc, ' DRIVERS '));
    ret:=xmldom.appendChild(xmldom.makeNode(doc), peoplenode);
    For v_row In cur_people loop
        addperson(doc,peoplenode,v_row.id,v_row.name,v_row.surname,v_row.email,v_row.age); 
    End loop;
    xmldom.writeToFile(doc,xmlfile);
    xmldom.freeDocument(doc);
end db2xml;


Create Or Replace Procedure XMLExportClient (xmlfile varchar2 ) as 
    doc xmldom.DOMDocument;
    ret xmldom.DOMNode;
    peoplenode xmldom.DOMNode;
    Cursor cur_people is select * from client;
    procedure addperson (doc xmldom.DOMDocument, client xmldom.DOMNode,
                        v_pid varchar2,v_name varchar2,v_surname varchar2, v_email varchar2,v_age varchar2 )
is
    personelem xmldom.DOMElement; personnode xmldom.DOMNode; itemelem xmldom.DOMElement; itemnode xmldom.DOMNode; 
    text xmldom.DOMText;
begin
    personelem:=xmldom.createElement(doc, ' CLIENT ');
    xmldom.setAttribute(personelem, ' CLIENTID ',v_pid);
    personnode:=xmldom.appendChild(peoplenode,xmldom.makeNode(personelem));
    itemelem:=xmldom.createElement(doc, ' NAME ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_name);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text ));
    itemelem:=xmldom.createElement(doc, ' SURNAME ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem)); 
    text:=xmldom.createTextNode(doc,v_surname);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text )); 
    itemelem:=xmldom.createElement(doc, ' EMAIL ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_email);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text )); 
    itemelem:=xmldom.createElement(doc, ' AGE ' );
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_age);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode( text ));
end addperson;
begin
    doc:=xmldom.newDOMDocument;
    peoplenode:=xmldom.makeNode(xmldom.createElement(doc, ' CLIENTS '));
    ret:=xmldom.appendChild(xmldom.makeNode(doc), peoplenode);
    For v_row In cur_people loop
        addperson(doc,peoplenode,v_row.id,v_row.name,v_row.surname,v_row.email,v_row.age); 
    End loop;
    xmldom.writeToFile(doc,xmlfile);
    xmldom.freeDocument(doc);
end;

BEGIN
    XMLExportClient('TEST_DIR', 'client.xml');
END;





CREATE OR REPLACE PROCEDURE XMLExportClient (
  directory_name IN VARCHAR2,
  xmlfile IN VARCHAR2
) AS 
  doc xmldom.DOMDocument;
  ret xmldom.DOMNode;
  peoplenode xmldom.DOMNode;
  Cursor cur_people is select * from client;
  procedure addperson (
    doc xmldom.DOMDocument, 
    client xmldom.DOMNode,
    v_pid varchar2,
    v_name varchar2,
    v_surname varchar2, 
    v_email varchar2,
    v_age varchar2 
  ) is
    personelem xmldom.DOMElement; 
    personnode xmldom.DOMNode; 
    itemelem xmldom.DOMElement; 
    itemnode xmldom.DOMNode; 
    text xmldom.DOMText;
  begin
    personelem:=xmldom.createElement(doc, 'CLIENT');
    xmldom.setAttribute(personelem, 'CLIENTID',v_pid);
    personnode:=xmldom.appendChild(peoplenode,xmldom.makeNode(personelem));
    itemelem:=xmldom.createElement(doc, 'NAME');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_name);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text));
    itemelem:=xmldom.createElement(doc, 'SURNAME');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem)); 
    text:=xmldom.createTextNode(doc,v_surname);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text)); 
    itemelem:=xmldom.createElement(doc, 'EMAIL');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_email);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text)); 
    itemelem:=xmldom.createElement(doc, 'AGE');
    itemnode:=xmldom.appendChild(personnode,xmldom.makeNode(itemelem));
    text:=xmldom.createTextNode(doc,v_age);
    itemnode:=xmldom.appendChild(itemnode,xmldom.makeNode(text));
  end addperson;
begin
  doc:=xmldom.newDOMDocument;
  peoplenode:=xmldom.makeNode(xmldom.createElement(doc, 'CLIENTS'));
  ret:=xmldom.appendChild(xmldom.makeNode(doc), peoplenode);
  for v_row in cur_people loop
    addperson(
      doc,
      peoplenode,
      v_row.id,
      v_row.name,
      v_row.surname,
      v_row.email,
      v_row.age
    ); 
  end loop;
  xmldom.writeToFile(doc, directory_name, xmlfile);
  xmldom.freeDocument(doc);
end;


BEGIN
  XMLExportClient('TEST_DIR', 'client.xml');
END;
