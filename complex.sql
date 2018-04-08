SPOOL project.out
SET ECHO ON
DROP TABLE Complex CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Building CASCADE CONSTRAINTS;
DROP TABLE Tenant CASCADE CONSTRAINTS;
DROP TABLE Unit CASCADE CONSTRAINTS;
DROP TABLE Style CASCADE CONSTRAINTS;

CREATE TABLE Complex
(
	id INTEGER PRIMARY KEY,
	location CHAR(25) NOT NULL,
	name CHAR(25) NOT NULL
);

CREATE TABLE Employee
(
	eSSN VARCHAR(9) PRIMARY KEY,
		CONSTRAINT Constraint1 CHECK (REGEXP_LIKE(eSSN, '^[[:digit:]]{9}$')),
	job CHAR(20) NOT NULL, 
		CONSTRAINT Constraint2 CHECK (job IN ('maintenance', 'manager', 'office')),
	lName CHAR(20) NOT NULL, 
	fName CHAR(20) NOT NULL, 
	salary INTEGER NOT NULL,
		CONSTRAINT Constraint3 CHECK (salary >= 20000 AND salary <= 150000),
	complexID INTEGER NOT NULL,
		CONSTRAINT ForeignKey1 FOREIGN KEY (complexID) REFERENCES Complex(id)
			ON DELETE CASCADE,
		CONSTRAINT Constraint4 CHECK (complexID >= 1 AND complexID <= 3),
	homeAddress CHAR(30) NOT NULL
);

CREATE TABLE Building
(
	bNum INTEGER,
	complexID INTEGER,
		CONSTRAINT ForeignKey2 FOREIGN KEY (complexID) REFERENCES Complex(id)
			ON DELETE CASCADE,
		CONSTRAINT Constraint5 PRIMARY KEY (bNum, complexID),
	managerSSN VARCHAR(9), 
		CONSTRAINT Constraint6 CHECK (REGEXP_LIKE(managerSSN, '^[[:digit:]]{9}$'))
);

CREATE TABLE Unit
(
	uNum VARCHAR(10),
	complexID INTEGER,
		CONSTRAINT Constraint8 PRIMARY KEY (uNum, complexID),
	bNum INTEGER,
		CONSTRAINT ForeignKey3 FOREIGN KEY (bNum, complexID) REFERENCES Building(bNum, complexID)
			ON DELETE CASCADE,
	styleType CHAR(20) NOT NULL,
	numBedrooms INTEGER NOT NULL,
		CONSTRAINT ForeignKey4 FOREIGN KEY (styleType, numBedrooms) REFERENCES Style(type, numBedrooms)
			ON DELETE CASCADE,
		CONSTRAINT Constraint9 CHECK (styleType IN ('Loft', 'Flat', 'Studio')),
	price INTEGER NOT NULL
);

CREATE TABLE Tenant
(
	tSSN VARCHAR(9) PRIMARY KEY,
		CONSTRAINT Constraint7 CHECK (REGEXP_LIKE(tSSN, '^[[:digit:]]{9}$')),
	lName CHAR(20) NOT NULL, 
	fName CHAR(20) NOT NULL, 
	dateOfBirth DATE,
	uNum INTEGER NOT NULL,
		CONSTRAINT ForeignKey5 FOREIGN KEY (uNum) REFERENCES Unit(uNum)
			ON DELETE CASCADE,
	leaseEndDate DATE NOT NULL 
);

CREATE TABLE Style
(
	type CHAR(20),
	numBedrooms INTEGER,
		CONSTRAINT Constraint10 PRIMARY KEY (type, numBedrooms),
		CONSTRAINT Constraint11 CHECK (numBedrooms >= 1 AND numBedrooms <=2),
	squareFeet INTEGER
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

INSERT INTO Unit VALUES ('S1', 1, 1, 'Studio', 1, 800);
INSERT INTO Unit VALUES ('S1', 2, 1, 'Studio', 1, 700);
INSERT INTO Unit VALUES ('S1', 3, 1, 'Studio', 1, 1000);
INSERT INTO Unit VALUES ('L1', 1, 2, 'Loft', 2, 1100);
INSERT INTO Unit VALUES ('L1', 2, 2, 'Loft', 1, 900);
INSERT INTO Unit VALUES ('L1', 3, 2, 'Loft', 1, 1200);
INSERT INTO Unit VALUES ('F1', 1, 1, 'Flat', 2, 950);
INSERT INTO Unit VALUES ('F1', 2, 2, 'Flat', 1, 850);
INSERT INTO Unit VALUES ('F1', 3, 2, 'Flat', 2, 1150);

INSERT INTO Style VALUES ('Studio', 1, 400);
INSERT INTO Style VALUES ('Loft', 1, 700);
INSERT INTO Style VALUES ('Loft', 2, 900);
INSERT INTO Style VALUES ('Flat', 1, 750);
INSERT INTO Style VALUES ('Flat', 2, 950);

COMMIT;

SELECT * FROM Complex;
SELECT * FROM Employee;
SELECT * FROM Building;
SELECT * FROM Tenant;
SELECT * FROM Unit;
SELECT * FROM Style;

SET ECHO OFF
SPOOL OFF 