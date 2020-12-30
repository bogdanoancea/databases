create database punctelucru;
use punctelucru;

CREATE TABLE PuncteLucru (
    id INT AUTO_INCREMENT PRIMARY KEY,
    denumire VARCHAR(100) NOT NULL,
    capacitate INT NOT NULL
);

CREATE TABLE AuditPuncteLucru(
	id INT AUTO_INCREMENT PRIMARY KEY,
	punctLucruId INT,
	capacitateInainte INT,
	capacitateDupa INT,
	modificatLa TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
 
 
CREATE TABLE StatisticiPuncteLucru(
    capacitateTotala INT NOT NULL
);


DELIMITER $$
CREATE TRIGGER before_insert_pctLucru
BEFORE INSERT
ON PuncteLucru FOR EACH ROW
BEGIN
    DECLARE r INT;
      SELECT COUNT(*) 
    INTO r
    FROM StatisticiPuncteLucru;
    IF r > 0 THEN
        UPDATE StatisticiPuncteLucru
        SET capacitateTotala = capacitateTotala + new.capacitate;
    ELSE
        INSERT INTO StatisticiPuncteLucru(capacitateTotala)
        VALUES(new.capacitate);
    END IF; 
END $$
DELIMITER ;


INSERT INTO PuncteLucru(denumire, capacitate) VALUES('Titan',100);
SELECT * FROM StatisticiPuncteLucru; 
INSERT INTO PuncteLucru(denumire, capacitate) VALUES('EuroGold',200);
SELECT * FROM StatisticiPuncteLucru; 


DELIMITER $$

CREATE TRIGGER after_update_capacitate
AFTER UPDATE
ON PuncteLucru FOR EACH ROW
BEGIN
    IF OLD.capacitate <> new.capacitate THEN
        INSERT INTO AuditPuncteLucru(punctLucruId,capacitateInainte, capacitateDupa)
        VALUES(old.id, old.capacitate, new.capacitate);
    END IF;
END$$

DELIMITER ;

UPDATE PuncteLucru SET Capacitate = 150 WHERE id = 1;
SELECT * FROM AuditPuncteLucru;
UPDATE PuncteLucru SET Capacitate = Capacitate + 10;
SELECT * FROM AuditPuncteLucru;

SHOW TRIGGERS FROM puncteLucru LIKE '%update%';
