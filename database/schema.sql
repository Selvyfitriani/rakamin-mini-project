CREATE DATABASE rakamin_test;

USE rakamin_test;

CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(30) NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY(id)
)
