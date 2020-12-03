CREATE DATABASE COMPANIE;
USE COMPANIE;

CREATE TABLE ANGAJATI
( Prenume        VARCHAR(10)   NOT NULL,
  Initiala       CHAR,
  Nume           VARCHAR(20)      NOT NULL,
  CNP            CHAR(9)          NOT NULL,
  Data_nastere   DATE,
  Adresa         VARCHAR(30),
  Sex            CHAR(1),
  Salariu        DECIMAL(5),
  CNP_superior   CHAR(9),
  Nr_departament INT               NOT NULL,
PRIMARY KEY   (CNP));

CREATE TABLE DEPARTAMENTE
( Nume_departament   VARCHAR(15)       NOT NULL,
  Nr_departament     INT               NOT NULL,
  CNP_manager        CHAR(9)           NOT NULL,
  Manager_datastart  DATE,
PRIMARY KEY (Nr_departament),
UNIQUE      (Nume_departament),
FOREIGN KEY (CNP_manager) REFERENCES ANGAJATI(CNP) );

CREATE TABLE LOCATII_DEPARTAMENTE
( Nr_departament         INT               NOT NULL,
  Locatie_departament    VARCHAR(15)       NOT NULL,
PRIMARY KEY (Nr_departament, Locatie_departament),
FOREIGN KEY (Nr_departament) REFERENCES DEPARTAMENTE(Nr_departament) );

CREATE TABLE PROIECTE
( Nume_proiect       VARCHAR(15)       NOT NULL,
  Nr_proiect         INT               NOT NULL,
  Locatie_proiect    VARCHAR(15),
  Nr_departament     INT               NOT NULL,
PRIMARY KEY (Nr_proiect),
UNIQUE      (Nume_proiect),
FOREIGN KEY (Nr_departament) REFERENCES DEPARTAMENTE(Nr_departament) );

CREATE TABLE LUCREAZA
( CNP_angajat      CHAR(9)           NOT NULL,
  Nr_proiect       INT               NOT NULL,
  Nr_ore           DECIMAL(3,1)      NOT NULL,
PRIMARY KEY (CNP_angajat, Nr_proiect),
FOREIGN KEY (CNP_angajat) REFERENCES ANGAJATI(CNP),
FOREIGN KEY (Nr_proiect) REFERENCES PROIECTE(Nr_proiect) );

CREATE TABLE DEPENDENT
( CNP_angajat            CHAR(9)           NOT NULL,
  Nume_dependent  VARCHAR(15)       NOT NULL,
  Sex             CHAR,
  Data_nastere           DATE,
  Relatie_dependenta    VARCHAR(8),
PRIMARY KEY (CNP_angajat, Nume_dependent),
FOREIGN KEY (CNP_angajat) REFERENCES ANGAJATI(CNP) );

INSERT INTO ANGAJATI
VALUES      ('Ion','B','Popescu',123456789,'1965-01-09','Bld. Timisoara 12, Bucuresti','M',30000,333445555,5),
            ('Vasile','T','Ionescu',333445555,'1965-12-08','Bl. Camil Ressu 33, Bucuresti','M',40000,888665555,5),
            ('Alice','J','Smarandescu',999887777,'1968-01-19','Calea Bucuresti 76, Craiova','F',25000,987654321,4),
            ('Georgeta','S','Vasilescu',987654321,'1941-06-20','Str. Vitan 21, Bucuresti','F',43000,888665555,4),
            ('Radu','K','Negoiescu',666884444,'1962-09-15','Str. Tomis 65, Bucuresti','M',38000,333445555,5),
            ('Jean','A','Romanu',453453453,'1972-07-31','Str. Dristor 1, Bucuresti','F',25000,333445555,5),
            ('Adrian','V','Jebeleanu',987987987,'1969-03-29','Str. Academiei 34, Bucuresti','M',25000,987654321,4),
            ('Marian','E','Borgianu',888665555,'1937-11-10','Str. Ateneului 6, Bucuresti','M',55000,null,1);

INSERT INTO DEPARTAMENTE
VALUES      ('Cercetare',5,333445555,'1988-05-22'),
            ('Administratie',4,987654321,'1995-01-01'),
            ('',1,888665555,'1981-06-19');

