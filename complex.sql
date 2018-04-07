SPOOL project.out
SET ECHO ON
DROP TABLE Complex CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Building CASCADE CONSTRAINTS;
DROP TABLE Tenant CASCADE CONSTRAINTS;
DROP TABLE Unit CASCADE CONSTRAINTS;
--DROP TABLE Style CASCADE CONSTRAINTS;

CREATE TABLE Complex
(
	id INTEGER PRIMARY KEY,
	location CHAR(25) NOT NULL,
	name CHAR(25) NOT NULL
);

CREATE TABLE Employee
(
	eSSN VARCHAR(9) PRIMARY KEY,
		CONSTRAINT C1 CHECK (REGEXP_LIKE(eSSN, '^[[:digit:]]{9}$')),
	job CHAR(20) NOT NULL, 
		CONSTRAINT C2 CHECK (job IN ('maintenance', 'manager', 'office')),
	lName CHAR(20) NOT NULL, 
	fName CHAR(20) NOT NULL, 
	salary INTEGER NOT NULL,
		CONSTRAINT C3 CHECK (salary >= 20000 AND salary <= 150000),
	complexID INTEGER NOT NULL,
		CONSTRAINT C4 CHECK (complexID >= 1 AND complexID <= 3),
	homeAddress CHAR(30) NOT NULL
);

CREATE TABLE Building
(
	bNum INTEGER ,
	complexID INTEGER,
		CONSTRAINT C5 PRIMARY KEY (bNum, complexID),
	managerSSN VARCHAR(9), 
		CONSTRAINT C6 CHECK (REGEXP_LIKE(managerSSN, '^[[:digit:]]{9}$'))
);

CREATE TABLE Tenant
(
	tSSN VARCHAR(9) PRIMARY KEY,
		CONSTRAINT C7 CHECK (REGEXP_LIKE(tSSN, '^[[:digit:]]{9}$')),
	lName CHAR(20) NOT NULL, 
	fName CHAR(20) NOT NULL, 
	dateOfBirth DATE,
	uNum INTEGER NOT NULL,
	leaseEndDate DATE NOT NULL 
);

CREATE TABLE Unit
(
	uNum INTEGER,
	bNum INTEGER,
	complexID INTEGER,
		CONSTRAINT C8 PRIMARY KEY (uNum, bNum, complexID),
	styleType CHAR(20) NOT NULL,
		CONSTRAINT C9 CHECK (styleType IN ('Loft', 'Flat', 'Studio')),
	price INTEGER NOT NULL
);

CREATE TABLE Style
(
	styleType CHAR(20),
	numBedrooms INTEGER,
		CONSTRAINT C10 PRIMARY KEY (styleType, numBedrooms),
		CONSTRAINT C11 CHECK (numBedrooms >= 1 AND numBedrooms <=2),
	squareFeet INTEGER,
	price INTEGER
);

SET AUTOCOMMIT 

INSERT INTO Complex VALUES (1, '123 Division Ave', 'Applewood');
INSERT INTO Complex VALUES (2, '4987 48th Ave', 'Orangewood');
INSERT INTO Complex VALUES (3, '398 W Fulton St', 'Peachwood');

INSERT INTO Employee VALUES ('123456789', 'maintenance',' Ramsey', 'Raymond',55000, 1, '121 Hillcrest Circle');
INSERT INTO Employee VALUES ('662374875', 'maintenance', 'Frank', 'Becky',60000, 3, '1357 Heavner Court');
INSERT INTO Employee VALUES ('234673456', 'manager', 'Rose',' Betty', 120000, 1, '1491 Beeghley Street');
INSERT INTO Employee VALUES ('178962387', 'maintenance', 'Flores', 'Cameron', 54000, 2, '4271 Monroe Street');
INSERT INTO Employee VALUES ('209387455', 'manager', 'Page','Cindy', 130000, 3, '563 Heavens Way');
INSERT INTO Employee VALUES ('109283744', 'manager', 'Casey','Ken', 145000, 2, '996 Ashmor Drive');
INSERT INTO Employee VALUES ('094582375', 'manager', 'Maywhether','Floyd', 125000, 2, '720 Crestwood Drive');
INSERT INTO Employee VALUES ('230894755', 'manager', 'Johnson','Calvin', 105000, 3, '44 Fulton Street');

INSERT INTO Building VALUES (1, 1, '234673456');
INSERT INTO Building VALUES (2, 1, '234673456');
INSERT INTO Building VALUES (1, 2, '094582375');
INSERT INTO Building VALUES (2, 2, '109283744');
INSERT INTO Building VALUES (1, 3, '230894755');
INSERT INTO Building VALUES (2, 3, '209387455');

INSERT INTO Tenant VALUES ('837466129', 'Henderson', 'Alice', TO_DATE('10/10/94', 'MM/DD/YY'), 1, TO_DATE('10/01/18', 'MM/DD/YY'));
INSERT INTO Tenant VALUES ('908237458', 'Guerrero', 'Cameron', TO_DATE('03/08/92', 'MM/DD/YY'),1, TO_DATE('10/01/18', 'MM/DD/YY'));
INSERT INTO Tenant VALUES ('198236743', 'Norman', 'Jamie', TO_DATE('09/12/87', 'MM/DD/YY'), 2, TO_DATE('07/01/18', 'MM/DD/YY'));

INSERT INTO Unit VALUES (1, 1, 1, 'Studio', 800);
INSERT INTO Unit VALUES (2, 1, 2, 'Studio', 700);
INSERT INTO Unit VALUES (1, 1, 3, 'Studio', 1000);
INSERT INTO Unit VALUES (2, 2, 1, 'Loft', 1000);
INSERT INTO Unit VALUES (1, 2, 2, 'Loft', 900);
INSERT INTO Unit VALUES (1, 2, 3, 'Loft', 1200);
INSERT INTO Unit VALUES (2, 1, 1, 'Flat', 950);
INSERT INTO Unit VALUES (1, 2, 2, 'Flat', 850);
INSERT INTO Unit VALUES (1, 2, 3, 'Flat', 1150);

INSERT INTO Style VALUES (1, '123 Division Ave', 'Applewood');
INSERT INTO Style VALUES (2, '4987 48th Ave', 'Orangewood');



COMMIT;

-- SELECT * FROM Complex;
-- SELECT * FROM Employee;



SET ECHO OFF
SPOOL OFF 