CREATE DATABASE rakamin_db;

USE rakamin_db;

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

INSERT INTO users(id, username, name) VALUES (1, 'selvy31', 'Selvy Fitriani');
INSERT INTO users(id, username, name) VALUES (2, 'rangga123', 'Rangga Fahreran');
INSERT INTO users(id, username, name) VALUES (3, 'shireen10', 'Shireen');

INSERT INTO conversations(id, first_user_id, second_user_id) VALUES (1, 1, 2);
INSERT INTO conversations(id, first_user_id, second_user_id) VALUES (2, 1, 3);
INSERT INTO conversations(id, first_user_id, second_user_id) VALUES (3, 2, 3);

INSERT INTO messages(id, sender_id, receiver_id, text, conversation_id) VALUES (1, 1, 2, 'Halo Rangga', 1);
INSERT INTO messages(id, sender_id, receiver_id, text, conversation_id) VALUES (2, 2, 1, 'Halo Selvy', 1);
INSERT INTO messages(id, sender_id, receiver_id, text, conversation_id) VALUES (3, 2, 3, 'Semangat!', 3);