INSERT INTO PROIECTE
VALUES      ('ProdusX',1,'Bucuresti',5),
            ('ProdusY',2,'Cluj',5),
            ('ProdusZ',3,'Craiova',5),
            ('Digitalizare',10,'Cluj',4),
            ('Reorganizare',20,'Bucuresti',1),
            ('BeneficiiClient',30,'Cluj',4);

INSERT INTO LUCREAZA
VALUES     (123456789,1,32.5),
           (123456789,2,7.5),
           (666884444,3,40.0),
           (453453453,1,20.0),
           (453453453,2,20.0),
           (333445555,2,10.0),
           (333445555,3,10.0),
           (333445555,10,10.0),
           (333445555,20,10.0),
           (999887777,30,30.0),
           (999887777,10,10.0),
           (987987987,10,35.0),
           (987987987,30,5.0),
           (987654321,30,20.0),
           (987654321,20,15.0),
           (888665555,20,16.0);

INSERT INTO DEPENDENT
VALUES      (333445555,'Alice','F','1986-04-04','Fiica'),
            (333445555,'Teodor','M','1983-10-25','Fiu'),
            (333445555,'Ioana','F','1958-05-03','Sotie'),
            (987654321,'Anghel','M','1942-02-28','Sot'),
            (123456789,'Mihai','M','1988-01-04','Fiu'),
            (123456789,'Alice','F','1988-12-30','Fiica'),
            (123456789,'Elisabeta','F','1967-05-05','Sotie');

INSERT INTO LOCATII_DEPARTAMENTE
VALUES      (1,'Bucuresti'),
            (4,'Cluj'),
            (5,'Craiova'),
            (5,'Cluj'),
            (5,'Bucuresti');

ALTER TABLE DEPARTAMENTE
 ADD CONSTRAINT Dep_ang FOREIGN KEY (CNP_manager) REFERENCES ANGAJATI(CNP);
ALTER TABLE ANGAJATI
 ADD CONSTRAINT Ang_ang FOREIGN KEY (CNP_superior) REFERENCES ANGAJATI(CNP);
ALTER TABLE ANGAJATI
 ADD CONSTRAINT Ang_nrDep FOREIGN KEY  (Nr_departament) REFERENCES DEPARTAMENTE(Nr_departament);
ALTER TABLE ANGAJATI
 ADD CONSTRAINT Ang_superior FOREIGN KEY  (CNP_superior) REFERENCES ANGAJATI(CNP);





SELECT data_nastere, adresa FROM ANGAJATI WHERE Prenume='Ion' AND Initiala = 'B' AND Nume = 'Popescu';
SELECT Nume, Prenume,Adresa FROM ANGAJATI, DEPARTAMENTE WHERE Nume_departament = 'Cercetare' AND DEPARTAMENTE.Nr_departament = ANGAJATI.Nr_departament;
SELECT A.Nume, A.Prenume, B.Nume, B.Prenume FROM ANGAJATI AS A, ANGAJATI AS B WHERE A.CNP_superior = B.CNP;
SELECT CNP FROM ANGAJATI;
SELECT CNP, Nume_departament FROM ANGAJATI, DEPARTAMENTE;
SELECT * FROM ANGAJATI WHERE Nr_departament = 5;
SELECT * FROM ANGAJATI, DEPARTAMENTE WHERE Nume_departament='Cercetare' AND ANGAJATI.Nr_departament=DEPARTAMENTE.Nr_departament;
SELECT Salariu FROM ANGAJATI;
SELECT DISTINCT Salariu FROM ANGAJATI;
SELECT Nume, Prenume, Salariu FROM ANGAJATI ORDER BY Salariu ASC;
SELECT Nume, Prenume, Salariu FROM ANGAJATI ORDER BY Nume DESC;
SELECT Nume, Prenume, Salariu FROM ANGAJATI WHERE Salariu BETWEEN 30000 AND 50000;
SELECT Nume_proiect FROM PROIECTE WHERE Locatie_proiect IN ('Cluj', 'Craiova');



