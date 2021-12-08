CREATE DATABASE rakamin_test;

USE rakamin_test;

CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(30) NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE conversations (
  id INT NOT NULL AUTO_INCREMENT,
  first_user_id INT NOT NULL,
  second_user_id INT NOT NULL,

  PRIMARY KEY(id),
  FOREIGN KEY(first_user_id) REFERENCES users(id),
  FOREIGN KEY(second_user_id) REFERENCES users(id)
);

CREATE TABLE messages (
  id INT NOT NULL AUTO_INCREMENT,
  sender_id INT NOT NULL,
  receiver_id INT NOT NULL,
  text VARCHAR(1000) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW(),
  status ENUM('READ', 'UNREAD') NOT NULL DEFAULT 'UNREAD',
  conversation_id INT NOT NULL,

  PRIMARY KEY(id),
  FOREIGN KEY(sender_id) REFERENCES users(id),
  FOREIGN KEY(receiver_id) REFERENCES users(id),
  FOREIGN KEY(conversation_id) REFERENCES conversations(id)
);
