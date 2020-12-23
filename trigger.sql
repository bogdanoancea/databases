create database punctelucru;
use punctelucru;

CREATE TABLE PuncteLucru (
    id INT AUTO_INCREMENT PRIMARY KEY,
    denumire VARCHAR(100) NOT NULL,
    capacitate INT NOT NULL
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
