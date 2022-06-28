--creating tables (rezepten)and towels for categories (vegan, vegetarian)
CREATE TABLE rezepten(
    rezept_id INT(11)  PRIMARY KEY AUTO_INCREMENT,
    rezept_name VARCHAR(50) NOT NULL,
    beschreibung TEXT NOT NULL,
    bild_Url TEXT 
     );
CREATE TABLE vegan(
    id INT(11)  PRIMARY KEY AUTO_INCREMENT,
    rezept_id INT(11) NOT NULL,
    CONSTRAINT FK_rezeptenvegan FOREIGN KEY(rezept_id) REFERENCES rezepten(rezept_id),
     );
CREATE TABLE vegetarisch(
    id INT(11)  PRIMARY KEY AUTO_INCREMENT,
    rezept_id INT(11) NOT NULL,
    CONSTRAINT FK_rezeptenvegetarisch FOREIGN KEY(rezept_id) REFERENCES rezepten(rezept_id),
     );
-- queryres start
